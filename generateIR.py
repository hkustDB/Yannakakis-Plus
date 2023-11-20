from enumerate import *
from reduce import *
from jointree import *
from comparison import *
from enumsType import *
from random import choice, randint
from sys import maxsize
import re

'''helperAttrLeft/Right: helper attribute name change[from, to]
   incidentComp: [first] long, [second] short
'''

def buildJoinRelation(preNode: TreeNode, inNode: TreeNode) -> str:
    whereCondList = []
    joinKey = set(inNode.cols) & set(preNode.cols)
    joinKey1 = [preNode.col2vars[1][preNode.col2vars[0].index(key)] for key in joinKey]
    joinKey2 = [inNode.col2vars[1][inNode.col2vars[0].index(key)] for key in joinKey]
    # not using alias for var any more
    for i in range(len(joinKey1)):
        whereCond = preNode.alias + '.' + joinKey1[i] + '=' + inNode.alias + '.' + joinKey2[i]
        whereCondList.append(whereCond)
        
    return whereCondList

def buildPrepareView(JT: JoinTree, childNode: TreeNode) -> CreateTableAggView:
    if childNode.createViewAlready: return None
    
    prepareView = None
    if childNode.relationType == RelationType.BagRelation:
        joinTableList, whereCondList = [], []
        for index, id in enumerate(childNode.insideId):
            inNode = JT.getNode(id)
            if inNode.relationType == RelationType.TableScanRelation: # still need source alias
                joinTableList.append(inNode.source + ' as ' + inNode.alias) 
            else :
                joinTableList.append(inNode.alias)
            # NOTE: Assume internal nodes arrange by circle sequence
            if index > 0:
                preNode = JT.getNode(childNode.insideId[index-1])
                subWhereCondList = buildJoinRelation(preNode, inNode)
                whereCondList.extend(subWhereCondList)
        
        whereCondList.extend(buildJoinRelation(JT.getNode(id), JT.getNode(childNode.insideId[0])))
        prepareView = CreateBagView(childNode.alias, childNode.col2vars[1], childNode.cols, '', joinTableList, whereCondList)
    
    elif childNode.relationType == RelationType.AuxiliaryRelation: # must have child
        supNode = JT.getNode(childNode.supRelationId)
        fromTable = supNode.source + ' as ' + supNode.alias if supNode.alias != supNode.source else supNode.source
        prepareView = CreateAuxView(childNode.alias, childNode.col2vars[1], childNode.cols, fromTable)

    elif childNode.relationType == RelationType.TableAggRelation: 
        aggNodes = childNode.aggRelation
        fromTable = childNode.source # + ' as ' + childNode.alias if childNode.alias != childNode.source else childNode.source
        joinTableList = []
        whereCondList = []
        aggFuncVars = []    # recognize the variables do not need alias
        for aggId in aggNodes:
            # use whereCond to join 
            aggNode = JT.getNode(aggId)
            tableName = '(SELECT ' + aggNode.col2vars[1][0] + ', ' + aggNode.col2vars[1][1] + ' AS ' + aggNode.cols[1] + ' FROM ' + aggNode.source + ' GROUP BY ' + aggNode.col2vars[1][0] + ')' + ' AS ' + aggNode.alias
            joinTableList.append(tableName)
            aggJoinVars = aggNode.cols[:-1]
            if len(aggJoinVars) > 1:
                raise NotImplementedError("More than 2 values in group by")
            tableJoinKeyIdx = childNode.cols.index(aggNode.cols[0])
            tabelJoinName = childNode.col2vars[1][tableJoinKeyIdx]
            whereCond = childNode.source + '.' + tabelJoinName + ' = ' + aggNode.alias + '.' + aggNode.col2vars[1][0]
            whereCondList.append(whereCond)
            aggFuncVars.append(aggNode.cols[1])
        
        # TODO: Add childNode.alias + '.' + joinKey
        originalVars = [] # need as `alias` else ''
        for idx, each in enumerate(childNode.col2vars[0]):
            val = childNode.source + '.' + childNode.col2vars[1][idx] if each not in aggFuncVars else ''
            originalVars.append(val)

        prepareView = CreateTableAggView(childNode.alias, originalVars, childNode.cols, fromTable, joinTableList, whereCondList)
    
    # TableScan
    else: 
        return None
    
    childNode.createViewAlready = True
    return prepareView
    

