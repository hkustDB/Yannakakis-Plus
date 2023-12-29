from jointree import *
from enumsType import *
from levelK import *
from productK import *

from sys import maxsize
from random import choice, randint
from typing import Union
from math import ceil, log

# Specific for topk examples, only considering simple TableScan & no comparison
def buildLevelKReducePhase(reduceRel: Edge, JT: JoinTree, lastRel: bool = False, DESC: bool = True, limit: int = 1024) -> LevelKReducePhase:
    childNode = JT.getNode(reduceRel.dst.id)
    parentNode = JT.getNode(reduceRel.src.id)
    aggView = orderView = None
    
    # aggView
    viewName = childNode.alias + '_max'
    joinKey = list(set(childNode.cols) & set(parentNode.cols))
    selectAttr, selectAlias = [], []
    
    def join2ori(transVar: str, isChild: bool = True):
        origin = childNode.col2vars[1][childNode.cols.index(transVar)]
        return origin
    
    if len(joinKey) == 1:
        if childNode.JoinResView:
            selectAlias.append(joinKey[0])
            selectAttr.append('')
            groupBy = joinKey
        else:
            selectAlias.append(joinKey[0])
            selectAttr.append(join2ori(joinKey[0]))
            groupBy = [selectAttr[0]]
    else:
        raise NotImplementedError("Not implement multiple joinkey! ")
    if childNode.isLeaf:
        selectAttr.append('max(rating)')
    else:
        selectAttr.append('max(accweight)')
    selectAlias.append('max_accweight')
    fromTable = childNode.source if childNode.isLeaf else childNode.alias
    aggView = WithView(viewName, selectAttr, selectAlias, fromTable, groupBy=groupBy)
    
    # orderView
    viewName = parentNode.alias
    selectAttr, selectAlias = [], []
    if parentNode.JoinResView:
        selectAlias = parentNode.cols.copy()
        selectAttr = [''] * len(selectAlias)
    else:
        selectAlias = parentNode.cols.copy()
        selectAttr = parentNode.col2vars[1].copy()
    # remain rating alias
    index = parentNode.col2vars[1].index('rating')
    selectAlias[index] = 'rating'
    
    selectAttr.append('rating + max_accweight')
    selectAlias.append('accweight')
    fromTable = parentNode.source
    joinTable = aggView.viewName
    whereCond = fromTable + '.' + join2ori(joinKey[0], isChild=False) + ' = ' + joinTable + '.' + aggView.selectAttrAlias[0]
    if lastRel:
        orderView = WithView(viewName, selectAttr, selectAlias, fromTable, joinTable, joinKey, whereCondList=[whereCond], orderBy=['accweight'], DESC=DESC, limit=limit)
    else:
        orderView = WithView(viewName, selectAttr, selectAlias, fromTable, joinTable, joinKey, whereCondList=[whereCond])
    retReduce = LevelKReducePhase(aggView, orderView, reduceRel)
    return retReduce
    

