"""
Usage:
  main.py <query>
  aggRelation use special ;, others use :
  jointreeEdge each edge use special |
"""
from treenode import *
from comparison import Comparison
from jointree import Edge, JoinTree
from generateIR import *
from codegen import *
from random import randint
import os
import re
import traceback

GET_TREE = 'sparksql-plus-cli-jar-with-dependencies.jar'

BASE_PATH = 'query/q14/'
DDL_NAME = 'graph.ddl'
QUERY_NAME = 'query.sql'
OUT_NAME = 'rewrite.txt'
JT_PATH = ''
OUT_PATH = 'outputVariables.txt'
AddiRelationNames = set(['TableAggRelation', 'AuxiliaryRelation', 'BagRelation']) #5, 5, 6

def get_tree():
    cmdline = f'java -jar {GET_TREE} -d {BASE_PATH}{DDL_NAME} -o {BASE_PATH} {BASE_PATH}{QUERY_NAME}'
    out = os.popen(cmdline, mode='r').readlines()

def parse_ddl():
    try:
        f = open(BASE_PATH + DDL_NAME)
        table2vars = dict()
        line = f.readline()
        flag = 0
        tableName = ''
        cols = []
        while line:
            if 'TABLE' in line:         # begin attributes
                flag = 1
                line = line.split(' ')
                tableName = line[line.index('TABLE') + 1]
                cols.clear()
                line = f.readline()
                continue
            elif 'WITH' in line: 
                flag = 2                # finish one table
                table2vars[tableName] = cols.copy()
                cols.clear()
                line = f.readline()
                continue
    
            if flag == 1:
                line = line.lstrip().rstrip().split(' ')[0]
                cols.append(line)
              
            line = f.readline()
    
        # TODO: Add PK-FK description
        return table2vars
    except FileNotFoundError:
        raise FileNotFoundError("DDL file not exist! ")

def parse_outVar():
    try :
        f = open(BASE_PATH + OUT_PATH)
        line = f.readline()
        flag = 0
        outputVariables = []
        isFull = True
        while line:
            if 'outputVariables:' in line  or 'isFull:' in line: 
                if 'outputVariables:' in line: flag = 1
                else: flag = 2
                line = f.readline()
                continue
            if flag == 1:
                name = line.split(':')[0]
                outputVariables.append(name)
            elif flag == 2:
                isFull = True if line == 'full' else False
            line = f.readline()
        return list(set(outputVariables)), isFull
    except:
        get_tree()
        return parse_outVar()

def parseLine(line: str) -> list[str]:
        name = line.split(';', 1)[0]
        if name not in AddiRelationNames:
            line = line.split(';')
        elif name == 'BagRelation':
            line = line.split(';', 6)
        else: line = line.split(';', 5)
        return line

