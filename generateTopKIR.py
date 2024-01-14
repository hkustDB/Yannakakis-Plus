from jointree import *
from enumsType import *
from levelK import *
from productK import *
from topk import *

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
    viewName = childNode.alias + '_max' + str(randint(0, 10000))
    joinKey = list(set(childNode.cols) & set(parentNode.cols))
    selectAttr, selectAlias = [], []
    
    def join2ori(transVar: str, isChild: bool = True):
        if isChild:
            origin = childNode.col2vars[1][childNode.cols.index(transVar)]
        else:
            origin = parentNode.col2vars[1][parentNode.cols.index(transVar)]
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
        for key in joinKey:
            if childNode.JoinResView:
                selectAlias.append(key)
                selectAttr.append('')
            else:
                selectAlias.append(key)
                selectAttr.append(join2ori(key))
            groupBy = joinKey
        
    if childNode.isLeaf:
        selectAttr.append('max(rating)')
    else:
        selectAttr.append('max(accweight)')
    selectAlias.append('max_accweight')
    fromTable = childNode.JoinResView.viewName if childNode.JoinResView else childNode.source
    aggView = WithView(viewName, selectAttr, selectAlias, fromTable, groupBy=groupBy)
    
    # orderView
    viewName = parentNode.alias + str(randint(0, 10000))
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
    joinTable = aggView.viewName
    usingJoinKey = []
    whereCondList = []
    if parentNode.JoinResView:
        fromTable = parentNode.JoinResView.viewName
        usingJoinKey = joinKey
    else:
        fromTable = parentNode.source
        if len(joinKey) == 1:
            whereCond = fromTable + '.' + join2ori(joinKey[0], isChild=False) + ' = ' + joinTable + '.' + aggView.selectAttrAlias[0]
            whereCondList.append(whereCond)
        else:
            for key in joinKey:
                whereCond = fromTable + '.' + join2ori(key, isChild=False) + ' = ' + joinTable + '.' + aggView.selectAttrAlias[0]
                whereCondList.append(whereCond)
    if lastRel:
        orderView = WithView(viewName, selectAttr, selectAlias, fromTable, joinTable, joinKey, usingJoinKey=usingJoinKey, whereCondList=whereCondList, orderBy=['accweight'], DESC=DESC, limit=limit)
    else:
        orderView = WithView(viewName, selectAttr, selectAlias, fromTable, joinTable, joinKey, usingJoinKey=usingJoinKey, whereCondList=whereCondList)
    retReduce = LevelKReducePhase(aggView, orderView, reduceRel)
    return retReduce
    

def buildProductKReducePhase(reduceRel: Edge, JT: JoinTree, lastRel: bool = False, DESC: bool = True, limit: int = 1024) -> ProductKReducePhase:
    childNode = JT.getNode(reduceRel.dst.id)
    parentNode = JT.getNode(reduceRel.src.id)
    
    leafExtra = aggMax = joinRes = None
    
    def countZ(alias: list[str]):
        maxNum = 0
        for a in alias:
            if 'Z' in a:
                num = a.count('Z')
                maxNum = max(num, maxNum)
        return maxNum
    
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
        aggValue = countZ(childNode.JoinResView.selectAttrAlias)
        fromTable = childNode.JoinResView.viewName
    else:
        aggValue = countZ(leafExtra.selectAttrAlias)
        fromTable = leafExtra.viewName
    selectAlias = joinKey.copy()
    selectAttrs = [''] * len(selectAlias)
    selectAttrs.append('max(' + 'Z'*aggValue + ')')
    selectAlias.append('ZZ')
    aggMax = Action(viewName, selectAttrs, selectAlias, fromTable)
    # 3. joinRes
    viewName = parentNode.alias + 'join' + str(randint(0, 1000))
    selectAttrs, selectAlias = [], []
    if parentNode.JoinResView:
        # more than 1 child
        selectAlias = parentNode.JoinResView.selectAttrAlias.copy()
        fromTable = parentNode.JoinResView.viewName
        rightMost = countZ(selectAlias) * 'Z'
        selectAttrs = [''] * len(selectAlias)
        for index, alias in enumerate(selectAlias):
            if 'Z' in alias:
                selectAttrs[index] = fromTable + '.' + alias
                
        selectAlias.append(rightMost + 'Z')
        selectAttrs.append(parentNode.JoinResView.viewName + '.' + rightMost + '+' + aggMax.viewName + '.' + aggMax.selectAttrAlias[-1])
    else:
        selectAttrs = parentNode.col2vars[1].copy()
        selectAlias = parentNode.cols.copy()
        index = selectAttrs.index('rating')
        selectAlias[index] = 'Z'
        selectAttrs.append(parentNode.source + '.' + selectAttrs[-1] + '+' + aggMax.viewName + '.' + aggMax.selectAttrAlias[-1])
        selectAlias.append('ZZ')
        fromTable = parentNode.source
    
    joinTable = aggMax.viewName
    usingJoinKey, whereCondList = [], []
    if parentNode.JoinResView:
        usingJoinKey = joinKey
    else:
        if len(joinKey) == 1:
            originalName = parentNode.col2vars[1][parentNode.col2vars[0].index(joinKey[0])]
            cond = parentNode.source + '.' + originalName + '=' + aggMax.viewName + '.' + joinKey[0]
            whereCondList.append(cond)
        else:
            for key in joinKey:
                originalName = parentNode.col2vars[1][parentNode.col2vars[0].index(key)]
                cond = parentNode.source + '.' + originalName + '=' + aggMax.viewName + '.' + key
                whereCondList.append(cond)
    
    if lastRel:
        joinRes = WithView(viewName, selectAttrs, selectAlias, fromTable, joinTable, joinKey, usingJoinKey, whereCondList, orderBy=[selectAlias[-1]], DESC=DESC, limit=limit)
    else:
        joinRes = WithView(viewName, selectAttrs, selectAlias, fromTable, joinTable, joinKey, usingJoinKey, whereCondList)
    
    retReduce = ProductKReducePhase(leafExtra, aggMax, joinRes, groupBy=joinKey, reduceRel=reduceRel)
    return retReduce
        

