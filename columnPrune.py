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
def removeAttrAlias(selectAttrs: list[str], selectAlias: list[str], containKeys: set[str], Agg: Aggregation = None, removeAnnot: bool = False):
    if removeAnnot:
        IG_SET = set({'oriLeft', 'oriRight', 'caseCond', 'caseRes'})
    else:
        IG_SET = set({'annot', 'oriLeft', 'oriRight', 'caseCond', 'caseRes'})

    # TODO: Maybe remove joinket mistakenly
    if Agg:
        for alias in Agg.allAggAlias:
            if alias in selectAlias:
                containKeys = containKeys.difference(set(Agg.alias2AggFunc[alias].inVars))   

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

def getOneAggSet(aggFunc: AggFunc, isAll: bool = True):
    aggKeepSet = set()
    if isAll:
        aggKeepSet.add(aggFunc.alias)
        aggKeepSet.update(aggFunc.inVars)
    else:
        aggKeepSet.add(aggFunc.alias)
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
    extraEqualSet = JT.extraEqualSet
    
    joinKeyParent: dict[int, set[str]] = dict()     # NodeId -> joinKeys with parent -> reduce
    joinKeyEnum: dict[int, set[str]] = dict()
    addUpJoinKey: set[str] = set()
    allJoinKeys: set[str] = set()

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
        orderRequireInit = outputVariables | compKeepSet | aggKeepSet | extraEqualSet
    else:
        orderRequireInit = outputVariables | compKeepSet | extraEqualSet

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
                reduce.orderView.selectAttrs, reduce.orderView.selectAttrAlias = removeAttrAlias(reduce.orderView.selectAttrs, reduce.orderView.selectAttrAlias, orderRequireInit | allJoinKeys, Agg=Agg)
            
            if reduce.joinView:
                reduce.joinView.selectAttrs, reduce.joinView.selectAttrAlias = removeAttrAlias(reduce.joinView.selectAttrs, reduce.joinView.selectAttrAlias, orderRequireInit | allJoinKeys, Agg=Agg)
        else:
            if reduce.semiView:
                reduce.semiView.selectAttrs, reduce.semiView.selectAttrAlias = removeAttrAlias(reduce.semiView.selectAttrs, reduce.semiView.selectAttrAlias, orderRequireInit | allJoinKeys, Agg=Agg)
    
    aggHasLeft: bool = False
    if Agg:
        for func in Agg.aggFunc:
            if not func.doneFlag:
                aggHasLeft = True
                break
     
    finalKeepSet = outputVariables if not aggHasLeft else outputVariables | aggKeepSet
    finalAnnotKeep = True if 'annot' in finalResult else False
    requireVariables: set[str] = outputVariables | aggKeepSet | compKeepSet | extraEqualSet
    ## step2: prune enumerate
    for index, enum in enumerate(reversed(enumerateList)):
        corEnum = enum.semiEnumerate if enum.semiEnumerate else enum.stageEnd
        if index == 0:
            corEnum.selectAttrs, corEnum.selectAttrAlias = removeAttrAlias(corEnum.selectAttrs, corEnum.selectAttrAlias, finalKeepSet, Agg=Agg, removeAnnot=finalAnnotKeep)
        else:
            # FIXME: use all joinKeys to prune
            corEnum.selectAttrs, corEnum.selectAttrAlias = removeAttrAlias(corEnum.selectAttrs, corEnum.selectAttrAlias, requireVariables | joinKeyEnum[enum.corresNodeId], Agg=Agg)
                
    # step3: prune aggReduce (bottom up)
    if Agg:
        requireVariables = outputVariables | compKeepSet | extraEqualSet
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
                
            curRequireSet = requireVariables | jkp | aggKeepSet | extraEqualSet
            
            removeAnnotFlag = len(JT.subset) == 1 and index == len(aggReduceList)-1 and (not 'annot' in finalResult)
            if removeAnnotFlag and 'annot' in aggReduce.aggView.selectAttrAlias:
                if not len(aggReduce.aggView.selectAttrs):
                    aggReduce.aggView.selectAttrAlias.remove('annot')
                else:
                    index = aggReduce.aggView.selectAttrAlias.index('annot')
                    aggReduce.aggView.selectAttrAlias.pop(index)
                    aggReduce.aggView.selectAttrs.pop(index)
            aggReduce.aggJoin.selectAttrs, aggReduce.aggJoin.selectAttrAlias = removeAttrAlias(aggReduce.aggJoin.selectAttrs, aggReduce.aggJoin.selectAttrAlias, curRequireSet, Agg=Agg, removeAnnot=removeAnnotFlag)
    return aggReduceList, reduceList, enumerateList


def columnPruneYa(JT: JoinTree, semiUp: list[SemiUpPhase], semiDown: list[SemiJoin], lastUp: Union[list[AggReducePhase], list[Join2tables]], finalResult: str, outputVariables: set[str], Agg: Aggregation = None, COMP: list[Comparison] = []):
    aggKeepSet = getAggSet(Agg, isAll=True) 
    compKeepSet = getCompSet(COMP)
    extraEqualSet = JT.extraEqualSet

    joinKeyEnum: dict[int, set[str]] = dict()
    allJoinKeys: set[str] = set()
    totalLen = len(lastUp)
    # cal joinkey enum
    for idx, last in enumerate(lastUp[::-1]):
        joinKeyEnum[totalLen-idx-1] = allJoinKeys.copy()
        if Agg:
            allJoinKeys |= set(last.aggJoin.joinKey)
        else:
            allJoinKeys |= set(last.joinKey)

    requireVariables = outputVariables | aggKeepSet | compKeepSet | extraEqualSet

    for semi in semiUp:
        semi.semiView.selectAttrs, semi.semiView.selectAttrAlias = removeAttrAlias(semi.semiView.selectAttrs, semi.semiView.selectAttrAlias, requireVariables | allJoinKeys)

    for semi in semiDown:
        semi.selectAttrs, semi.selectAttrAlias = removeAttrAlias(semi.selectAttrs, semi.selectAttrAlias, requireVariables | allJoinKeys)

    for idx, last in enumerate(lastUp):
        if Agg:
            removeAnnotFlag = idx == len(lastUp)-1 and (not 'annot' in finalResult)
            last.aggJoin.selectAttrs, last.aggJoin.selectAttrAlias = removeAttrAlias(last.aggJoin.selectAttrs, last.aggJoin.selectAttrAlias, requireVariables | joinKeyEnum[idx], Agg=Agg, removeAnnot=removeAnnotFlag)
        else:
            last.selectAttrs, last.selectAttrAlias = removeAttrAlias(last.selectAttrs, last.selectAttrAlias, requireVariables | joinKeyEnum[idx])

    return semiUp, semiDown, lastUp