def buildProductKReducePhase(reduceRel: Edge, JT: JoinTree, lastRel: bool = False, DESC: bool = True, limit: int = 1024) -> ProductKReducePhase:
    childNode = JT.getNode(reduceRel.dst.id)
    parentNode = JT.getNode(reduceRel.src.id)
    
    leafExtra = aggMax = joinRes = None
    
    # 1. leafExtra
    if childNode.isLeaf:
        viewName = childNode.alias + str(randint(0, 1000))
        selectAlias = childNode.cols.copy()
        selectAttrs = childNode.col2vars[1].copy()
        index = selectAttrs.index('rating')
        selectAlias[index] = 'Z'
        selectAttrs.append('rating')
        selectAlias.append('ZZ')
        fromTable = childNode.source + ' as ' + childNode.alias
        leafExtra = Action(viewName, selectAttrs, selectAlias, fromTable)
    # 2. aggMax
    viewName = childNode.alias + 'Agg' + str(randint(0, 1000))
    joinKey = list(set(childNode.cols) & set(parentNode.cols))
    if childNode.JoinResView:
        aggValue = childNode.JoinResView.selectAttrAlias[-1]
        fromTable = childNode.JoinResView.viewName
    else:
        aggValue = leafExtra.selectAttrAlias[-1]
        fromTable = leafExtra.viewName
    selectAlias = joinKey.copy()
    selectAttrs = [''] * len(selectAlias)
    selectAttrs.append('max(' + aggValue + ')')
    selectAlias.append('ZZ')
    aggMax = Action(viewName, selectAttrs, selectAlias, fromTable)
    # 3. joinRes
    viewName = 'join' + str(randint(0, 1000))
    selectAttrs, selectAlias = [], []
    if parentNode.JoinResView:
        # more than 1 child
        selectAlias = parentNode.JoinResView.selectAttrAlias.copy()
        rightMost = selectAlias[-1]
        selectAlias.pop()
        selectAttrs = [''] * len(selectAlias)
        selectAlias.append(rightMost + 'Z')
        selectAttrs.append(parentNode.JoinResView.viewName + '.' + rightMost + '+' + aggMax.viewName + '.' + aggMax.selectAttrAlias[-1])
        fromTable = parentNode.JoinResView.viewName
    else:
        selectAttrs = parentNode.col2vars[1].copy()
        selectAlias = parentNode.cols.copy()
        index = selectAttrs.index('rating')
        selectAlias[index] = 'Z'
        selectAttrs.append(parentNode.source + '.' + selectAttrs[-1] + '+' + aggMax.viewName + '.' + aggMax.selectAttrAlias[-1])
        selectAlias.append('ZZ')
        fromTable = parentNode.source + ' as ' + parentNode.alias
    
    joinTable = aggMax.viewName
    usingJoinKey, whereCondList = [], []
    if parentNode.JoinResView:
        usingJoinKey = joinKey
    else:
        originalName = parentNode.col2vars[1][parentNode.col2vars[0].index(joinKey[0])]
        cond = parentNode.alias + '.' + originalName + '=' + aggMax.viewName + '.' + joinKey[0]
        whereCondList.append(cond)
    
    if lastRel:
        joinRes = WithView(viewName, selectAttrs, selectAlias, fromTable, joinTable, joinKey, usingJoinKey, whereCondList, orderBy=[selectAlias[-1]], DESC=DESC, limit=limit)
    else:
        joinRes = WithView(viewName, selectAttrs, selectAlias, fromTable, joinTable, joinKey, usingJoinKey, whereCondList)
    
    retReduce = ProductKReducePhase(leafExtra, aggMax, joinRes, groupBy=joinKey)
    return retReduce
        