def buildLevelKEnumPhase(previousView: Union[WithView, EnumLogLoopView], corReducePhase: LevelKReducePhase, JT: JoinTree, base: int = 2, DESC: bool = True, limit: int = 1024) -> LevelKEnumPhase:
    rankView: EnumRankView = None
    logkLoop: list[EnumLogLoopView] = []
    logFinalView = None
    
    # 1. rankView
    maxView = truncateView = finalView = None
    ## (1) maxView
    viewName = previousView.viewName + '_max' + str(randint(0, 10000))
    fromTable = previousView.viewName
    joinKey = corReducePhase.orderView.joinKey
    usingJoinKey = []
    selectAttr, selectAlias = [], []
    if len(joinKey) == 1:
        selectAttr.append('')
        selectAlias.append(joinKey[0])
        groupBy = [joinKey[0]]
    else:
        for key in joinKey:
            selectAttr.append('')
            selectAlias.append(key)
        groupBy = joinKey
        
    selectAttr.append('max(rating)')
    selectAlias.append('max_weight')
    
    maxView = WithView(viewName, selectAttr, selectAlias, fromTable, groupBy=groupBy)
    ## (2) truncateView
    origiNode = JT.getNode(corReducePhase.reduceRel.dst.id)
    joinTable = origiNode.JoinResView.viewName if origiNode.JoinResView else origiNode.source
    viewName = origiNode.alias + '_truncated' + str(randint(0, 10000))
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
        if len(joinKey) == 1:
            whereCond = fromTable + '.' + joinKey[0] + '=' + joinTable + '.' + origiNode.col2vars[1][origiNode.cols.index(joinKey[0])]
            whereCondList.append(whereCond)
        else:
            for key in joinKey:
                whereCond = fromTable + '.' + key + '=' + joinTable + '.' + origiNode.col2vars[1][origiNode.cols.index(key)]
                whereCondList.append(whereCond)
                
    orderBy = ['max_weight + accweight']
    truncateView = WithView(viewName, selectAttr, selectAlias, fromTable, joinTable, joinKey=joinKey, usingJoinKey=usingJoinKey, whereCondList=whereCondList, orderBy=orderBy, DESC=DESC, limit=limit)
    ## (3) finalView
    viewName = origiNode.alias + '_rnk' + str(randint(0, 10000))
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
            viewName = 'levelk_left_' + str(i) + str(randint(0, 10000))
            # select only attrs from one table cols
            selectAlias = [attr for attr in logkLoop[-1].levelk_join.selectAttrAlias if attr not in rePhraseWords and attr in previousView.selectAttrAlias]  # original attrs need to be passed
            selectAttr = [''] * len(selectAlias)
            selectAlias.append('rating')
            selectAttr.append('left_weight')
            rnCond = ['rnk=' + str(eval('*'.join([str(base)] * i)))]
            fromTable = logkLoop[-1].levelk_join.viewName
            levelk_left = EnumSelectRN(viewName, selectAttr, selectAlias, fromTable, rnCond)
        ## (b) levelk_right
        viewName = 'levelk_right_' + str(i) + str(randint(0, 10000))
        fromTable = rankView.finalView.viewName
        selectAlias = ['*']
        rnCond = []
        if i != 0:
            rnCond.append('rnk>' + str(eval('*'.join([str(base)] * i))))
        rnCond.append('rnk<=' + str(eval('*'.join([str(base)] * (i+1)))))
        levelk_right = EnumSelectRN(viewName, [], selectAlias, fromTable, rnCond)
        ## (c) levelk_join
        viewName = 'levelk_join_' + str(i) + str(randint(0, 10000))
        joinTable = levelk_right.viewName
        selectAlias = list(set(previousView.selectAttrAlias) | set(rankView.finalView.selectAttrAlias))
        selectAlias = [attr for attr in selectAlias if attr not in rePhraseWords]
        selectAttr = [''] * len(selectAlias)
        selectAttr.append(levelk_right.viewName + '.rnk')
        selectAlias.append('rnk')
        if i != 0:
            fromTable = levelk_left.viewName
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
            levelk_join = EnumJoinUnion(viewName, selectAttr, selectAlias, fromTable, joinTable, unionTable=logkLoop[-1].levelk_join.viewName, joinKey=joinKey, usingJoinKey=usingJoinKey, orderBy=['accweight'], DESC=DESC, limit=limit)
        else:
            levelk_join = EnumJoinUnion(viewName, selectAttr, selectAlias, fromTable, joinTable, joinKey=joinKey, usingJoinKey=usingJoinKey, orderBy=['accweight'], DESC=DESC, limit=limit)
        
        oneLoop = EnumLogLoopView(i, levelk_left, levelk_right, levelk_join)
        logkLoop.append(oneLoop)
    
    # logKFinal
    viewName = origiNode.alias + '_acc' + str(randint(0, 10000))
    selectAlias = [attr for attr in logkLoop[-1].levelk_join.selectAttrAlias if attr not in rePhraseWords]
    selectAlias.append('rating')
    selectAttr = [''] * len(selectAlias)
    fromTable = logkLoop[-1].levelk_join.viewName
    logFinalView = Action(viewName, selectAttr, selectAlias, fromTable)
    
    retEnum = LevelKEnumPhase(rankView, logkLoop, logFinalView)
    return retEnum
            