def buildReducePhase(reduceRel: Edge, JT: JoinTree, incidentComp: list[Comparison], direction: Direction, helperLeft: list[str, str] = ['', ''], helperRight: list[str, str] = ['', '']) -> ReducePhase:
    childNode = JT.getNode(reduceRel.dst.id)
    parentNode = JT.getNode(reduceRel.src.id)
    prepareView = []
    orderView = minView = joinView = semiView = None
    # 1. prepareView(Aux, Agg, Bag create view using child alias)
    if childNode.isLeaf:
        ret = buildPrepareView(JT, childNode)
        if ret is not None: prepareView.append(ret)
    ret = buildPrepareView(JT, parentNode)
    if ret is not None: prepareView.append(ret)
    
    if direction != Direction.SemiJoin and len(incidentComp) == 1 :
    # 2. orderView
        viewName = 'orderView' + str(randint(0, maxsize))
        comp = incidentComp[0]
        if childNode.relationType != RelationType.TableAggRelation:
            fromTable = childNode.source + ' as ' + childNode.alias if childNode.alias != childNode.source else childNode.source
        else:
            fromTable = childNode.alias
            
        joinKey = list(set(childNode.cols) & set(parentNode.cols))
        orderKey = [] # leave for primary key space in orderKey
        AESC = True
        if direction == Direction.Left or direction == Direction.RootLeft:
            orderKey.append(helperLeft[0])
            AESC = True if '<' in comp.op else False 
        elif direction == Direction.Right or direction == Direction.RootRight:
            orderKey.append(helperRight[0])
            AESC = True if '>' in comp.op else False

        # need append new col, only root relation happens
        extraAlias, extraAttr = '', ''
        transVarList = []
        if orderKey[-1] not in childNode.cols:
            if childNode.relationType != RelationType.TableScanRelation: # can use alias directly
                extraAttr = orderKey[-1]
            else: # Can only be TableScan
                op = ''
                if '*' in orderKey[-1]:
                    varAlias = orderKey[-1].split('*')
                    op = '*'
                elif '+' in orderKey[-1]:
                    varAlias = orderKey[-1].split('+')
                    op = '+'
                else:
                    raise NotImplementedError("Not implement other op! ") 
                
                for var in varAlias:
                    idx = childNode.cols.index(var)
                    transVar = childNode.alias + '.' + childNode.col2vars[1][idx]
                    transVarList.append(transVar)
                
                extraAttr = op.join(transVarList)
            extraAlias = 'ori' + ('Left' if (direction == Direction.Left or direction == Direction.RootLeft) else 'Right')
            helperLeft[0] = extraAlias if 'Left' in extraAlias else helperLeft[0]
            helperRight[0] = extraAlias if 'Right' in extraAlias else helperRight[0]
            
        if childNode.relationType == RelationType.TableScanRelation: # TableAgg cast alias when preparing the view   
            orderView = CreateOrderView(viewName, childNode.col2vars[1] + [extraAttr], childNode.cols + [extraAlias], fromTable, joinKey, orderKey, AESC)
        else:
            orderView = CreateOrderView(viewName, ['' for i in range(len(childNode.cols))] + [extraAttr], childNode.cols + [extraAlias], fromTable, joinKey, orderKey, AESC)
            
    # 3. minView
        viewName = 'minView' + str(randint(0, maxsize))
        mfAttr = helperLeft if direction == Direction.Left or direction == Direction.RootLeft else helperRight
        mfWords = mfAttr[0] + ' as ' + mfAttr[1]
        selectAttrAlias = joinKey + [mfWords]
        fromTable = orderView.viewName
        minView = SelectMinAttr(viewName, [], selectAttrAlias, fromTable)
    
    # 4. joinView
        viewName = 'joinView' + str(randint(0, maxsize))
        joinCond = ''
        selectAttributes, selectAttributesAs = [], []
        if parentNode.JoinResView is not None: # already has alias 
            selectAttributesAs = parentNode.JoinResView.selectAttrAlias + [mfAttr[1]]
        else:
            selectAttributes = parentNode.col2vars[1] + ['']
            selectAttributesAs = parentNode.cols + [mfAttr[1]]
        joinCondList = []
        # still need alias casting, new table join
        for eachKey in joinKey:
            cond = ''
            # not root, cast to alias already in the first one side
            if parentNode.JoinResView is None: # use original
                originalName = parentNode.col2vars[1][parentNode.col2vars[0].index(eachKey)]
                cond = parentNode.alias + '.' + originalName + '=' + minView.viewName + '.' + eachKey
            # else:  previous join view already cast to alias
                # cond = parentNode.JoinResView.viewName + '.' + eachKey + '=' + minView.viewName + '.' + eachKey
            
            joinCondList.append(cond)
        joinCond = ' and '.join(joinCondList)
            
        # original table or previous view
        fromTable = ''
        if parentNode.JoinResView is None:
            fromTable = parentNode.source + ' AS ' + parentNode.alias
        else:
            fromTable = parentNode.JoinResView.viewName
        
        if direction != Direction.RootLeft and direction != Direction.RootRight:
            joinView = Join2tables(viewName, selectAttributes, selectAttributesAs, fromTable, minView.viewName, joinKey, joinCond)
        else:   # Root join, need add mf_left < mf_right
            joinView = Join2tables(viewName, selectAttributes, selectAttributesAs, fromTable, minView.viewName, joinKey, joinCond, helperLeft[1] + comp.op + helperRight[1])
    
    elif len(incidentComp) > 1:
        raise NotImplementedError("# Comparisons >= 2 case is not implemented yet! ")
    
    else:
        raise NotImplementedError("SemiJoin case is not implemented! ")
    
    # End
    type = PhaseType.SemiJoin if direction == Direction.SemiJoin else PhaseType.CQC
    retReducePhase = ReducePhase(prepareView, orderView, minView, joinView, semiView, childNode.id, direction, type, comp.op, incidentComp)
    return retReducePhase


