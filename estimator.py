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
            data_tpch = pd.read_excel(BASE_PATH + 'tpch.xlsx', header=None, keep_default_na=False)
            tpch = data_tpch.values.tolist()
            sta_tpch = dict()
            for table in tpch:
                name = table[0]
                col_sta = []
                for col in table[1:]:
                    if col != '':
                        if col.split(';')[1] == '':
                            cardinality, ndv = int(col.split(';')[0]), int(col.split(';')[0])
                        else:
                            cardinality, ndv = int(col.split(';')[0]), int(col.split(';')[1])
                        col_sta.append([cardinality, ndv])
                sta_tpch[name] = col_sta
            return sta_tpch
        elif DDL_NAME == 'lsqb':
            data_lsqb = pd.read_excel(BASE_PATH + 'lsqb.xlsx', header=None, keep_default_na=False)
            lsqb = data_lsqb.values.tolist()
            sta_lsqb = dict()
            for table in lsqb:
                name = table[0]
                col_sta = []
                for col in table[1:]:
                    if col != '':
                        if col.split(';')[1] == '':
                            cardinality, ndv = int(col.split(';')[0]), int(col.split(';')[0])
                        else:
                            cardinality, ndv = int(col.split(';')[0]), int(col.split(';')[1])
                        col_sta.append([cardinality, ndv])
                sta_lsqb[name] = col_sta
            return sta_lsqb
        elif DDL_NAME == 'job':
            data_job = pd.read_excel(BASE_PATH + 'job.xlsx', header=None, keep_default_na=False)
            job = data_job.values.tolist()
            sta_job = dict()
            for table in job:
                name = table[0]
                col_sta = []
                for col in table[1:]:
                    if col != '':
                        if col.split(';')[1] == '':
                            cardinality, ndv = int(col.split(';')[0]), int(col.split(';')[0])
                        else:
                            cardinality, ndv = int(col.split(';')[0]), int(col.split(';')[1])
                        col_sta.append([cardinality, ndv])
                sta_job[name] = col_sta
            return sta_job
        
        elif DDL_NAME == 'graph':
            data_graph = pd.read_excel(BASE_PATH + 'graph.xlsx', header=None, keep_default_na=False)
            graph = data_graph.values.tolist()
            sta_graph = dict()
            for table in graph:
                name = table[0]
                col_sta = []
                for col in table[1:]:
                    if col != '':
                        if col.split(';')[1] == '':
                            cardinality, ndv = int(col.split(';')[0]), int(col.split(';')[0])
                        else:
                            cardinality, ndv = int(col.split(';')[0]), int(col.split(';')[1])
                        col_sta.append([cardinality, ndv])
                sta_graph[name] = col_sta
            return sta_graph


    except:
        traceback.print_exc()
        return None, None, None