def buildProductKEnumPhase(previousView: WithView, corReducePhase: LevelKReducePhase, JT: JoinTree, lastRel: bool = False, DESC: bool = True, limit: int = 1024) -> ProductKEnumPhase:
    aggMax = pruneJoin = joinRes = None
    parentNode = JT.getNode(corReducePhase.reduceRel.src.id)
    childNode = JT.getNode(corReducePhase.reduceRel.dst.id)
    
    def countZ(alias: list[str]):
        maxNum = 0
        for a in alias:
            if 'Z' in a:
                num = a.count('Z')
                maxNum = max(num, maxNum)
        return maxNum
    
    def calDoneChild():
        undone = 0
        for child in parentNode.children:
            if not child.enumDone:
                undone += 1
        return undone
    
    # 1. aggMax
    viewName = parentNode.alias + str(randint(0, 1000))
    joinKey = list(set(parentNode.cols) & set(childNode.cols))
    selectAttr, selectAlias = [], []
    selectAttr = [''] * len(joinKey)
    selectAlias.extend(joinKey)
    selectAlias.append('Z')
    
    unDoneChild = calDoneChild()
    selectAttr.append('max(' + 'Z' * unDoneChild + ')')
    
    fromTable = previousView.viewName
    aggMax = Action(viewName, selectAttr, selectAlias, fromTable)
    
    # 2. pruneJoin
    viewName = childNode.alias + '_prune' + str(randint(0, 1000))
    fromTable = childNode.JoinResView.viewName
    joinTable = aggMax.viewName
    selectAlias = childNode.JoinResView.selectAttrAlias
    selectAttr = [''] * len(selectAlias)
    index = selectAlias.index('Z')
    selectAttr[index] = fromTable + '.Z'
    usingJoinKey = joinKey
    orderBy = [joinTable + '.Z' + '+' + fromTable + '.' + 'Z' * countZ(selectAlias)]
    pruneJoin = WithView(viewName, selectAttr, selectAlias, fromTable, joinTable, joinKey, usingJoinKey, orderBy=orderBy, DESC=DESC, limit=limit)
    
    # 3. joinRes
    viewName = childNode.alias + '_join' + str(randint(0, 1000))
    fromTable = previousView.viewName
    joinTable = pruneJoin.viewName
    selectAlias = [alias for alias in previousView.selectAttrAlias if 'v' in alias]
    selectAlias += childNode.JoinResView.selectAttrAlias
    selectAlias = list(set(selectAlias))
    selectAttr = [''] * len(selectAlias)
    leftZ = fromTable + '.Z + '
    rightZ = joinTable + '.'
    countMaxZ = countZ(pruneJoin.selectAttrAlias)
    for i in range(len(selectAlias)-1, -1, -1):
        each = selectAlias[i]
        if 'Z' in each and each.count('Z') != countMaxZ:
            selectAttr[i] = leftZ + rightZ + each
            selectAlias[i] = each
        elif each.count('Z') == countMaxZ:
            selectAlias.remove(each)
            selectAttr.pop(i)
            
    firstOrder = 'Z' * aggMax.selectAttrs[-1].count('Z')
    countMaxZ = countZ(pruneJoin.selectAttrAlias)
    if lastRel:
        orderBy = ['Z']
    else:
        orderBy = [fromTable + '.' + firstOrder + '+' + joinTable + '.' + 'Z' * countMaxZ]
    joinRes = WithView(viewName, selectAttr, selectAlias, fromTable, joinTable, joinKey, usingJoinKey, orderBy=orderBy, DESC=DESC, limit=limit)
    retEnum = ProductKEnumPhase(aggMax, pruneJoin, joinRes, groupBy=joinKey)
    
    childNode.enumDone = True
    return retEnum
    

