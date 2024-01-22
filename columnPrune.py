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
    if removeAnnot:
        IG_SET = set({'oriLeft', 'oriRight', 'caseCond', 'caseRes'})
    else:
        IG_SET = set({'annot', 'oriLeft', 'oriRight', 'caseCond', 'caseRes'})
    
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
            aggKeepSet.add(func.alias)
        
    return aggKeepSet


def getCompSet(COMP: list[Comparison]):
    if not len(COMP):
        return set()
    
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
def columnPrune(JT: JoinTree, aggReduceList: list[AggReducePhase], reduceList: list[ReducePhase], enumerateList: list[EnumeratePhase], finalResult: str, outputVariables: set[str], Agg: Aggregation = None, COMP: list[Comparison] = []):
    # FIXME: No intermediate variable in agg, all trans happens at one node
    aggKeepSet = getAggSet(Agg, isAll=True) 
    compKeepSet = getCompSet(COMP)
    
    joinKeyParent: dict[int, set[str]] = dict()     # NodeId -> joinKeys with parent -> reduce
    joinKeyEnum: dict[int, set[str]] = dict()
    addUpJoinKey: set[str] = set()
    allJoinKeys: set() = set()

    # step0: top down -> joinkey
    queue: list[TreeNode] = []
    queue.append(JT.root)
    while len(queue):
        node = queue.pop()
        for child in node.children:
            queue.insert(0, child)
        if node.isRoot: 
            continue
            
        joinKeyParent[node.id] = set(node.cols) & set(node.parent.cols)
        allJoinKeys |= set(node.cols) & set(node.parent.cols)
    
    # step1: prune reduce list
    if Agg:
        orderRequireInit = outputVariables | compKeepSet | aggKeepSet
    else:
        orderRequireInit = outputVariables | compKeepSet 

    for reduce in reduceList:
        ## Set up joinKeyEnum
        corNode = JT.getNode(reduce.corresNodeId)
        if corNode.parent.id in JT.subset:
            if len(addUpJoinKey):
                if corNode.id in joinKeyEnum:
                    joinKeyEnum[corNode.id] |= addUpJoinKey
                else:
                    joinKeyEnum[corNode.id] = addUpJoinKey.copy()
            addUpJoinKey |= (set(corNode.cols) & set(corNode.parent.cols))
            if corNode.parent.id in joinKeyEnum:
                joinKeyEnum[corNode.parent.id] |= addUpJoinKey
            else:
                joinKeyEnum[corNode.parent.id] = addUpJoinKey.copy()
        ## prune reduce
        if reduce.PhaseType == PhaseType.CQC:
            if reduce.orderView:
                reduce.orderView.selectAttrs, reduce.orderView.selectAttrAlias = removeAttrAlias(reduce.orderView.selectAttrs, reduce.orderView.selectAttrAlias, orderRequireInit | allJoinKeys)
            
            reduce.joinView.selectAttrs, reduce.joinView.selectAttrAlias = removeAttrAlias(reduce.joinView.selectAttrs, reduce.joinView.selectAttrAlias, orderRequireInit | allJoinKeys)
        else:
            reduce.semiView.selectAttrs, reduce.semiView.selectAttrAlias = removeAttrAlias(reduce.semiView.selectAttrs, reduce.semiView.selectAttrAlias, orderRequireInit | allJoinKeys)
    
    requireVariables: set[str] = outputVariables | aggKeepSet | compKeepSet
    ## step2: prune enumerate
    for index, enum in enumerate(reversed(enumerateList)):
        corEnum = enum.semiEnumerate if enum.semiEnumerate else enum.stageEnd
        if index == 0:
            corEnum.selectAttrs, corEnum.selectAttrAlias = removeAttrAlias(corEnum.selectAttrs, corEnum.selectAttrAlias, outputVariables | aggKeepSet, removeAnnot=True)
        else:
            if JT.getNode(enum.corresNodeId).parent.id in joinKeyEnum:
                corEnum.selectAttrs, corEnum.selectAttrAlias = removeAttrAlias(corEnum.selectAttrs, corEnum.selectAttrAlias, requireVariables | joinKeyEnum[JT.getNode(enum.corresNodeId).parent.id])
            else:
                corEnum.selectAttrs, corEnum.selectAttrAlias = removeAttrAlias(corEnum.selectAttrs, corEnum.selectAttrAlias, requireVariables)
    # step3: prune aggReduce (bottom up)
    if Agg:
        requireVariables = outputVariables | compKeepSet
        for index, aggReduce in enumerate(aggReduceList):
            corNode = JT.getNode(aggReduce.corresId)
            jkp = set()
            if not corNode.parent.isRoot:
                jkp = joinKeyParent[corNode.parent.id]
            
            if len(corNode.parent.children) > 1:
                corNode.optDone = True
                for child in corNode.parent.children:
                    if not child.optDone:
                        jkp = jkp | (set(child.cols) & set(corNode.parent.cols))
            
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
            
            removeAnnotFlag = len(JT.subset) == 1 and index == len(aggReduceList)-1 and (not 'annot' in finalResult)
            if removeAnnotFlag and 'annot' in aggReduce.aggView.selectAttrAlias:
                if not len(aggReduce.aggView.selectAttrs):
                    aggReduce.aggView.selectAttrAlias.remove('annot')
                else:
                    index = aggReduce.aggView.selectAttrAlias.index('annot')
                    aggReduce.aggView.selectAttrAlias.pop(index)
                    aggReduce.aggView.selectAttrs.pop(index)
                
            aggReduce.aggJoin.selectAttrs, aggReduce.aggJoin.selectAttrAlias = removeAttrAlias(aggReduce.aggJoin.selectAttrs, aggReduce.aggJoin.selectAttrAlias, curRequireSet, removeAnnot=removeAnnotFlag)

    return aggReduceList, reduceList, enumerateList