def buildEnumeratePhase(previousView: Action, corReducePhase: ReducePhase) -> EnumeratePhase:
    createSample = selectMax = selectTarget = stageEnd = None
    # 1. createSample
    viewName = 'sample' + str(randint(0, maxsize))
    createSample = CreateSample(viewName, [], ['*'], corReducePhase.orderView.viewName)
    # 2. selectMax
    viewName = 'maxRn' + str(randint(0, maxsize))
    selectAttrAlias = joinKey = groupCond = corReducePhase.joinView.joinKey
    fromTable = previousView.viewName
    joinTable = createSample.viewName
    leftMf, rightMf = re.split('\s*[<>]=?\s*', previousView.whereCond)
    oriMfFrom, oriMfTo = corReducePhase.minView.selectAttrAlias[-1].split(' as ')
    errorFlag = False
    changeSide = 0      # 0: change left Mf value, 1: change right
    if (corReducePhase.reduceDirection == Direction.Left or corReducePhase.reduceDirection == Direction.RootLeft) and '<' in corReducePhase.reduceOp:
        errorFlag = True if leftMf != oriMfTo else False
        leftMf = oriMfFrom 
    elif (corReducePhase.reduceDirection == Direction.Left or corReducePhase.reduceDirection == Direction.RootLeft) and '>' in corReducePhase.reduceOp:
        errorFlag = True if rightMf != oriMfTo else False
        rightMf = oriMfFrom
        changeSide = 1 
    elif (corReducePhase.reduceDirection == Direction.Right or corReducePhase.reduceDirection == Direction.RootRight) and '<' in corReducePhase.reduceOp:
        errorFlag = True if rightMf != oriMfTo else False
        rightMf = oriMfFrom
        changeSide = 1
    elif (corReducePhase.reduceDirection == Direction.Right or corReducePhase.reduceDirection == Direction.RootRight) and '>' in corReducePhase.reduceOp:
        errorFlag = True if leftMf != oriMfTo else False
        leftMf = oriMfFrom 
    
    if errorFlag:
        raise RuntimeError("Mf value error! ")
        
    # used as stageEnd whereCond as well
    whereCond = leftMf + corReducePhase.reduceOp + rightMf
    selectMax = SelectMaxRn(viewName, [], selectAttrAlias, fromTable, joinTable, joinKey, '', whereCond, groupCond)
    # 3. selectTarget
    viewName = 'target' + str(randint(0, maxsize))
    # TODO: Error here, alias should be v4, v6, v10
    selectAttrAlias = corReducePhase.orderView.selectAttrAlias
    '''
    if changeSide == 0:
        selectAttrAlias += [leftMf] if leftMf != '' else []
    else:
        selectAttrAlias += [rightMf] if rightMf != '' else []
    '''
    fromTable = createSample.fromTable
    joinTable = selectMax.viewName
    joinKey = selectMax.selectAttrAlias
    selectTarget = SelectTargetSource(viewName, [], selectAttrAlias, fromTable, joinTable, joinKey)
    # 4. stageEnd 
    # TODO: check alias
    viewName = 'end' + str(randint(0, maxsize))
    selectAttrAlias = set(previousView.selectAttrAlias) | set(selectTarget.selectAttrAlias) # alias union + mf value
    selectAttrAlias = [alias for alias in selectAttrAlias if 'mf' not in alias]             # remove all old mf first
    selectAttrAlias += [leftMf] if leftMf != '' and 'mf' in leftMf else []
    selectAttrAlias += [rightMf] if rightMf != '' and 'mf' in rightMf else []
    fromTable = previousView.viewName
    joinTable = selectTarget.viewName
    joinKey = selectMax.joinKey
    stageEnd = StageEnd(viewName, [], selectAttrAlias, fromTable, joinTable, joinKey, '', whereCond)

    retEnum = EnumeratePhase(createSample, selectMax, selectTarget, stageEnd, corReducePhase.corresNodeId, corReducePhase.reduceDirection, corReducePhase.PhaseType)
    return retEnum