def generateTopKIR(JT: JoinTree, outputVariables: list[str], computations: CompList, IRmode: IRType = IRType.Level_K, base: int = 2, DESC: bool = True, limit: int = 1024) -> [list[ReducePhase], list[EnumeratePhase], str]:
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
                JT.getNode(rel.src.id).JoinResView = retReduce.orderView
            else:
                retReduce = buildProductKReducePhase(rel, JT, DESC=DESC, limit=limit)
                # NOTE: pass leaf view for later enumeration
                childNode = JT.getNode(rel.dst.id)
                if childNode.isLeaf:
                    childNode.JoinResView = retReduce.leafExtra
                JT.getNode(rel.src.id).JoinResView = retReduce.joinRes
        else:
            if IRmode == IRType.Level_K:
                retReduce = buildLevelKReducePhase(rel, JT, lastRel=True, DESC=DESC, limit=limit)
                JT.getNode(rel.src.id).JoinResView = retReduce.orderView
            else:
                retReduce = buildProductKReducePhase(rel, JT, lastRel=True, DESC=DESC, limit=limit)
                # NOTE: pass leaf view for later enumeration
                childNode = JT.getNode(rel.dst.id)
                if childNode.isLeaf:
                    childNode.JoinResView = retReduce.leafExtra
                JT.getNode(rel.src.id).JoinResView = retReduce.joinRes
        
        reduceList.append(retReduce)
        jointree.removeEdge(rel)
        remainRelations = jointree.getRelations().values()
        
        
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
        output.append('rating')
    
    elif IRmode == IRType.Product_K:
        for index, enum in enumerate(enumerateOrder):
            beginPrevious = enumerateOrder[0].joinRes
            if enumerateList == []:
                previousView = beginPrevious
            else:
                previousView = enumerateList[-1].joinRes
            lastRel = True if (index == len(enumerateOrder) - 1) else False
            retEnum = buildProductKEnumPhase(previousView, enum, JT, lastRel=lastRel, DESC=DESC, limit=limit)
            enumerateList.append(retEnum)
            
        fromTable = enumerateList[-1].joinRes.viewName
        output = [out for out in outputVariables if out in enumerateList[-1].joinRes.selectAttrAlias]
        output.append('Z')
    
    # TODO: Check
    finalResult = 'select sum(' + '+'.join(output) + ') from ' + fromTable + ';\n'
    
    return reduceList, enumerateList, finalResult
    
            
        
 