def buildLevelKEnumPhase(previousView: Union[WithView, EnumLogLoopView], corReducePhase: LevelKReducePhase, JT: JoinTree, base: int = 2, DESC: bool = True, limit: int = 1024) -> LevelKEnumPhase:
    rankView: EnumRankView = None
    logkLoop: list[EnumLogLoopView] = []
    logFinalView = None
    
    # 1. rankView
    maxView = truncateView = finalView = None
    ## (1) maxView
    viewName = previousView.viewName + '_max'
    fromTable = previousView.viewName
    joinKey = corReducePhase.orderView.joinKey
    usingJoinKey = []
    selectAttr, selectAlias = [], []
    selectAttr.append('')
    selectAlias.append(joinKey[0])
    selectAttr.append('max(rating)')
    selectAlias.append('max_weight')
    groupBy = [joinKey[0]]
    maxView = WithView(viewName, selectAttr, selectAlias, fromTable, groupBy=groupBy)
    ## (2) truncateView
    origiNode = JT.getNode(corReducePhase.reduceRel.dst.id)
    joinTable = origiNode.JoinResView.viewName if origiNode.JoinResView else origiNode.source
    viewName = origiNode.alias + '_truncated'
    if origiNode.JoinResView:
        selectAlias = origiNode.JoinResView.selectAttrAlias.copy()
        selectAttr = [''] * len(selectAlias)
    else:
        selectAttr = origiNode.col2vars[1].copy()
        selectAlias = origiNode.cols.copy()
        index = selectAttr.index('rating')
        selectAttr[index] = ''
        selectAlias[index] = 'rating'
        selectAttr.append('rating')
        selectAlias.append('accweight')

    fromTable = maxView.viewName
    usingJoinKey, whereCondList = [], []
    if origiNode.JoinResView:
        usingJoinKey = joinKey
    else:
        whereCond = fromTable + '.' + joinKey[0] + '=' + joinTable + '.' + origiNode.col2vars[1][origiNode.cols.index(joinKey[0])]
        whereCondList.append(whereCond)
    orderBy = ['max_weight + accweight']
    truncateView = WithView(viewName, selectAttr, selectAlias, fromTable, joinTable, joinKey=joinKey, usingJoinKey=usingJoinKey, orderBy=orderBy, DESC=DESC, limit=limit)
    ## (3) finalView
    viewName = origiNode.alias + '_rnk'
    fromTable = truncateView.viewName
    finalView = RNView(viewName, [], selectAlias.copy(), fromTable, partitionBy=joinKey, orderBy=['accweight'], DESC=DESC)
    ## (4) EnumRankView
    rankView = EnumRankView(maxView, truncateView, finalView)
    
    # 2. logkLoop
    totalIter = ceil(log(limit, base))
    rePhraseWords = set(['rnk', 'rating', 'left_weight', 'accweight'])
    usingJoinKey = joinKey
    for i in range(totalIter):
        levelk_left = levelk_right = levelk_join = None
        if i != 0:
        ## (a) levelk_left
            viewName = 'levelk_left_' + str(i)
            # select only attrs from one table cols
            selectAlias = [attr for attr in logkLoop[-1].levelk_join.selectAttrAlias if attr not in rePhraseWords and attr in previousView.selectAttrAlias]  # original attrs need to be passed
            selectAttr = [''] * len(selectAlias)
            selectAlias.append('rating')
            selectAttr.append('left_weight')
            rnCond = ['rnk=' + '*'.join([str(base)] * i)]
            fromTable = 'levelk_join_' + str(i-1)
            levelk_left = EnumSelectRN(viewName, selectAttr, selectAlias, fromTable, rnCond)
        ## (b) levelk_right
        viewName = 'levelk_right_' + str(i)
        fromTable = rankView.finalView.viewName
        selectAlias = ['*']
        rnCond = []
        if i != 0:
            rnCond.append('rnk>' + '*'.join([str(base)] * i))
        rnCond.append('rnk<=' + '*'.join([str(base)] * (i+1)))
        levelk_right = EnumSelectRN(viewName, [], selectAlias, fromTable, rnCond)
        ## (c) levelk_join
        viewName = 'levelk_join_' + str(i)
        joinTable = levelk_right.viewName
        selectAlias = list(set(previousView.selectAttrAlias) | set(rankView.finalView.selectAttrAlias))
        selectAlias = [attr for attr in selectAlias if attr not in rePhraseWords]
        selectAttr = [''] * len(selectAlias)
        selectAttr.append(levelk_right.viewName + '.rnk')
        selectAlias.append('rnk')
        if i != 0:
            fromTable = 'levelk_left_' + str(i)
        else:
            fromTable = previousView.viewName
        ### Extra tackle
        selectAttr.append(fromTable + '.rating')
        selectAlias.append('left_weight')
        selectAttr.append(fromTable + '.rating' + '+' + levelk_right.viewName + '.rating')
        selectAlias.append('rating')
        selectAttr.append(fromTable + '.rating' + '+' + levelk_right.viewName + '.accweight')
        selectAlias.append('accweight')
        
        if i != 0:
            levelk_join = EnumJoinUnion(viewName, selectAttr, selectAlias, fromTable, joinTable, unionTable='levelk_join_' + str(i-1), joinKey=joinKey, usingJoinKey=usingJoinKey, orderBy=['accweight'], DESC=DESC, limit=limit)
        else:
            levelk_join = EnumJoinUnion(viewName, selectAttr, selectAlias, fromTable, joinTable, joinKey=joinKey, usingJoinKey=usingJoinKey, orderBy=['accweight'], DESC=DESC, limit=limit)
        
        oneLoop = EnumLogLoopView(i, levelk_left, levelk_right, levelk_join)
        logkLoop.append(oneLoop)
    
    # logKFinal
    viewName = origiNode.alias + '_acc'
    selectAlias = [attr for attr in logkLoop[-1].levelk_join.selectAttrAlias if attr not in rePhraseWords]
    selectAlias.append('rating')
    selectAttr = [''] * len(selectAlias)
    fromTable = logkLoop[-1].levelk_join.viewName
    logFinalView = Action(viewName, selectAttr, selectAlias, fromTable)
    
    retEnum = LevelKEnumPhase(rankView, logkLoop, logFinalView)
    return retEnum
            