def parseRelation(line: list[str], JT: JoinTree, table2vars: dict[str, str]) -> int: 
    ''' line represents each node string
    1. test whether already exists(return node if true)
    2. parse each node
    3. return each node id
    '''
    id = int(line[1].split('=')[1])
    if JT.findNode(id): return id
    relationName = line[0]
    
    if relationName != 'BagRelation' :
        source = line[2].split('=')[1]
        cols = line[3].split('=')[1].replace('(', '').replace(')', '').split(',')
        cols = [col[:col.index(':')] for col in cols]
        vars = table2vars.get(source, None) # AuxRelation can't get the corresponding
        alias = line[4].split('=')[1]
        if relationName == 'TableScanRelation':
            # codegen: select vars[0] as cols[0], vars[1] as col[1] from alias
            tsNode = TableTreeNode(id, source, cols, [cols, vars], alias)
            JT.addNode(tsNode)
        
        elif relationName == 'AggregatedRelation':
            group = int(line[5][line[5].index('(')+1 : line[5].index(')')])
            func = line[6].split('=')[1]
            # TODO: support one group by attribute only, (attribute, COUNT(*))
            aggVars = [vars[group], func+'(*)']
            aNode = AggTreeNode(id, source, cols, [cols, aggVars], alias, group, func)
            JT.addNode(aNode)
        
        elif relationName == 'TableAggRelation':
            
            def matchColVar(lineVarlist: list[str], vars: list[str]) -> list[list[str], list[str]]: # deal normal mix with agg variables
                ret = [[], []]
                i = 0
                for index, each in enumerate(lineVarlist):
                    if 'LongDataType' not in each:
                        ret[0].append(each[:each.index(':')])
                        ret[1].append(vars[i])
                        i += 1
                return ret     
                        
            # 1. process internal agg node first 2. process out TableAgg node
            # codegen: generate internal agg first, later 2 tables join
            varTuple = line[3].split('=')[1].replace('(', '').replace(')', '').split(',')
            matched = matchColVar(varTuple, vars)
            aggTuple = []          # get agg variable
            for var in varTuple:
                if 'LongDataType' in var:
                    aggTuple.append(var)
            agglist = line[5].split('AggList=')[1].split('List(')[1]
            agglist = agglist.split(', ')
            last = agglist[-1][:-1]
            agglist.pop()
            agglist.append(last) 
            # agglist contain a list of aggId   
            agglist = [parseRelation(parseLine(agg), JT, table2vars) for agg in agglist]
            # col2vars: one part from original source; the other for internal agg relation
            for aggId in agglist:
                aggCols, aggVars = JT.getCol2vars(aggId)
                aggAlias = JT.getNodeAlias(aggId)
                for var in aggTuple:     # aggVars
                    varName = var.split(':')[0]
                    if varName in aggCols:
                        matched[0].append(varName)
                        matched[1].append(aggAlias + '.' + aggVars[aggCols.index(varName)])
                
            taNode = TableAggTreeNode(id, source, cols, matched, alias, agglist)
            JT.addNode(taNode)
        
        elif relationName == 'AuxiliaryRelation':
            supportRelation = line[5].split('supportingRelation=')[1]
            supportId = parseRelation(parseLine(supportRelation), JT, table2vars)
            # AuxRelation Source [T]
            supCols, supVars = JT.getCol2vars(supportId)
            supAlias = JT.getNodeAlias(supportId)
            auxCols, auxVars = [], []
            for index, col in enumerate(supCols):
                if col in cols:
                    auxCols.append(col)
                    auxVars.append(supVars[index])
                    
            # replace source name [T] to Txxx
            if '[' in source and ']' in source:
                source = source.replace('[', '').replace(']', str(randint(0, 100)))
            
            # extra process for its alias
            alias = alias.replace('[', '').replace(']', '') + 'Aux' + str(randint(0, 100))
            auxNode = AuxTreeNode(id, source, auxCols, [auxCols, auxVars], alias, supportId)
            JT.addNode(auxNode)
    
    else: #BagRelation
        inAlias = line[2].split('=')[1].split(',')
        inId = line[3].split('=')[1].split(',')
        inId = [int(id) for id in inId]
        cols = line[4].split('=')[1].replace('(', '').replace(')', '').split(',')
        cols = [col[:col.index(':')] for col in cols]
        alias = line[5].split('=')[1]
        internalRelations = line[6].split('internalRelations=')[1].split('List(')[1].split(', ')
        last = internalRelations[-1][:-1]
        internalRelations.pop()
        internalRelations.append(last)
        insideId = [parseRelation(parseLine(internal), JT, table2vars) for internal in internalRelations]
        # remember all variables in the bag
        allBagVars = set()
        allBagVarMap = dict()
        source = []
        for eachId in insideId:
            eachCols, eachVars = JT.getCol2vars(eachId)
            eachAlias = JT.getNodeAlias(eachId)
            for index, eachCol in enumerate(eachCols):
                if eachCol not in allBagVars: 
                    allBagVars.add(eachCol)
                    allBagVarMap[eachCol] =  eachAlias + '.' + eachVars[index]

        vars = [allBagVarMap[col] for col in cols]
        source = ', '.join(source)
        bagNode = BagTreeNode(id, alias, cols, [cols, vars], alias, insideId, inAlias)
        JT.addNode(bagNode)
        
    return id
        
            
