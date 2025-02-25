"""
Usage:
  main.py <query> <ddl> [options]
  
Options:
  -h --help     Show help.
  <query>       Set execute query path, like topk1/
  <ddl>         Set ddl filename
  -b, --base base   Set level-k log base [default: 32]
  -m, --mode mode   Set topK algorithm mode. 0: level-k, 1: product-k [default: 0]
  -g, --genType type    Set generate code mode D(DuckDB)/M(MySql) [default: D]
  -y, --yanna yanna     Set Y for yannakakis generation; N for our rewrite [default: N]
"""

from docopt import docopt
from treenode import *
from comparison import Comparison
from jointree import Edge, JoinTree
from aggregation import *
from generateIR import *
from generateAggIR import *
from generateTopKIR import *
from generateYaIR import *
from codegen import *
from codegenTopK import *
from codegenYan import *
from topk import *
from estimator import *
from enumsType import EdgeType

import globalVar
import csv
import json

from random import randint
from queue import PriorityQueue as PQ
import os
import re
import time
import traceback
import requests


# AddiRelationNames = set(['TableAggRelation', 'AuxiliaryRelation', 'BagRelation']) #5, 5, 6

''' Formatt
RelationName;id;source/inalias(bag);cols;tableDisplayName;[AggList(tableagg)|internalRelations(bag)|supportingRelation(aux)|group+func(agg)]
Only AuxiliaryRelation source is [Bag(Graph,Graph)|Graph|...]
'''

def removeEqual(line: str, range: int = 0):
    if range:
        attrs = line.split(';', range)
        ret = []
        for attr in attrs:
            if attr != attrs[-1]:
                ret.append(attr.split('=')[1])
            else:
                ret.append(attr)
        return ret
    else:
        attrs = line.split(';')
        attrs = [attr.split('=')[1] for attr in attrs]
        return attrs

#NOTE: No recur case in given plan case, so no need tosupport reserve in this function
def parseRelRecur(node: str, allNodes: dict[int, TreeNode], supId: set[int]):
    name, id, line = node.split(';', 2)
    id = int(id.split('=')[1])
    pattern = re.compile('v[0-9]+')
    if id in allNodes:
        return
    if name == 'AggregatedRelation':
        source, cols, alias, group, func = removeEqual(line)
        cols = pattern.findall(cols)
        group = int(group[1:-1])
        aNode = AggTreeNode(id, source, cols, [], alias, None, [], group, func)
        allNodes[id] = aNode
    elif name == 'AuxiliaryRelation':
        source, cols, alias, supportId = removeEqual(line, 3)
        cols = pattern.findall(cols)
        if '\n' in supportId:
            supportId, supportRel = int(supportId.split('\n')[0]), supportId.split('\n')[1]
            if supportId not in allNodes and supportRel != '':
                parseRelRecur(supportRel, allNodes, supId)
        else:
            supportId = int(supportId.split('=')[1])
        auxNode = AuxTreeNode(id, source, cols, [], alias, None, [], supportId)
        supId.add(supportId)
        allNodes[id] = auxNode
    elif name == 'TableScanRelation':
        source, cols, alias = removeEqual(line)
        cols = pattern.findall(cols)
        tsNode = TableTreeNode(id, source, cols, [], alias, None, [])
        allNodes[id] = tsNode
    elif name == 'TableAggRelation':
        source, cols, alias, aggList = removeEqual(line, 3)
        cols = pattern.findall(cols)
        aggList, aggs = aggList.split('\n', 1)
        aggList = aggList.split(',')
        aggList = [int(agg) for agg in aggList]
        aggs = aggs.split('\n')
        for index, each_agg in enumerate(aggs):
            if each_agg != '' and aggList[index] not in allNodes: parseRel(each_agg)
        taNode = TableAggTreeNode(id, source, cols, [], alias, None, [], aggList)
        allNodes[id] = taNode
    elif name == 'BagRelation':
        inAlias, cols, alias, internalRelations = removeEqual(line, 3)
        cols = pattern.findall(cols)
        if '\n' in internalRelations:
            inId, internalRelations = internalRelations.split('\n', 1)
            for internal in internalRelations.split('\n'):
                if internal != '': parseRelRecur(internal)
        else:
            inId = internalRelations.split('=', 1)[1]
        inId = [int(id) for id in inId.split(',')][::-1]
        bagNode = BagTreeNode(id, inAlias, cols, [], alias, None, [], inId, inAlias)
        allNodes[id] = bagNode
    else:
        raise NotImplementedError("Not implemented relation type! ")