def cal_cost(statistics: dict[str, list[list[int, int]]], jt: JoinTree):
    cost_height = jt.root.depth
    cost_fanout = jt.root.fanout
    cost_estimate = 0.0
    hasAlias = True if globalVar.get_value("DDL_NAME") == 'job.ddl' else False
    
    if statistics == None:
        return cost_height, cost_fanout, cost_estimate

    all_jt_nodes = set()

    for edge in jt.edge.values():
        all_jt_nodes.add(edge.src)
        all_jt_nodes.add(edge.dst)

    all_jt_nodes = list(all_jt_nodes)
    all_jt_nodes.sort(key=lambda x: x.depth)
    
    def calJoinStatistic(node: TreeNode):
        staP, staC = [], []
        if node.parent != None:
            joinKey = list(set(node.reserve) & set(node.parent.cols))
            if len(joinKey):
                try:
                    idx = node.cols.index(joinKey[0])
                except:
                    idx = 0
                try:
                    if not hasAlias:
                        staP = statistics[node.source][idx]
                    else:
                        staP = statistics[re.sub(r'[0-9]+', '', node.source)][idx]
                except:
                    # bag
                    cardi, ndv = 1, 1
                    for source in eval(node.source):
                        if not hasAlias:
                            cardi *= statistics[source][0][0]
                            ndv *= statistics[source][0][1]
                        else:
                            cardi *= statistics[re.sub(r'[0-9]+', '', source)][0][0]
                            ndv *= statistics[re.sub(r'[0-9]+', '', source)][0][1]
                    staP = [cardi, ndv]
            else:
                staP = [1, 1]
                print("No join key")
        else:
            try:
                if not hasAlias:
                    staP = statistics[node.source][0]
                else:
                    staP = statistics[re.sub(r'[0-9]+', '', node.source)][0]
            except:
                    # bag
                    cardi, ndv = 1, 1
                    try:
                        for source in eval(node.source):
                            if not hasAlias:
                                cardi *= statistics[source][0][0]
                                ndv *= statistics[source][0][1]
                            else:
                                cardi *= statistics[re.sub(r'[0-9]+', '', source)][0][0]
                                ndv *= statistics[re.sub(r'[0-9]+', '', source)][0][1]
                    except:
                        # Bag AUx
                        pass

                    staP = [cardi, ndv]

        if len(node.children):
            for child in node.children:
                joinKey = list(set(node.cols) & set(child.reserve))
                if len(joinKey):
                    try:
                        idx = node.cols.index(joinKey[0])
                    except:
                        idx = 0
                    try:
                        if not hasAlias:
                            if not len(staC):
                                staC = statistics[node.source][idx]
                            elif staC[1] < statistics[node.source][idx][1]:
                                staC = statistics[node.source][idx]
                        else:
                            if not len(staC):
                                staC = statistics[re.sub(r'[0-9]+', '', node.source)][idx]
                            elif staC[1] < statistics[re.sub(r'[0-9]+', '', node.source)][idx][1]:
                                staC = statistics[re.sub(r'[0-9]+', '', node.source)][idx]
                    except:
                        # bag
                        cardi, ndv = 1, 1
                        try:
                            for source in eval(node.source):
                                if not hasAlias:
                                    cardi *= statistics[source][0][0]
                                    ndv *= statistics[source][0][1]
                                else:
                                    cardi *= statistics[re.sub(r'[0-9]+', '', source)][0][0]
                                    ndv *= statistics[re.sub(r'[0-9]+', '', source)][0][1]
                            if not len(staC):
                                staC = [cardi, ndv]
                            elif staC[1] < ndv:
                                staC = [cardi, ndv]
                        except:
                            pass

                else:
                    staC = [1, 1]
                    print("No join key")
                    # raise RuntimeError("No join key")
        else:
            if '[' in node.source:
                cardi, ndv = 1, 1
                for s in eval(node.source):
                    cardi *= statistics[source][0][0]
                    ndv *= statistics[source][0][1]
                staC = [cardi, ndv]
            else:
                staC = statistics[node.source][0]
        
        return staP, staC, staP[0]

    for node in all_jt_nodes:
        node.statistics, node.statisticsC, node.trueSize = calJoinStatistic(node)
        node.estimateSize = node.trueSize
        for child in node.children:
            node.allchildren |= child.allchildren
            node.allchildren.add(child)
    
    join_cost, view_cost = 0.0, 0.0
    for node in all_jt_nodes:
        if len(node.children):
            min_ndv = maxsize
            inter_size = 1.0
            
            node.children.sort(key=lambda x: x.trueSize)
            for child in node.children:
                if node.relationType == RelationType.AuxiliaryRelation and child.id == node.supRelationId:
                    continue
                min_ndv = min(min_ndv, child.statistics[1], node.statisticsC[1])

                if child.estimateSize < child.statistics[1]:
                    child.statistics[1] = child.estimateSize
                if node.estimateSize < node.statisticsC[1]:
                    node.statisticsC[1] = node.estimateSize

                inter_size = min_ndv * child.estimateSize / child.statistics[1] * node.estimateSize / node.statisticsC[1]
                node.estimateSize = inter_size
                view_cost += child.estimateSize / child.statistics[1]
                join_cost += inter_size
            
        else:
            node.estimateSize = node.statistics[0]
        nodeId = node.id
        jt.node[nodeId] = node

    cost_estimate = -0.000000173953612 * join_cost + 0.000000151063199 * view_cost + 3.969433084056
    
    if cost_estimate < 0:
        cost_estimate = 0.000000261898682 * join_cost + 0.000000124901126 * view_cost

    return cost_height, cost_fanout, cost_estimate


def getEstimation(DDL_NAME: str, jt: JoinTree):
    sta = input_car_ndv(DDL_NAME)
    if DDL_NAME == 'tpch' or DDL_NAME == 'lsqb' or DDL_NAME == 'job' or DDL_NAME == 'graph':
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