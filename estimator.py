import pandas as pd
import math
import queue
import traceback
import globalVar
import re

from jointree import Edge, JoinTree
from treenode import *
from sys import maxsize
from random import choice

STATIS_PATH="/Users/cbn/Desktop/SQLRewriter/"

def input_car_ndv(DDL_NAME: str):
    try:
        BASE_PATH = globalVar.get_value('BASE_PATH')
        if DDL_NAME == 'tpch':
            data_tpch = pd.read_excel(STATIS_PATH + BASE_PATH + 'tpch.xlsx', header=None, keep_default_na=False)
            tpch = data_tpch.values.tolist()
            sta_tpch = dict()
            for table in tpch:
                name = table[0]
                col_sta = []
                for col in table[1:]:
                    if col != '':
                        cardinality, ndv = int(col.split(';')[0]), int(col.split(';')[1])
                        col_sta.append([cardinality, ndv])
                sta_tpch[name] = col_sta
            return sta_tpch
        elif DDL_NAME == 'lsqb':
            data_lsqb = pd.read_excel(STATIS_PATH +  BASE_PATH + 'lsqb.xlsx', header=None, keep_default_na=False)
            lsqb = data_lsqb.values.tolist()
            sta_lsqb = dict()
            for table in lsqb:
                name = table[0]
                col_sta = []
                for col in table[1:]:
                    if col != '':
                        cardinality, ndv = int(col.split(';')[0]), int(col.split(';')[1])
                        col_sta.append([cardinality, ndv])
                sta_lsqb[name] = col_sta
            return sta_lsqb
        else:
            data_job = pd.read_excel(STATIS_PATH +  BASE_PATH + 'job.xlsx', header=None, keep_default_na=False)
            job = data_job.values.tolist()
            sta_job = dict()
            for table in job:
                name = table[0]
                col_sta = []
                for col in table[1:]:
                    if col != '':
                        cardinality, ndv = int(col.split(';')[0]), int(col.split(';')[1])
                        col_sta.append([cardinality, ndv])
                sta_job[name] = col_sta
            return sta_job

    except:
        traceback.print_exc()
        return None, None, None

def cal_cost(statistics: dict[str, list[list[int, int]]], jt: JoinTree):
    cost_height = jt.root.depth
    cost_fanout = jt.root.fanout
    cost_estimate = 0.0
    
    if statistics == None:
        return cost_height, cost_fanout, cost_estimate

    leaf_nodes = []
    all_ansestors = set()
    all_jt_nodes = set()

    for edge in jt.edge.values():
        all_jt_nodes.add(edge.src)
        all_jt_nodes.add(edge.dst)

    all_jt_nodes = list(all_jt_nodes)
    all_jt_nodes.sort(key=lambda x: x.depth)
    
    def calJoinStatistic(node: TreeNode):
        staP, staC = [], []
        if node.parent != None:
            joinKey = list(set(node.cols) & set(node.parent.cols))
            if len(joinKey) >= 2:
                staP = [1, 1]
            elif len(joinKey) == 1:
                idx = node.cols.index(joinKey[0])
                try:
                    staP = statistics[re.sub(r'[0-9]+', '', node.source)][idx]
                except:
                    # bag
                    cardi, ndv = 0, 0
                    for source in eval(node.source):
                        cardi *= statistics[re.sub(r'[0-9]+', '', source)][0][0]
                        ndv *= statistics[re.sub(r'[0-9]+', '', source)][0][1]
                    staP = [cardi, ndv]
            else:
                raise RuntimeError("No join key")
        else:
            staP = statistics[re.sub(r'[0-9]+', '', node.source)][0]

        if len(node.children):
            for child in node.children:
                joinKey = list(set(node.cols) & set(child.cols))
                if len(joinKey) >= 2:
                    staC = [1, 1]
                elif len(joinKey) == 1:
                    idx = node.cols.index(joinKey[0])
                    try:
                        if not len(staC):
                            staC = statistics[re.sub(r'[0-9]+', '', node.source)][idx]
                        elif staC[1] < statistics[re.sub(r'[0-9]+', '', node.source)][idx][1]:
                            staC = statistics[re.sub(r'[0-9]+', '', node.source)][idx]
                    except:
                        # bag
                        cardi, ndv = 1, 1
                        for source in eval(node.source):
                            cardi *= statistics[re.sub(r'[0-9]+', '', source)][0][0]
                            ndv *= statistics[re.sub(r'[0-9]+', '', source)][0][1]
                        if not len(staC):
                            staC = [cardi, ndv]
                        elif staC[1] < ndv:
                            staC = [cardi, ndv]

                else:
                    raise RuntimeError("No join key")
        else:
            staC = statistics[node.source][0]
        
        return staP, staC, staP[0]

    for node in all_jt_nodes:
        node.statistics, node.statisticsC, node.trueSize = calJoinStatistic(node)
        node.estimateSize = node.trueSize
        for child in node.children:
            node.allchildren |= child.allchildren
            node.allchildren.add(child)
    
    for node in all_jt_nodes:
        if len(node.allchildren):
            min_ndv = maxsize
            cur_cost = 1.0
            node.allchildren = list(node.allchildren)
            node.allchildren.sort(key=lambda x: x.trueSize)
            for child in node.allchildren:
                if node.relationType == RelationType.AuxiliaryRelation and child.id == node.supRelationId:
                    continue
                min_ndv = min(min_ndv, child.statistics[1])
                cur_cost = cur_cost * child.statistics[0] / child.statistics[1]

                cost_estimate += min(min_ndv, node.statisticsC[1]) * cur_cost * node.estimateSize / node.statisticsC[1]
                node.estimateSize = min(min_ndv, node.statisticsC[1]) * cur_cost * node.estimateSize / node.statisticsC[1]
            
            node.estimateSize = min(min_ndv, node.statisticsC[1]) * cur_cost * node.statisticsC[0] / node.statisticsC[1]
        else:
            node.estimateSize = node.statistics[0]
        nodeId = node.id
        jt.node[nodeId] = node
    
    return cost_height, cost_fanout, cost_estimate


def getEstimation(DDL_NAME: str, jt: JoinTree):
    sta = input_car_ndv(DDL_NAME)
    if DDL_NAME == 'tpch' or DDL_NAME == 'lsqb' or DDL_NAME == 'job':
        return cal_cost(sta, jt)
    else:
        return cal_cost(None, jt)

def selectBest(cost_stat: list[list[int]], limit: int = 1) -> int:
    # index, cost_height, cost_fanout, cost_estimate
    if not len(cost_stat):
        return [0]
    cost_stat.sort(key=lambda x: (x[3], x[2], -x[1]))
    res = []
    for i in range(min(limit, len(cost_stat))):
        res.append(cost_stat[i][0])
    return res