def parseRel(node: dict[str, str], allNodes: dict[int, TreeNode], supId: set[int]):
    id, name, cols, alias, reserve, hintJoinOrder = node['id'], node['type'], node['columns'], node['alias'], node['reserves'], node["hintJoinOrder"]
    if name == 'BagRelation':
        inAlias = node['internal']
        inId, internal = node['internalRelations'].split('\n', 1)
        inId = inId.split(',')
        inId = [int(each) for each in inId][::-1]
        internal = internal.split('\n')
        for inter in internal:
            if inter != '': parseRelRecur(inter, allNodes, supId)
        bagNode = BagTreeNode(id, str(inAlias), cols, [], alias, reserve, hintJoinOrder, inId, inAlias)
        allNodes[id] = bagNode
    
    elif name == 'AuxiliaryRelation':
        source = node['source']
        supportId = node['support']
        auxNode = AuxTreeNode(id, source, cols, [], alias, reserve, hintJoinOrder, supportId)
        supId.add(supportId)
        allNodes[id] = auxNode
            
    elif name == 'TableScanRelation':
        source = node['source']
        tsNode = TableTreeNode(id, source, cols, [], alias, reserve, hintJoinOrder)
        allNodes[id] = tsNode
        
    elif name == 'TableAggRelation':
        source = node['source']
        aggList, aggs = node['aggList'].split('\n', 1)
        aggList = aggList.split(',')
        aggList = [int(agg) for agg in aggList]
        aggs = aggs.split('\n')
        for each_agg in aggs:
            if each_agg != '': parseRelRecur(each_agg, allNodes, supId)
        taNode = TableAggTreeNode(id, source, cols, [], alias, reserve, hintJoinOrder, aggList)
        allNodes[id] = taNode
            
    else:
        raise NotImplementedError("Error Realtion type! ")
    return 