def buildProductKEnumPhase(previousView: WithView, corReducePhase: LevelKReducePhase, JT: JoinTree, DESC: bool = True, limit: int = 1024) -> ProductKEnumPhase:
    aggMax = pruneJoin = joinRes = None
    parentNode = JT.getNode(corReducePhase.reduceRel.src.id)
    childNode = JT.getNode(corReducePhase.reduceRel.dst.id)
    
    # 1. aggMax
    viewName = parentNode.alias + str(randint(0, 1000))
    joinKey = list(set(parentNode.cols) & set(childNode.cols))
    selectAttr, selectAlias = [], []
    if previousView.selectAttrAlias[-1] == 'Z':  # line case
        selectAttr = [''] * len(joinKey)
        selectAlias.extend(joinKey)
        selectAttr.append('max(Z)')
        selectAlias.append('Z')
    else:   # star/tree case
        selectAttr = [''] * len(joinKey)
        selectAlias.extend(joinKey)
        selectAttr.append('max(' + previousView.selectAttrAlias[-2] + ')')
        selectAlias.append('Z')
        
    fromTable = previousView.viewName
    aggMax = Action(viewName, selectAttr, selectAlias, fromTable)
    
    # 2. pruneJoin
    selectAlias = childNode.JoinResView.selectAttrAlias
    usingJoinKey = joinKey
    fromTable = childNode.JoinResView.viewName
    joinTable = aggMax.viewName
    orderBy = [joinTable + '.Z' + '+' + fromTable + '.' + selectAlias[-1]]
    pruneJoin = WithView(viewName, [], selectAlias, fromTable, joinTable, joinKey, usingJoinKey, orderBy=orderBy, DESC=DESC, limit=limit)
    
    # 3. joinRes
    fromTable = previousView.viewName
    joinTable = pruneJoin.viewName
    selectAlias = list(set(parentNode.cols) | set(childNode.cols))
    selectAttr = [''] * len(selectAlias)
    leftZ = fromTable + '.Z + '
    rightZ = joinTable + '.'
    for each in pruneJoin.selectAttrAlias:
        if 'Z' in each:
            selectAttr.append(leftZ + rightZ + each)
            selectAlias.append(each)
    firstOrder = previousView.selectAttrAlias[-2] if previousView.selectAttrAlias[-1] != 'Z' else 'Z'
    orderBy = [fromTable + '.' + firstOrder + '+' + joinTable + '.' + pruneJoin.selectAttrAlias[-1]]
    joinRes = WithView(viewName, selectAttr, selectAlias, fromTable, joinTable, joinKey, usingJoinKey, orderBy=orderBy, DESC=DESC, limit=limit)
    
    retEnum = ProductKEnumPhase(aggMax, pruneJoin, joinRes, groupBy=joinKey)
    return retEnum
    

