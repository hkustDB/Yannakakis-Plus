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

def buildReducePhase(reduceRel: Edge, JT: JoinTree, incidentComp: list[Comparison], direction: Direction, helperLeft: list[str, str] = ['', ''], helperRight: list[str, str] = ['', '']) -> ReducePhase:
    childNode = reduceRel.dst
    parentNode = reduceRel.src
    # 1. prepareView
    prepareView = orderView = minView = joinView = semiView = None
    if childNode.relationType == RelationType.BagRelation:
        joinTableList = []
        for id in childNode.insideId:
            node = JT.getNode(id)
            
        prepareView = CreateBagView(childNode.alias, childNode.col2vars[1], childNode.cols, '', childNode.inAlias)
        
    elif childNode.relationType == RelationType.AuxiliaryRelation:
        supNode = JT.getNode(childNode.supRelationId)
        fromTable = supNode.source + ' as ' + supNode.alias if supNode.alias != supNode.source else supNode.source
        prepareView = CreateAuxView(childNode.alias, childNode.col2vars[1], childNode.cols, fromTable)
        
    elif childNode.relationType == RelationType.TableAggRelation: # TODO: Look if alias is fine
        aggNodes = childNode.aggRelation
        fromTable = childNode.source + ' as ' + childNode.alias if childNode.alias != childNode.source else childNode.source
        joinTable = []
        for aggId in aggNodes:
            aggNode = JT.getNode(aggId)
            tableName = aggNode.source + ' as ' + aggNode.alias if aggNode.alias != aggNode.source else aggNode.source
            joinTable.append(tableName)
        
        prepareView = CreateTableAggView(childNode.alias, childNode.col2vars[1], childNode.cols, fromTable, joinTable)
    
    
    if direction != Direction.SemiJoin and len(incidentComp) == 1 :
        # 2. orderView
        viewName = 'orderView' + str(randint(0, maxsize))
        comp = incidentComp[0]
        fromTable = childNode.source + ' as ' + childNode.alias if childNode.alias != childNode.source else childNode.source
        joinKey = list(set(childNode.cols) & set(parentNode.cols))
        orderKey = ''
        AESC = True
        if direction == Direction.Left or direction == Direction.RootLeft:
            orderKey = helperLeft[0]
            AESC = True if '<' in comp.op else False 
        elif direction == Direction.Right or direction == Direction.RootRight:
            orderKey = helperRight[0]
            AESC = True if '>' in comp.op else False
            
        if childNode.relationType == RelationType.TableScanRelation: # TableAgg cast alias when preparing the view   
            orderView = CreateOrderView(viewName, childNode.col2vars[1], childNode.cols, fromTable, joinKey, orderKey, AESC)
        else:
            orderView = CreateOrderView(viewName, [], childNode.cols, fromTable, joinKey, orderKey, AESC)
            
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
        if parentNode.relationType != RelationType.TableScanRelation:
            # empty means for using <- joinCond = 'using(' + ', '.join(joinKey) + ')'
            joinView = Join2tables(viewName, [], parentNode.cols + [mfAttr[1]], parentNode.alias, minView.viewName, joinKey)
        else:   # still need alias casting
            joinCondList = []
            for eachKey in joinKey:
                # TODO: Check here join condition
                originalName = parentNode.col2vars[1][parentNode.col2vars[0].index(eachKey)]
                cond = parentNode.alias + '.' + originalName + ' as ' + eachKey + '=' + minView.viewName + '.' + eachKey
                joinCondList.append(cond)
            joinCond = ' and '.join(joinCondList)
        
        if direction != Direction.RootLeft and direction != Direction.RootRight:
            joinView = Join2tables(viewName, parentNode.col2vars[1] + [''], parentNode.cols + [mfAttr[1]], parentNode.alias, joinKey, joinCond)
        else:   # Root join, need add mf_left < mf_right
            joinView = Join2tables(viewName, parentNode.col2vars[1] + [''], parentNode.cols + [mfAttr[1]], parentNode.alias, joinKey, joinCond, helperLeft[0] + comp.op + helperRight[0])
    
    elif len(incidentComp) > 1:
        raise NotImplementedError("# Comparisons >= 2 case is not implemented yet! ")
    
    else:
        raise NotImplementedError("SemiJoin case is not implemented! ")
    
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
    leftMf, rightMf = re.split('\s[<>]=?\s', previousView.whereCond)
    oriMfFrom, oriMfTo = corReducePhase.minView.selectAttrAlias[-1].split(' as ')
    errorFlag = False
    changeSide = 0      # 0: change left Mf value, 1: change right
    if (corReducePhase.reduceDirection == Direction.Left or corReducePhase.reduceDirection == Direction.RootLeft) and '<' in corReducePhase.reduceOp:
        leftMf = oriMfFrom 
        errorFlag = True if leftMf != oriMfTo else False
    elif (corReducePhase.reduceDirection == Direction.Left or corReducePhase.reduceDirection == Direction.RootLeft) and '>' in corReducePhase.reduceOp:
        rightMf = oriMfFrom
        changeSide = 1
        errorFlag = True if rightMf != oriMfTo else False
    elif (corReducePhase.reduceDirection == Direction.Right or corReducePhase.reduceDirection == Direction.RootRight) and '<' in corReducePhase.reduceOp:
        rightMf = oriMfFrom
        changeSide = 1
        errorFlag = True if rightMf != oriMfTo else False
    elif (corReducePhase.reduceDirection == Direction.Right or corReducePhase.reduceDirection == Direction.RootRight) and '>' in corReducePhase.reduceOp:
        leftMf = oriMfFrom 
        errorFlag = True if leftMf != oriMfTo else False
    
    if errorFlag:
        raise RuntimeError("Mf value error! ")
        
    # used as stageEnd whereCond as well
    whereCond = leftMf + corReducePhase.reduceOp + rightMf
    selectMax = SelectMaxRn(viewName, [], selectAttrAlias, fromTable, joinTable, joinKey, '', whereCond, groupCond)
    # 3. selectTarget
    viewName = 'target' + str(randint(0, maxsize))
    selectAttrAlias = corReducePhase.orderView.selectAttrAlias + ([leftMf] if leftMf != '' else []) if changeSide == 0 else ([rightMf] if rightMf != '' else [])
    fromTable = createSample.fromTable
    joinTable = selectMax.viewName
    joinKey = selectMax.selectAttrs
    selectTarget = SelectTargetSource(viewName, [], selectAttrAlias, fromTable, joinTable, joinKey)
    # 4. stageEnd
    viewName = 'end' + str(randint(0, maxsize))
    selectAttrAlias = set(previousView.selectAttrAlias) | set(selectTarget.selectAttrAlias) # alias union + mf value
    selectAttrAlias = [alias for alias in selectAttrAlias if 'mf' not in alias]             # remove all old mf first
    selectAttrAlias = selectAttrAlias + [leftMf] if leftMf != '' else [] + [rightMf] if rightMf != '' else []
    fromTable = previousView.viewName
    joinTable = selectTarget.viewName
    joinKey = selectMax.joinKey
    stageEnd = StageEnd(viewName, [], selectAttrAlias, fromTable, joinTable, '', whereCond)

    retEnum = EnumeratePhase(createSample, selectMax, selectTarget, stageEnd, corReducePhase.corresNodeId, corReducePhase.reduceDirection, corReducePhase.PhaseType)
    return retEnum