def connect(base: int, mode: int, type: GenType):
    BASE_PATH = globalVar.get_value('BASE_PATH')
    DDL_NAME = globalVar.get_value('DDL_NAME')
    QUERY_NAME = globalVar.get_value('QUERY_NAME')
    headers = {'Content-Type': 'application/json'}
    body = dict()
    ddl_file = open(BASE_PATH + DDL_NAME)
    body['ddl'] = ddl_file.read()
    ddl_file.close()
    query_file = open(BASE_PATH + QUERY_NAME)
    body['query'] = query_file.read()
    query_file.close()
    try:
        json_file = open(BASE_PATH + globalVar.get_value('PLAN_NAME'))
        plan = json.load(json_file)
        # FIXME: Only for testing
        body['plan'] = plan
    except IOError:
        pass
    try:
        # http://localhost:8848/api/v1/parse?orderBy=fanout&sample=true&sampleSize=5000&limit=5000, http://localhost:8848/api/v1/parse?orderBy=fanout&fixRootEnable=true
        response = requests.post(url="http://localhost:8848/api/v1/parse?orderBy=fanout&fixRootEnable=true&timeout=200", headers=headers, json=body).json()['data']
    except:
        print(BASE_PATH + QUERY_NAME)
    # 1. 
    table2vars = dict([(t['name'], t['columns']) for t in response['tables']])
    # 3. parse outputVariables
    outputVariables = response['outputVariables']
    groupBy = response['groupByVariables']
    setSubset0 = False
    # NOTE: only change subset at root node aggregation without group by
    if not len(groupBy) and len(response['aggregations']):
        setSubset0 = True
    # 2. parse jointree
    joinTrees = response['joinTrees']
    isFreeConnex = response['freeConnex']
    isFull = response['full']
    optJT: JoinTree = None
    optCOMP: dict[int, Comparison] = None
    allRes, aggFunc = [], []
    for index, jt in enumerate(joinTrees):
        allNodes = dict()
        supId = set()
        nodes, edges, root, subset, comparisons, extraConditions, fixRoot = jt['nodes'], jt['edges'], jt['root'], jt['subset'], jt['comparisons'], jt['extraConditions'], jt['fixRoot']
        # optimization for simple queries
        if len(nodes) <= 2:
            fixRoot = True
        
        # a. parse relations
        for node in nodes:
            parseRel(node, allNodes, supId)
        # b. parse edge
        allNodes = parse_col2var(allNodes, table2vars)
        extraConds = ExtraCondList(extraConditions)
        JT = JoinTree(allNodes, isFull, isFreeConnex, supId, subset, extraConds, fixRoot, setSubset0)
        JT.setRootById(root)
        CompareMap: dict[int, Comparison] = dict()
        for edge_data in edges:
            edge = Edge(JT.getNode(edge_data['src']), JT.getNode(edge_data['dst']), edge_data['key'])
            if JT.getNode(edge.dst.id).reserve is None:
                JT.getNode(edge.dst.id).reserve = list(set(edge.src.cols) & set(edge.dst.cols))
            JT.addEdge(edge)
        # NOTE: Add child join order
        for id, node in JT.node.items():
            if len(node.children) and len(node.hintJoinOrder):
                for child in node.children:
                    child.reduceOrder = len(node.hintJoinOrder) - node.hintJoinOrder.index(child.id)
        # c. parse comparison
        for compId, comp in enumerate(comparisons):
            opName, path, left, right, cond, op = comp['op'], comp['path'], comp['left'], comp['right'], comp['cond'], comp['op']
            Compare = Comparison()
            Compare.setAttr(compId, opName, left, right, path, cond, op)
            leftAlias = JT.node[Compare.beginNodeId].cols
            # NOTE: Change comparison direction
            pattern = re.compile('v[0-9]+')
            extractLeft = pattern.findall(Compare.left)
            if len(extractLeft) and extractLeft[0] not in leftAlias:
                Compare.reversePath()
            CompareMap[Compare.id] = Compare
        # d. final
        if optJT is not None and JT.root.depth > optJT.root.depth:
            optJT, optCOMP = JT, CompareMap
        elif optJT is None:
            optJT, optCOMP = JT, CompareMap
        allRes.append([JT, CompareMap, index])  
    # 4. aggregation
    aggregations = response['aggregations']
    Agg = None
    for aggregation in aggregations:
        func, result, formular = aggregation['func'], aggregation['result'], aggregation['args']
        inVars = []
        if len(formular):
            formular = formular[0]
            pattern = re.compile('v[0-9]+')
            inVars = list(set(pattern.findall(formular)))
        agg = AggFunc(func, inVars, result, formular)
        aggFunc.append(agg)
    if len(aggFunc):
        Agg = Aggregation(groupBy, aggFunc)
    # 5. topk
    topK_data = response['topK']
    topK = None
    if topK_data:
        topK = TopK(topK_data['orderByVariable'], topK_data['desc'], topK_data['limit'], mode=mode, base=base, genType=type)
    # 6. computations
    computations = response['computations']
    tempComp = []
    for com in computations:
        comp = Comp(com['result'], com['expr'])
        tempComp.append(comp)
    computationList = CompList(tempComp)
    return optJT, optCOMP, allRes, outputVariables, Agg, topK, computationList, table2vars


