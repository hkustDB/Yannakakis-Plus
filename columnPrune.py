from aggregation import *
from reduce import *
from enumerate import *
from jointree import *
from treenode import *
from enumsType import *

import re


'''
keep: joinkey | output variables | comparison | aggregation | bag internal joinkey
'''


# delete extra column
def removeAttrAlias(selectAttrs: list[str], selectAlias: list[str], containKeys: set[str], removeAnnot: bool = False):
    if not removeAnnot:
        IG_SET = set({'annot'})
    else:
        IG_SET = set()
    
    if not len(selectAttrs):
        selectAlias = [alias for alias in selectAlias if alias in containKeys or 'mf' in alias or alias in IG_SET]
    else:
        removeFlag = [0] * len(selectAlias)
        for index, alias in enumerate(selectAlias):
            if alias not in containKeys and not 'mf' in alias and alias not in IG_SET:
                removeFlag[index] = 1
        selectAttrs = [attr for index, attr in enumerate(selectAttrs) if not removeFlag[index]]
        selectAlias = [alias for index, alias in enumerate(selectAlias) if not removeFlag[index]]
    return selectAttrs, selectAlias


# isAll True -> internal variables | alias; False -> alias only
def getAggSet(Agg: Aggregation, isAll: bool = True):
    if not Agg:
        return set()
    aggKeepSet = set()
    if isAll:
        for func in Agg.aggFunc:
            aggKeepSet.add(func.alias)
            aggKeepSet.update(func.inVars)
    else:
        for func in Agg.aggFunc:
            if func.doneFlag:
                aggKeepSet.add(func.alias)
            else:
                aggKeepSet.update(func.inVars)
        
    return aggKeepSet


def getCompSet(COMP: list[Comparison]):
    if not len(COMP):
        return []
    
    compSet = set()
    pattern = re.compile('v[0-9]+')
    for comp in COMP:
        if comp.predType != predType.Self:
            inVars = pattern.findall(comp.cond)
            compSet.update(inVars)
    return compSet
    
'''
agregation: undone: keep internal variables; done keep alias
'''
def columnPrune(JT: JoinTree, aggReduceList: list[AggReducePhase], reduceList: list[ReducePhase], enumerateList: list[EnumeratePhase], outputVariables: set[str], Agg: Aggregation = None, COMP: list[Comparison] = []):
    # FIXME: No intermediate variable in agg, all trans happens at one node
    aggKeepSet = getAggSet(Agg, isAll=True) 
    compKeepSet = getCompSet(COMP)
    
    joinKeyChild: dict[int, set[str]] = dict()      # NodeId -> joinKeys with child  -> enumerate
    joinKeyParent: dict[int, set[str]] = dict()     # NodeId -> joinKeys with parent -> reduce

    # step0: top down -> joinkey
    queue: list[TreeNode] = []
    queue.append(JT.root)
    while len(queue):
        node = queue.pop()
        for child in node.children:
            queue.insert(0, child)
        if node.isRoot: 
            continue
        if node.parent.id in joinKeyChild:
            joinKeyChild[node.parent.id].update(set(node.cols) & set(node.parent.cols))
        else:
            joinKeyChild[node.parent.id] = set(node.cols) & set(node.parent.cols)
        joinKeyParent[node.id] = set(node.cols) & set(node.parent.cols)
    
    requireVariables: set[str] = outputVariables | aggKeepSet
    
    ## step1: bottom up -> prune enumerate
    for index, enum in enumerate(reversed(enumerateList)):
        corEnum = enum.semiEnumerate if enum.semiEnumerate else enum.stageEnd
        if index == 0:
            corEnum.selectAttrs, corEnum.selectAttrAlias = removeAttrAlias(corEnum.selectAttrs, corEnum.selectAttrAlias, requireVariables)
        else:
            if enum.corresNodeId in joinKeyChild:
                corEnum.selectAttrs, corEnum.selectAttrAlias = removeAttrAlias(corEnum.selectAttrs, corEnum.selectAttrAlias, requireVariables | joinKeyChild[enum.corresNodeId])
            else:
                corEnum.selectAttrs, corEnum.selectAttrAlias = removeAttrAlias(corEnum.selectAttrs, corEnum.selectAttrAlias, requireVariables)
        
    # step2: prune reduce (bottom up)
    if Agg:
        if len(JT.subset):  # free connex
            requireVariables = outputVariables | compKeepSet
        else:               # non free connex
            requireVariables = outputVariables | compKeepSet | set(Agg.groupByVars)
    else: # full & non-full
        requireVariables = outputVariables | compKeepSet
    
    if Agg:
        for index, aggReduce in enumerate(aggReduceList):
            corNode = JT.getNode(aggReduce.corresId)
            jkp = set()
            if not corNode.parent.isRoot:
                jkp = joinKeyParent[corNode.parent.id]
            
            if len(corNode.parent.children) > 1:
                corNode.optDone = True
                for child in corNode.parent.children:
                    if not child.optDone:
                        jkp = jkp | (set(child.cols ) & set(corNode.parent.cols))
            
            # TODO: Remove comparison attributes, only support 1 comparison for aggregation
            if len(aggReduce.aggJoin.whereCondList):
                lastCond = aggReduce.aggJoin.whereCondList[-1]
                if '<' in lastCond or '<=' in lastCond or '>' in lastCond or '>=' in lastCond:
                    requireVariables = outputVariables
                
            curRequireSet = requireVariables | jkp | aggKeepSet
            allAggAlias = Agg.allAggAlias
            for alias in allAggAlias:
                if alias in aggReduce.aggJoin.selectAttrAlias:
                    curRequireSet.difference(Agg.alias2AggFunc[alias].inVars)   
                
            aggReduce.aggJoin.selectAttrs, aggReduce.aggJoin.selectAttrAlias = removeAttrAlias(aggReduce.aggJoin.selectAttrs, aggReduce.aggJoin.selectAttrAlias, curRequireSet, removeAnnot=(len(JT.subset) == 1 and index == len(aggReduceList)-1))

    if Agg:
        orderRequireInit = outputVariables | compKeepSet | aggKeepSet
    else:
        orderRequireInit = outputVariables | compKeepSet 

    for reduce in reduceList:
        if reduce.PhaseType == PhaseType.CQC:
            corNode = JT.getNode(reduce.corresNodeId)
            if reduce.orderView:
                orderRequire = orderRequireInit | (set(corNode.cols) & set(corNode.parent.cols))
                reduce.orderView.selectAttrs, reduce.orderView.selectAttrAlias = removeAttrAlias(reduce.orderView.selectAttrs, reduce.orderView.selectAttrAlias, orderRequire)
            
            if not corNode.parent.isRoot:
                reduce.joinView.selectAttrs, reduce.joinView.selectAttrAlias = removeAttrAlias(reduce.joinView.selectAttrs, reduce.joinView.selectAttrAlias, requireVariables | joinKeyParent[corNode.parent.id])
            else:
                # later will be enumerate, need child joinkey
                reduce.joinView.selectAttrs, reduce.joinView.selectAttrAlias = removeAttrAlias(reduce.joinView.selectAttrs, reduce.joinView.selectAttrAlias, requireVariables | joinKeyChild[corNode.parent.id])
        # TODO: Add for semi case
    return aggReduceList, reduceList, enumerateList
        
        