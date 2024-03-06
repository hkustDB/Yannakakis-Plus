import pandas as pd
import math
import queue

from jointree import Edge, JoinTree
from treenode import *
from sys import maxsize

STATIS_PATH="/Users/cbn/Desktop/SQLRewriter/query/"

def input_car_ndv():
    try:
        data_tpch = pd.read_excel(STATIS_PATH + 'tpch.xlsx', header=None, keep_default_na=False)
        data_lsqb = pd.read_excel(STATIS_PATH + 'lsqb.xlsx', header=None, keep_default_na=False)
        tpch = data_tpch.values.tolist()
        lsqb = data_lsqb.values.tolist()
        sta_tpch = dict()
        sta_lsqb = dict()
        for table in tpch:
            name = table[0]
            col_sta = []
            for col in table[1:]:
                if col != '':
                    cardinality, ndv = int(col.split(';')[0]), int(col.split(';')[1])
                    col_sta.append([cardinality, ndv])
            sta_tpch[name] = col_sta
        for table in lsqb:
            name = table[0]
            col_sta = []
            for col in table[1:]:
                if col != '':
                    cardinality, ndv = int(col.split(';')[0]), int(col.split(';')[1])
                    col_sta.append([cardinality, ndv])
            sta_lsqb[name] = col_sta
    
        return sta_tpch, sta_lsqb
    except:
        return None, None

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
    
    def calJoinStatistic(node: TreeNode):
        if node.parent != None:
            joinKey = list(set(node.cols) & set(node.parent.cols))
            if len(joinKey):
                idx = node.cols.index(joinKey[0])
                try:
                    return statistics[node.source][idx]
                except:
                    cardi, ndv = 0, 0
                    for source in eval(node.source):
                        for sta in statistics[source]:
                            cardi += sta[0]
                            ndv += sta[1]
                    return [cardi, ndv]
                    
            else:
                cost_sum = -1
                for each in statistics[node.source]:
                    if each[0] / each[1] > cost_sum:
                        return each
        return -1
    
    def getAncestors(node: TreeNode):
        anscestors = set()
        temp = node
        while temp.parent:
            anscestors.add(temp.parent)
            temp = temp.parent
        return anscestors
    
    for node in all_jt_nodes:
        if node.isLeaf and not node.isRoot:
            node.setAnscestors = getAncestors(node)
            all_ansestors |= node.setAnscestors
            leaf_nodes.append(node)
            node.statistics = calJoinStatistic(node)
            if node.statistics == -1:   # no joinkey
                raise RuntimeError("This is root node")
    
    for node in all_jt_nodes:
        if not node.isRoot and not node.isLeaf and node in all_ansestors:
            min_ndv = maxsize
            cur_cost = 1.0
            for leaf in leaf_nodes:
                if node in leaf.anscestors:
                    min_ndv = min(min_ndv, node.statistics[1])
                    cur_cost = cur_cost * node.statistics[0] / node.statistics[1]
            cur_cost = cur_cost * min_ndv
            cost_estimate += cur_cost
    
    return cost_height, cost_fanout, cost_estimate


def getEstimation(DDL_NAME: str, jt: JoinTree):
    sta_tpch, sta_lsqb = input_car_ndv()
    if DDL_NAME == 'tpch':
        return cal_cost(sta_tpch, jt)
    elif DDL_NAME == 'lsqb':
        return cal_cost(sta_lsqb, jt)
    else:
        return cal_cost(None, jt)