def parse_col2var(allNodes: dict[int, TreeNode], table2vars: dict[str, list[str]]) -> dict[int, TreeNode]:
    sortedNodes = sorted(allNodes.items())
    ret = {k: v for k, v in sortedNodes}
    for id, treeNode in ret.items():
        # k: id, v: TreeNode
        vars = table2vars.get(treeNode.source, None) # Aux/bag can't get the corresponding
        if treeNode.relationType == RelationType.TableScanRelation:
            treeNode.setcol2vars([treeNode.cols, vars])
            
        elif treeNode.relationType == RelationType.AggregatedRelation:
            aggVars = [vars[treeNode.group], treeNode.func.name+'(*)']
            treeNode.setcol2vars([treeNode.cols, aggVars])
        
        elif treeNode.relationType == RelationType.TableAggRelation:    # tablescan+agg: source must in table2vars
            aggIds = treeNode.aggRelation
            aggAllVars = set()
            for id in aggIds:
                # NOTE: Only one aggregation function
                aggAllVars.add(allNodes[id].cols[-1])

            i = 0
            col2vars = [[], []]
            # 1. push original (not from aggList) first
            for col in treeNode.cols:
                if col not in aggAllVars:
                    col2vars[0].append(col)
                    col2vars[1].append(vars[i])
                    i += 1
            # 2. push agg values (alias tackle in aggNode)
            for var in aggAllVars:
                col2vars[0].append(var)
                col2vars[1].append('')
                
            treeNode.setcol2vars(col2vars)   
            
        elif treeNode.relationType == RelationType.BagRelation:
            allBagVars = set()
            allBagVarMap = dict()
            for eachId in treeNode.insideId:
                eachCols, eachVars = allNodes[eachId].col2vars
                eachAlias = allNodes[eachId].alias
                for index, eachCol in enumerate(eachCols):
                    if eachCol not in allBagVars:
                        allBagVars.add(eachCol)
                        allBagVarMap[eachCol] =  eachAlias + '.' + (eachVars[index] if allNodes[eachId].relationType == RelationType.TableScanRelation else eachCol)

            vars = [allBagVarMap[col] for col in treeNode.cols]
            treeNode.setcol2vars([treeNode.cols, vars])
        
        elif treeNode.relationType == RelationType.AuxiliaryRelation:
            supCols, supVars = allNodes[treeNode.supRelationId].col2vars
            auxCols, auxVars = [], []
            for index, col in enumerate(supCols):
                if col in treeNode.cols:
                    auxCols.append(col)
                    auxVars.append(supVars[index])
            treeNode.setcol2vars([auxCols, auxVars])
        
    return ret