def generateIR(JT: JoinTree, COMP: dict[int, Comparison]) -> [list[ReducePhase], list[EnumeratePhase]]:
    jointree = JT
    remainRelations = jointree.getRelations().values()
    comparisons = COMP.values()             
    reduceList: list[ReducePhase] = []
    enumerateList: list[EnumeratePhase] = []
    
    def getLeafRelation(relations: list[Edge]) -> list[Edge]:
        # TODO: Change needs for Complex comparison's two sides
        leafRelation = [rel for rel in relations if rel.dst.isLeaf and not rel.dst.isRoot]
        return leafRelation
        
    '''Get incident comparisons'''
    def getCompRelation(relation: Edge) -> list[Comparison]:
        corresComp = [comp for comp in comparisons if rel.dst.id == comp.beginNode or rel.dst.id in comp.endNode]
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
                comparisons.remove(compList[index])
                if update == Direction.Left:
                    compList[index].deletePath(Direction.Left)
                elif update == Direction.Right:
                    compList[index].deletePath(Direction.Right)
                if len(compList[index].path) != 0:
                    comparisons.append(compList[index])
    
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
                    if rel.dst == onlyComp.getBeginNode:
                        pathIdx = onlyComp.originPath.index([rel.dst.id, rel.src.id])
                        helperLeftFrom = onlyComp.helperAttr[pathIdx-1][1] if rel.dst != onlyComp.originBeginNode else onlyComp.left
                        helperLeftTo = 'mf' + str(randint(0, maxsize))
                        onlyComp.helperAttr[pathIdx] = [helperLeftFrom, helperLeftTo]
                        retReduce = buildReducePhase(rel, JT, incidentComp, Direction.Left, [helperLeftFrom, helperLeftTo], ['', ''])
                        updateDirection.append(Direction.Left)
                    elif rel.dst == onlyComp.getEndNode:
                        pathIdx = onlyComp.originPath.index([rel.src.id, rel.dst.id])
                        helperRightFrom = onlyComp.helperAttr[pathIdx+1][0] if rel.dst != onlyComp.originEndNode else onlyComp.right
                        helperRightTo = 'mf' + str(randint(0, maxsize))
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
        retReduce.setCorresNodeId(rel.dst.id)
        reduceList.append(retReduce)
        JT.getNode(rel.dst.id).reducePhase = retReduce  # attach ReducePhase to the TreeNode
            
    # remianRelations == 1
    rel = remainRelations[0]
    incidentComp = getCompRelation(rel)
    if len(incidentComp) <= 2:
        if len(incidentComp) == 0:  # semijoin only
            retReduce = buildReducePhase(rel, JT, incidentComp, Direction.SemiJoin)
        elif len(incidentComp) == 1:
            onlyComp = incidentComp[0]
            if (onlyComp.getPredType == predType.Short):
                if rel.dst == onlyComp.getBeginNode: # dst -> root
                    pathIdx = onlyComp.originPath.index([rel.dst.id, rel.src.id])
                    helperLeftFrom = onlyComp.helperAttr[pathIdx-1][1]
                    helperRightFrom = onlyComp.helperAttr[pathIdx+1][0]
                    onlyComp.helperAttr[pathIdx] = [helperLeftFrom, helperRightFrom] # update
                    retReduce = buildReducePhase(rel, JT, incidentComp, Direction.RootLeft, [helperLeftFrom, ''], [helperRightFrom, ''])
                elif rel.dst == onlyComp.getEndNode: # root <- dst
                    pathIdx = onlyComp.originPath.index([rel.src.id, rel.dst.id])
                    helperLeftFrom = onlyComp.helperAttr[pathIdx-1][1]
                    helperRightFrom = onlyComp.helperAttr[pathIdx+1][0]
                    onlyComp.helperAttr[pathIdx] = [helperLeftFrom, helperRightFrom] # update
                    retReduce = buildReducePhase(rel, JT, incidentComp, Direction.RootRight, [helperLeftFrom, ''], [helperRightFrom, ''])
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
    retReduce.setCorresNodeId(rel.dst.id)
    reduceList.append(retReduce)
    JT.getNode(rel.dst.id).reducePhase = retReduce
    
    '''Step2: Enumerate'''
    enumerateOrder = [enum for enum in reduceList if JT.getNode(enum.corresNodeId) in JT.subset] if not JT.isFull else reduceList
    enumerateOrder.reverse()
    for enum in enumerateOrder:
        previousView = enumerateOrder[0].joinView if enumerateList == [] else enumerateList[-1].stageEnd
        retEnum = buildEnumeratePhase(previousView, enum)
        enumerateList.append(retEnum)
        
    return reduceList, enumerateList
    