def generateTopKIR(JT: JoinTree, outputVariables: list[str], IRmode: IRType = IRType.Level_K, base: int = 2, DESC: bool = True, limit: int = 1024) -> [list[ReducePhase], list[EnumeratePhase], str]:
    jointree = copy.deepcopy(JT)
    remainRelations = jointree.getRelations().values()
    
    def getLeafRelation(relations: list[Edge]) -> list[Edge]:
        # leafRelation = [rel for rel in relations if rel.dst.isLeaf and not rel.dst.isRoot]
        leafRelation = []
        for rel in relations:
            if rel.dst.isLeaf and not rel.dst.isRoot:
                leafRelation.append(rel)
        return leafRelation
    
    if IRmode == IRType.Level_K:
        reduceList: list[LevelKReducePhase] = []
        enumerateList: list[LevelKEnumPhase] = []
    elif IRmode == IRType.Product_K:
        reduceList: list[ProductKReducePhase] = []
        enumerateList: list[ProductKEnumPhase] = []  
    else:
        raise NotImplementedError("Error for TopK Type! ")
    
    '''Step1: Reduce'''
    while len(remainRelations) > 0:
        leafRelation = getLeafRelation(remainRelations)
        rel = choice(leafRelation)
        if len(remainRelations) != 1:
            if IRmode == IRType.Level_K:
                retReduce = buildLevelKReducePhase(rel, JT, DESC=DESC, limit=limit)
            else:
                retReduce = buildProductKReducePhase(rel, JT, DESC=DESC, limit=limit)
        else:
            if IRmode == IRType.Level_K:
                retReduce = buildLevelKReducePhase(rel, JT, lastRel=True, DESC=DESC, limit=limit)
            else:
                retReduce = buildProductKReducePhase(rel, JT, lastRel=True, DESC=DESC, limit=limit)
                # NOTE: pass leaf view for later enumeration
                childNode = JT.getNode(rel.dst.id)
                if childNode.isLeaf:
                    childNode.JoinResView = retReduce.leafExtra
        
        reduceList.append(retReduce)
        jointree.removeEdge(rel)
        remainRelations = jointree.getRelations().values()
        # NOTE: No complex node type support
        JT.getNode(rel.src.id).JoinResView = retReduce.orderView
        
        
    '''Step2: Enumerate'''
    enumerateOrder = list(reversed(reduceList)).copy()
    
    if IRmode == IRType.Level_K:
        for enum in enumerateOrder:
            beginPrevious = enumerateOrder[0].orderView
            if enumerateList == []:
                previousView = beginPrevious
            else:
                previousView = enumerateList[-1].finalView
            retEnum = buildLevelKEnumPhase(previousView, enum, JT, base=base, DESC=DESC, limit=limit)
            enumerateList.append(retEnum)
            
        fromTable = enumerateList[-1].finalView.viewName
        output = [out for out in outputVariables if out in enumerateList[-1].finalView.selectAttrAlias]
    
    elif IRmode == IRType.Product_K:
        for enum in enumerateOrder:
            beginPrevious = enumerateOrder[0].joinRes
            if enumerateList == []:
                previousView = beginPrevious
            else:
                previousView = enumerateList[-1].joinRes
            retEnum = buildProductKEnumPhase(previousView, enum, JT, DESC=DESC, limit=limit)
            enumerateList.append(retEnum)
            
        fromTable = enumerateList[-1].joinRes.viewName
        output = [out for out in outputVariables if out in enumerateList[-1].joinRes.selectAttrAlias]
    
    # TODO: Check
    output.append('rating')
    finalResult = 'select sum(' + '+'.join(output) + ') from ' + fromTable + ';\n'
    return reduceList, enumerateList, finalResult
    
            
        
 