def parseComparison(line: list[str]):
    id = int(line[0].split('=')[1])
    op = line[1].split('=')[1]
    left = line[2].split('=')[1]
    right = line[3].split('=')[1]
    path = line[4].split('=')[1].split(',')
    return id, op, left, right, path
        
    
def parse_one_jt(isFull: bool, table2vars: dict[str, str], jtPath: str):
    f = open(jtPath)
    line = f.readline().rstrip()
    flag = 0
    JT = JoinTree(isFull)
    CompareMap: dict[int, Comparison] = dict()
    
    while line:
        if 'jt.root:' in line  or 'edge:' in line  or 'relation in subset:' in line  or 'comparison hypergraph edge:' in line: 
            if 'jt.root:' in line: flag = 1    
            elif 'comparison hypergraph edge:' in line: flag = 4 
            elif 'edge:' in line: flag = 2      
            elif 'relation in subset:' in line and not isFull: flag = 3 
            else : flag = 5 # do nothing
            line = f.readline().rstrip()
            continue
        
        if flag == 1: # root
            line = parseLine(line)
            nodeId = parseRelation(line, JT, table2vars)
            JT.setRootById(nodeId)
            
        elif flag == 2:
            rel1, rel2 = line.split('->')
            rel1 = parseLine(rel1)
            rel2 = parseLine(rel2)
            node1Id = parseRelation(rel1, JT, table2vars)
            node2Id = parseRelation(rel2, JT, table2vars)
            edge = Edge(JT.getNode(node1Id), JT.getNode(node2Id))
            JT.addEdge(edge)
            
        elif flag == 3:
            line = parseLine(line)
            node = parseRelation(line, JT, table2vars)
            JT.addSubset(node)
            
        elif flag == 4:
            line = parseLine(line)[1:]
            id, op, left, right, path = parseComparison(line)
            Compare = Comparison()
            Compare.setAttr(id, op, left, right, path)
            leftAlias = JT.node[Compare.beginNodeId].cols
            # NOTE: fix left attrs not in beginNode, only happen in 2 table join
            if Compare.left.split('+')[0].split('*')[0] not in leftAlias:
                Compare.reversePath()
            CompareMap[Compare.id] = Compare
            
        line = f.readline().rstrip()
        
    return JT, CompareMap

'''Use JoinTree with minimum depth'''
def parse_jt(isFull: bool, table2vars: dict[str, str]):
    g = os.walk(BASE_PATH)
    optJT: JoinTree = None
    optCOMP: dict[int, Comparison] = None
    allRes = []
    for path,dir_list,file_list in g:
        for file_name in file_list:
            if 'JoinTree' in file_name:
                jt, comp = parse_one_jt(isFull, table2vars, BASE_PATH + file_name)
                '''
                leafRelation = [rel.dst.id for rel in list(jt.edge.values()) if rel.dst.isLeaf]
                if jt.root.id in leafRelation:
                    continue    # not statidfied jointree, specific for one edge jointree
                '''
                if optJT is not None and jt.root.depth < optJT.root.depth:
                    optJT, optCOMP = jt, comp
                elif optJT is None:
                    optJT, optCOMP = jt, comp
                allRes.append([jt, comp, file_name])       

    return optJT, optCOMP, allRes


if __name__ == '__main__':
    path_ddl = ''
    table2vars = parse_ddl()
    outputVariables, isFull = parse_outVar()
    optJT, optCOMP, allRes = parse_jt(isFull, table2vars)
    # sign for whether process all JT
    optFlag = False
    if optFlag:
        reduceList, enumerateList = generateIR(optJT, optCOMP)
        codeGen(reduceList, enumerateList, outputVariables, BASE_PATH + OUT_NAME, isFull=isFull)
    else:
        for jt, comp, name in allRes:
            pattern = re.compile(r'\d+')
            index = pattern.findall(name)[0]
            outName = OUT_NAME.split('.')[0] + index + '.' + OUT_NAME.split('.')[1]
            try:
                reduceList, enumerateList = generateIR(jt, comp)
                codeGen(reduceList, enumerateList, outputVariables, BASE_PATH + outName, isFull=isFull)
            except Exception as e:
                traceback.print_exc()
                print("Error JT: " + name)