def generateIR(JT: JoinTree, COMP: dict[int, Comparison]) -> [list[ReducePhase], list[EnumeratePhase]]:
    jointree = JT
    remainRelations = jointree.getRelations().values()
    print(COMP)
    comparisons = COMP.values()    
    print(type(comparisons))         
    reduceList: list[ReducePhase] = []
    enumerateList: list[EnumeratePhase] = []
    
    def getLeafRelation(relations: list[Edge]) -> list[Edge]:
        # TODO: Change needs for Complex comparison's two sides
        leafRelation = [rel for rel in relations if rel.dst.isLeaf and not rel.dst.isRoot]
        return leafRelation
        
    '''Get incident comparisons'''
    def getCompRelation(relation: Edge) -> list[Comparison]:
        corresComp = [comp for comp in comparisons if rel.dst.id == comp.beginNodeId or rel.dst.id == comp.endNodeId]
        numLong = len([comp for comp in corresComp if len(comp.path) > 1])
        if numLong < 2 and not relation.dst.isRoot:
            return corresComp
        else:
            raise NotImplementedError("Can only Support one incident long comparison or the dst is root! ")
    
    def updateComprison(compList: list[Comparison], updateDirection: list[Direction]):
        '''Update comparisons'''
        if len(compList) == 0: return
        else:
            for index, update in enumerate(updateDirection):
                if update == Direction.Left:
                    compList[index].deletePath(Direction.Left) # compList reference to comparisons
                elif update == Direction.Right:
                    compList[index].deletePath(Direction.Right)
                    
        # print(comparisons)
                    
    
    '''Step1: Reduce'''
    while len(remainRelations) > 1:
        leafRelation = getLeafRelation(remainRelations)
        rel = choice(leafRelation)
        incidentComp = getCompRelation(rel)
        updateDirection = []
        retReduce = None
        if len(incidentComp) <= 2:
            if len(incidentComp) == 0:  # semijoin only
                retReduce = buildReducePhase(rel, JT, incidentComp, Direction.SemiJoin)
            elif len(incidentComp) == 1:
                onlyComp = incidentComp[0]
                if (onlyComp.getPredType == predType.Long):
                    if rel.dst.id == onlyComp.getBeginNodeId:
                        pathIdx = onlyComp.originPath.index([rel.dst.id, rel.src.id])
                        helperLeftFrom = onlyComp.helperAttr[pathIdx-1][1] if rel.dst.id != onlyComp.originBeginNodeId else onlyComp.left
                        helperLeftTo = 'mfL' + str(randint(0, maxsize))
                        onlyComp.helperAttr[pathIdx] = [helperLeftFrom, helperLeftTo]
                        retReduce = buildReducePhase(rel, JT, incidentComp, Direction.Left, [helperLeftFrom, helperLeftTo], ['', ''])
                        updateDirection.append(Direction.Left)
                    elif rel.dst.id == onlyComp.getEndNodeId:
                        pathIdx = onlyComp.originPath.index([rel.src.id, rel.dst.id])
                        helperRightFrom = onlyComp.helperAttr[pathIdx+1][0] if rel.dst.id != onlyComp.originEndNodeId else onlyComp.right
                        helperRightTo = 'mfR' + str(randint(0, maxsize))
                        onlyComp.helperAttr[pathIdx] = [helperRightTo, helperRightFrom]
                        retReduce = buildReducePhase(rel, JT, incidentComp, Direction.Right, ['', ''], [helperRightFrom, helperRightTo])
                        updateDirection.append(Direction.Right)
                    else:
                        raise RuntimeError("Should not happen! ")
                else:
                    # short comparison
                    raise NotImplementedError("Need to support short comparison!")
                
            else :
                # use reverseOp to judge the case
                raise NotImplementedError("Need to two incident comparison!")
        else: 
            raise NotImplementedError("Incident more than two comparisons is not implemented! ")
        jointree.removeEdge(rel)
        remainRelations = jointree.getRelations().values()
        updateComprison(incidentComp, updateDirection)
        reduceList.append(retReduce)
        # Attach reduce to JoinTree & update previous join result view name
        JT.getNode(rel.dst.id).reducePhase = retReduce  
        JT.getNode(rel.src.id).JoinResView = retReduce.joinView
            
    # remianRelations == 1
    rel = list(remainRelations)[0]
    incidentComp = getCompRelation(rel)
    if len(incidentComp) <= 2:
        if len(incidentComp) == 0:  # semijoin only
            retReduce = buildReducePhase(rel, JT, incidentComp, Direction.SemiJoin)
        elif len(incidentComp) == 1:
            onlyComp = incidentComp[0]
            if (onlyComp.getPredType == predType.Short):
                # last relation mfToLeft #COMP mfToRight
                if rel.dst.id == onlyComp.getBeginNodeId: # dst -> root
                    pathIdx = onlyComp.originPath.index([rel.dst.id, rel.src.id])
                    helperLeftFrom = onlyComp.helperAttr[pathIdx-1][1] if rel.dst.id != onlyComp.originBeginNodeId else onlyComp.left
                    helperLeftTo = 'mfL' + str(randint(0, maxsize))
                    helperRightFrom = onlyComp.helperAttr[pathIdx+1][0]
                    onlyComp.helperAttr[pathIdx] = [helperLeftFrom, helperLeftTo] # update
                    retReduce = buildReducePhase(rel, JT, incidentComp, Direction.RootLeft, [helperLeftFrom, helperLeftTo], [helperRightFrom, helperRightFrom])
                elif rel.dst.id == onlyComp.getEndNodeId: # root <- dst
                    pathIdx = onlyComp.originPath.index([rel.src.id, rel.dst.id])
                    helperLeftFrom = onlyComp.helperAttr[pathIdx-1][1] # left mf, no alias any more
                    helperRightFrom = onlyComp.helperAttr[pathIdx+1][0] if rel.dst.id != onlyComp.originEndNodeId else onlyComp.right
                    helperRightTo = 'mfR' + str(randint(0, maxsize))
                    onlyComp.helperAttr[pathIdx] = [helperRightTo, helperRightFrom] # update
                    retReduce = buildReducePhase(rel, JT, incidentComp, Direction.RootRight, [helperLeftFrom, helperLeftFrom], [helperRightFrom, helperRightTo])
                else:
                    raise RuntimeError("Last comparison error! ")
            else:
                # Long comparison
                raise NotImplementedError("Should only be short comparison!")
        else :
            # use reverseOp to judge the case
            raise NotImplementedError("Need to support two incident comparison in root!")
    else: 
        raise NotImplementedError("Incident more than two comparisons is not implemented! ")
    reduceList.append(retReduce)
    # attach ReducePhase to the TreeNode
    JT.getNode(rel.dst.id).reducePhase = retReduce
    
    
    '''Step2: Enumerate'''
    enumerateOrder = [enum for enum in reduceList if JT.getNode(enum.corresNodeId) in JT.subset] if not JT.isFull else reduceList.copy()
    enumerateOrder.reverse()
    for enum in enumerateOrder:
        previousView = enumerateOrder[0].joinView if enumerateList == [] else enumerateList[-1].stageEnd
        retEnum = buildEnumeratePhase(previousView, enum)
        enumerateList.append(retEnum)
        
    return reduceList, enumerateList
    