if __name__ == '__main__':
    base, mode, type = 2, 0, GenType.PG
    globalVar._init()
    globalVar.set_value('QUERY_NAME', 'query.sql')
    globalVar.set_value('OUT_NAME', 'rewrite.sql')
    globalVar.set_value('OUT_YA_NAME', 'rewriteYa.sql')
    globalVar.set_value('COST_NAME', 'cost.csv')
    globalVar.set_value('GEN_TYPE', 'DuckDB')
    globalVar.set_value('YANNA', False)
    if globalVar.get_value("GEN_TYPE") != 'PG':
        globalVar.set_value('PLAN_NAME', 'plan.json')
    else:
        globalVar.set_value('PLAN_NAME', 'plan_pg.json')
    # code debug keep here
    globalVar.set_value('BASE_PATH', 'query/graph/q1a/')
    globalVar.set_value('DDL_NAME', "graph.ddl")
    globalVar.set_value('REWRITE_TIME', 'rewrite_time.txt')
    # auto-rewrite keep here
    
    arguments = docopt(__doc__)
    globalVar.set_value('BASE_PATH', arguments['<query>'] + '/')
    globalVar.set_value('DDL_NAME', arguments['<ddl>'] + '.ddl')
    base = int(arguments['--base'])
    mode=int(arguments['--mode'])
    yanna=True if arguments['--yanna'] == 'Y' else False
    globalVar.set_value('YANNA', yanna)
    if arguments['--genType'] == 'M':
        type=GenType.Mysql
    elif arguments['--genType'] == 'D':
        type=GenType.DuckDB
    else:
        type=GenType.PG
    if type == GenType.Mysql:
        globalVar.set_value('GEN_TYPE', 'Mysql')
    elif type == GenType.PG:
        globalVar.set_value('GEN_TYPE', 'PG')
    else:
        globalVar.set_value('GEN_TYPE', 'DuckDB')
    
    BASE_PATH = globalVar.get_value('BASE_PATH')
    OUT_NAME = globalVar.get_value('OUT_NAME')
    OUT_YA_NAME = globalVar.get_value('OUT_YA_NAME')
    COST_NAME = globalVar.get_value('COST_NAME')
    REWRITE_TIME = globalVar.get_value('REWRITE_TIME')
    start = time.time()
    optJT, optCOMP, allRes, outputVariables, Agg, topK, computationList, table2vars = connect(base=base, mode=mode, type=type)
    end = time.time()
    with open(BASE_PATH + REWRITE_TIME, 'w+') as f:
        print('Parser time(s): ', end-start)
        f.write('Parser time(s): ' + str(end-start) + '\n')
    IRmode = IRType.Report if not Agg else IRType.Aggregation
    IRmode = IRType.Level_K if topK and topK.mode == 0 else IRmode
    IRmode = IRType.Product_K if topK and topK.mode == 1 else IRmode
    # sign for whether process all JT
    optFlag = False
    if optFlag:

        cost_height, cost_fanout, cost_estimate = getEstimation(globalVar.get_value('DDL_NAME').split('.')[0], optJT)
        costOutName = COST_NAME.split('.')[0] + 'opt' + '.' + COST_NAME.split('.')[1]
        costout = open(BASE_PATH + costOutName, 'w+')
        costout.write(str(cost_height) + '\n' + str(cost_fanout) + '\n' + str(cost_estimate))
        costout.close()
        
        if IRmode == IRType.Report:
            if globalVar.get_value('YANNA'):
                semiUp, semiDown, lastUp, finalResult = yaGenerateIR(optJT, optCOMP, outputVariables, computationList)
                codeGenYa(semiUp, semiDown, lastUp, finalResult, BASE_PATH + 'opt' +OUT_YA_NAME, genType=type, isAgg=False)
            else:
                reduceList, enumerateList, finalResult = generateIR(optJT, optCOMP, outputVariables, computationList)
                codeGen(reduceList, enumerateList, finalResult, BASE_PATH + 'opt' +OUT_NAME, isFull=optJT.isFull, genType=type)
        elif IRmode == IRType.Aggregation:
            if globalVar.get_value('YANNA'):
                semiUp, semiDown, lastUp, finalResult = yaGenerateIR(optJT, optCOMP, outputVariables, computationList, isAgg=True, Agg=Agg)
                codeGenYa(semiUp, semiDown, lastUp, finalResult, BASE_PATH + 'opt' +OUT_YA_NAME, genType=type, isAgg=True)
            else:
                aggList, reduceList, enumerateList, finalResult = generateAggIR(optJT, optCOMP, outputVariables, computationList, Agg)
                codeGen(reduceList, enumerateList, finalResult, BASE_PATH + 'opt' +OUT_NAME, aggList=aggList, isFreeConnex=optJT.isFreeConnex, Agg=Agg, isFull=optJT.isFull, genType=type)
        # NOTE: No comparison for TopK yet
        elif IRmode == IRType.Level_K:
            reduceList, enumerateList, finalResult = generateTopKIR(optJT, outputVariables, computationList, IRmode=IRType.Level_K, base=topK.base, DESC=topK.DESC, limit=topK.limit)
            codeGenTopK(reduceList, enumerateList, finalResult,  BASE_PATH + 'opt' +OUT_NAME, IRmode=IRType.Level_K, genType=topK.genType)
        elif IRmode == IRType.Product_K:
            reduceList, enumerateList, finalResult = generateTopKIR(optJT, outputVariables, computationList, IRmode=IRType.Product_K, base=topK.base, DESC=topK.DESC, limit=topK.limit)
            codeGenTopK(reduceList, enumerateList, finalResult,  BASE_PATH + 'opt' +OUT_NAME, IRmode=IRType.Product_K, genType=topK.genType)  
    else:
        fields = ['index', 'hight', 'width', 'estimate'] 
        cost_stat = PQ()
        # NOTE: Change the number of MAXIMUM generated plans
        total_number = 6
        fix_number, nonfix_number = total_number // 2, total_number // 2
        fix_iter, nonfix_iter = 0, 0
        best_res_nonfix, best_res_fix = [], []
        all_res = []
        has_nonfix: bool = False
        
        for jt, comp, index in allRes:
            cost_height, cost_fanout, cost_estimate = getEstimation(globalVar.get_value('DDL_NAME').split('.')[0], jt)
            cost_stat.put((cost_estimate, jt, comp, index))
            all_res.append([index, cost_height, cost_fanout, cost_estimate])
            if not has_nonfix and not jt.fixRoot:
                has_nonfix = True

        if not has_nonfix:
            fix_number = total_number
        
        while not cost_stat.empty():
            cost_estimate, jt, comp, index = cost_stat.get()

            if fix_iter + nonfix_iter >= total_number:
                break

            if jt.fixRoot and fix_iter >= fix_number:
                continue
            if not jt.fixRoot and nonfix_iter >= nonfix_number:
                continue

            if jt.fixRoot:
                fix_iter += 1
                best_res_fix.append(index)
            else:
                nonfix_iter += 1
                best_res_nonfix.append(index)

            try:
                
                jtout = open(BASE_PATH + 'jointree' + str(index) + '.txt', 'w+')
                jtout.write(str(jt))
                jtout.close()
                outName = OUT_NAME.split('.')[0] + str(index) + '.' + OUT_NAME.split('.')[1]
                outYaName = OUT_YA_NAME.split('.')[0] + str(index) + '.' + OUT_YA_NAME.split('.')[1]
                
                computationList.reset()
                if IRmode == IRType.Report:
                    if globalVar.get_value('YANNA'):
                        semiUp, semiDown, lastUp, finalResult = yaGenerateIR(jt, comp, outputVariables, computationList)
                        codeGenYa(semiUp, semiDown, lastUp, finalResult, BASE_PATH + outYaName, genType=type, isAgg=False)
                    else:
                        reduceList, enumerateList, finalResult = generateIR(jt, comp, outputVariables, computationList)
                        codeGen(reduceList, enumerateList, finalResult, BASE_PATH + outName, isFull=jt.isFull, genType=type)
                elif IRmode == IRType.Aggregation:
                    Agg.initDoneFlag()
                    if globalVar.get_value('YANNA'):
                        semiUp, semiDown, lastUp, finalResult = yaGenerateIR(jt, comp, outputVariables, computationList, isAgg=True, Agg=Agg)
                        codeGenYa(semiUp, semiDown, lastUp, finalResult, BASE_PATH + outYaName, genType=type, isAgg=True)
                    else:
                        aggList, reduceList, enumerateList, finalResult = generateAggIR(jt, comp, outputVariables, computationList, Agg)
                        codeGen(reduceList, enumerateList, finalResult, BASE_PATH + outName, aggList=aggList, isFreeConnex=jt.isFreeConnex, Agg=Agg, isFull=jt.isFull, genType=type)
                # NOTE: No comparison for TopK yet
                elif IRmode == IRType.Level_K:
                    reduceList, enumerateList, finalResult = generateTopKIR(jt, outputVariables, computationList, IRmode=IRType.Level_K, base=topK.base, DESC=topK.DESC, limit=topK.limit)
                    codeGenTopK(reduceList, enumerateList, finalResult, BASE_PATH + outName, IRmode=IRType.Level_K, genType=topK.genType)
                elif IRmode == IRType.Product_K:
                    reduceList, enumerateList, finalResult = generateTopKIR(jt, outputVariables, computationList, IRmode=IRType.Product_K, base=topK.base, DESC=topK.DESC, limit=topK.limit)
                    codeGenTopK(reduceList, enumerateList, finalResult, BASE_PATH + outName, IRmode=IRType.Product_K, genType=topK.genType)

            except Exception as e:
                traceback.print_exc()
                print("Error JT: " + str(index))
        with open(BASE_PATH + COST_NAME, 'w+') as f:
            write = csv.writer(f)
            write.writerow(fields)
            write.writerows(all_res)
            write.writerow(best_res_nonfix)
            write.writerow(best_res_fix)

    end2 = time.time()
    with open(BASE_PATH + REWRITE_TIME, 'a+') as f:
        print("Rewrite time(s): " + str(end2-end) + "\n")
        print("Total time(s): " + str(end2-start) + "\n")
        print("Total plans: " + str(len(allRes)))
        f.write("Rewrite time(s): " + str(end2-end) + '\n')
    