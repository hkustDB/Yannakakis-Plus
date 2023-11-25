from enumerate import *
from reduce import *
from jointree import *
from comparison import *
from enumsType import *
from random import choice, randint
from sys import maxsize
from typing import Union
import re
import copy


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

# prepareView is ahead of joinView
def buildPrepareView(JT: JoinTree, childNode: TreeNode) -> CreateTableAggView:
    if childNode.createViewAlready: return None # only means creave view about bag/tableagg/aux relation, not use for other join
    
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
    
    childNode.createViewAlready = True # only apply for tableAgg & bag relation
    return prepareView
    

def buildReducePhase(reduceRel: Edge, JT: JoinTree, incidentComp: list[Comparison], direction: Direction, helperLeft: list[str, str] = ['', ''], helperRight: list[str, str] = ['', '']) -> ReducePhase:
    childNode = JT.getNode(reduceRel.dst.id)
    parentNode = JT.getNode(reduceRel.src.id)
    prepareView = []
    orderView = minView = joinView = semiView = None
    # 1. prepareView(Aux, Agg, Bag create view using child alias)
    if childNode.isLeaf and childNode.relationType:
        ret = buildPrepareView(JT, childNode)
        if ret is not None: prepareView.append(ret)
    ret = buildPrepareView(JT, parentNode)
    if ret is not None: prepareView.append(ret)
    
    # Extra end
    type = PhaseType.SemiJoin if direction == Direction.SemiJoin else PhaseType.CQC
    
    if direction != Direction.SemiJoin and len(incidentComp) == 1 :
        comp = incidentComp[0]
        
        # Support Relation for auxiliary relation case, all aux relations will be create here
        if parentNode.relationType == RelationType.AuxiliaryRelation and childNode.id == parentNode.supRelationId:
            viewName = childNode.source if childNode.JoinResView is None else childNode.JoinResView.viewName # leaf or join result
            mfAttr = helperLeft if direction == Direction.Left else helperRight
            if mfAttr[1] not in parentNode.cols:
                if childNode.relationType != RelationType.TableScanRelation: # can use alias directly
                    selectAttributes = parentNode.col2vars[1] + ['']
                    selectAttributesAs = parentNode.cols + [mfAttr[1]]
                else :
                    idx = childNode.cols.index(mfAttr[1])
                    selectAttributes = parentNode.col2vars[1] + [childNode.col2vars[1][idx]]
                    selectAttributesAs = parentNode.cols + [mfAttr[1]]
            else:
                selectAttributes = parentNode.col2vars[1]
                selectAttributesAs = parentNode.cols
            supNode = JT.getNode(parentNode.supRelationId)
            # source name directly (abandon alias) or previous join result name
            if childNode.JoinResView is not None:
                fromTable = childNode.JoinResView.viewName 
                prepareView.append(CreateAuxView(parentNode.alias, [], selectAttributesAs, fromTable))
            elif childNode.relationType != RelationType.TableScanRelation:
                fromTable = childNode.alias
                prepareView.append(CreateAuxView(parentNode.alias, [], selectAttributesAs, fromTable))
            else:
                fromTable = childNode.source
                prepareView.append(CreateAuxView(parentNode.alias, selectAttributes, selectAttributesAs, fromTable))
            
            # pass aux viewName for later
            joinView = Join2tables(prepareView[-1].viewName, selectAttributes, selectAttributesAs, '', '', [], '', '')     # pass comparison attributes
            remainPathComp = copy.deepcopy(incidentComp)
            return ReducePhase(prepareView, orderView, minView, joinView, semiView, childNode.id, direction, type, comp.op, remainPathComp, incidentComp, reduceRel)
        # END
        
    # 2. orderView
        viewName = 'orderView' + str(randint(0, maxsize))
        noAliasFlag = False
        if childNode.JoinResView is not None:
            fromTable = childNode.JoinResView.viewName
            noAliasFlag = True
        elif childNode.relationType != RelationType.TableAggRelation:
            fromTable = childNode.source + ' as ' + childNode.alias if childNode.alias != childNode.source else childNode.source
        else:
            fromTable = childNode.alias
            
        if noAliasFlag:
            joinKey = list(set(childNode.JoinResView.selectAttrAlias) & set(parentNode.cols))
        else:
            joinKey = list(set(childNode.cols) & set(parentNode.cols))
        partiKey = joinKey.copy()
        orderKey = [] # leave for primary key space in orderKey
        AESC = True
        if direction == Direction.Left:
            orderKey.append(helperLeft[0])
            AESC = True if '<' in comp.op else False 
        elif direction == Direction.Right:
            orderKey.append(helperRight[0])
            AESC = True if '>' in comp.op else False

        # need append new col, only root relation happens
        extraAlias, extraAttr = '', ''
        transVarList = []
        if noAliasFlag: # v1 * v2 * v3
            if orderKey[-1] not in childNode.JoinResView.selectAttrAlias and 'mf' not in orderKey[-1]:
                extraAttr = orderKey[-1]
        elif orderKey[-1] not in childNode.cols and 'mf' not in orderKey[-1]:
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
            extraAlias = 'ori' + ('Left' if (direction == Direction.Left) else 'Right')
            helperLeft[0] = extraAlias if 'Left' in extraAlias else helperLeft[0]
            helperRight[0] = extraAlias if 'Right' in extraAlias else helperRight[0]
        
        # process orderKey alias in TableScan case, need alias casting
        if not noAliasFlag and 'mf' not in orderKey[-1] and childNode.relationType == RelationType.TableScanRelation:
            idx = childNode.cols.index(orderKey[-1])
            orderKey[-1] = childNode.col2vars[1][idx]
        
        # process partitionByKey alias in TableScan case, need alias casting
        if not noAliasFlag and childNode.relationType == RelationType.TableScanRelation:
            for i in range(len(partiKey)): # multi joinKey
                idx = childNode.cols.index(partiKey[i])
                partiKey[i] = childNode.col2vars[1][idx]
        
        if noAliasFlag:
            if extraAlias == '':
                orderView = CreateOrderView(viewName, [], childNode.JoinResView.selectAttrAlias, fromTable, partiKey, orderKey, AESC)
            else:
                orderView = CreateOrderView(viewName, ['' for i in range(len(childNode.JoinResView.selectAttrAlias))] + [extraAttr], childNode.JoinResView.selectAttrAlias + [extraAlias], fromTable, partiKey, orderKey, AESC)
        elif childNode.relationType == RelationType.TableScanRelation: # TableAgg cast alias when preparing the view  
            if  extraAlias == '':
                orderView = CreateOrderView(viewName, childNode.col2vars[1], childNode.cols, fromTable, partiKey, orderKey, AESC)
            else:
                orderView = CreateOrderView(viewName, childNode.col2vars[1] + [extraAttr], childNode.cols + [extraAlias], fromTable, partiKey, orderKey, AESC)
        else:
            if extraAlias == '':
                orderView = CreateOrderView(viewName, [], childNode.cols, fromTable, partiKey, orderKey, AESC)
            else:
                orderView = CreateOrderView(viewName, ['' for i in range(len(childNode.cols))] + [extraAttr], childNode.cols + [extraAlias], fromTable, partiKey, orderKey, AESC)
            
    # 3. minView
        viewName = 'minView' + str(randint(0, maxsize))
        mfAttr = helperLeft if direction == Direction.Left else helperRight
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
        elif parentNode.relationType != RelationType.TableScanRelation: # create view node already
            selectAttributesAs = parentNode.cols + [mfAttr[1]]
        else:
            selectAttributes = parentNode.col2vars[1] + ['']
            selectAttributesAs = parentNode.cols + [mfAttr[1]]
            
        def splitLR(LR: str):
            if '*' in LR: return LR.split('*'), '*'
            elif '+': return LR.split('+'), '+'
            else: return [LR], ''
        
        def joinSplit(splitVars: list[str], op: str):
            return op.join(splitVars)
        
        # handle extra mf comaprison alias
        whereCond = [helperLeft[1], comp.op, helperRight[1]]
        if len(comp.path) == 1:
            if direction == Direction.Left:     # change right
                if parentNode.JoinResView is None and parentNode.relationType == RelationType.TableScanRelation:
                    splitVars, op = splitLR(whereCond[2])
                    for idx, item in enumerate(splitVars):
                        index = parentNode.cols.index(item)
                        newName = parentNode.col2vars[1][index]
                        splitVars[idx] = newName
                    whereCond[2] = joinSplit(splitVars, op)
            elif direction == Direction.Right:  # change left
                if parentNode.JoinResView is None and parentNode.relationType == RelationType.TableScanRelation:
                    splitVars, op = splitLR(whereCond[0])
                    for idx, item in enumerate(splitVars):
                        index = parentNode.cols.index(item)
                        newName = parentNode.col2vars[1][index]
                        splitVars[idx] = newName
                    whereCond[2] = joinSplit(splitVars, op)
            
        joinCondList = []
        
        alterJoinKey = joinKey.copy()
        # still need alias casting, new table join
        for eachKey in alterJoinKey:
            cond = ''
            # not root, cast to alias already in the first one side
            if parentNode.JoinResView is None and parentNode.relationType == RelationType.TableScanRelation: 
                # use original
                originalName = parentNode.col2vars[1][parentNode.col2vars[0].index(eachKey)]
                cond = parentNode.alias + '.' + originalName + '=' + minView.viewName + '.' + eachKey
                alterJoinKey.remove(eachKey) # remove it from using syntax
            # else:
                # cond = eachKey
            # else:  previous join view already cast to alias
                # cond = parentNode.JoinResView.viewName + '.' + eachKey + '=' + minView.viewName + '.' + eachKey
            
            joinCondList.append(cond)
        
        joinCond = ' and '.join(joinCondList)
        
        
        # original table or previous view
        fromTable = ''
        if parentNode.JoinResView is None and parentNode.relationType == RelationType.TableScanRelation:
            fromTable = parentNode.source + ' AS ' + parentNode.alias
        elif parentNode.JoinResView is not None:
            fromTable = parentNode.JoinResView.viewName
        else:
            fromTable = parentNode.alias
        
        if len(comp.path) == 1:   # Root of the comparison, need add mf_left < mf_right
            joinView = Join2tables(viewName, selectAttributes, selectAttributesAs, fromTable, minView.viewName, joinKey, alterJoinKey, joinCond, ''.join(whereCond))
        else:
            joinView = Join2tables(viewName, selectAttributes, selectAttributesAs, fromTable, minView.viewName, joinKey, alterJoinKey, joinCond)
        

    elif len(incidentComp) > 1:
        raise NotImplementedError("# Comparisons >= 2 case is not implemented yet! ")
    
    else: # Semijoin
        viewName = 'semiJoinView' + str(randint(0, maxsize))
        selectAttributes, selectAttributesAs = [], []
        fromTable = ''
        if parentNode.JoinResView is not None: # already has alias 
            selectAttributesAs = parentNode.JoinResView.selectAttrAlias
            fromTable = parentNode.JoinResView.viewName
        elif parentNode.relationType != RelationType.TableScanRelation: # create view node already
            selectAttributesAs = parentNode.cols
            fromTable = parentNode.alias
        else:
            selectAttributes = parentNode.col2vars[1]
            selectAttributesAs = parentNode.cols
            fromTable = parentNode.source + ' AS ' + parentNode.alias
            
        joinTable = ''
        if childNode.JoinResView is not None: # already has alias 
            joinTable = childNode.JoinResView.viewName
        elif childNode.relationType != RelationType.TableScanRelation: # create view node already
            joinTable = childNode.alias
        else:
            joinTable = childNode.source + ' AS ' + childNode.alias
        
        joinKey = list(set(childNode.cols) & set(parentNode.cols))
        # joinCondition setting
        # original variable name
        inLeft, inRight = [], []
        parentFlag = parentNode.JoinResView is None and parentNode.relationType == RelationType.TableScanRelation
        childFlag = childNode.JoinResView is None and childNode.relationType == RelationType.TableScanRelation
        for eachKey in joinKey:
            # Flag: need alias casting, add to condList
            # alias/JoinViewName.original else alias/JoinViewName.eachKey
            originalNameP = parentNode.col2vars[1][parentNode.col2vars[0].index(eachKey)]
            originalNameC = childNode.col2vars[1][childNode.col2vars[0].index(eachKey)]
            if parentFlag and childFlag:        
                # both alias/JoinViewName.original
                inLeft.append(originalNameP) 
                inRight.append(originalNameC)
            elif not parentFlag and childFlag:  
                # parent alias/JoinViewName.eachKey; child alias/JoinViewName.original
                inLeft.append(eachKey)
                inRight.append(originalNameC)
            elif parentFlag and not childFlag:  
                # parent alias/JoinViewName.original; child alias/JoinViewName.eachKey
                inLeft.append(originalNameP)
                inRight.append(eachKey)
            else :
                inLeft.append(eachKey)
                inRight.append(eachKey)
        
        semiView = SemiJoin(viewName, selectAttributes, selectAttributesAs, fromTable, joinTable, inLeft, inRight)
        retReducePhase = ReducePhase(prepareView, None, None, None, semiView, childNode.id, direction, type, '', [], [], reduceRel)
        return retReducePhase
    # End
    remainPathComp = copy.deepcopy(incidentComp)
    
    retReducePhase = ReducePhase(prepareView, orderView, minView, joinView, semiView, childNode.id, direction, type, comp.op, remainPathComp, incidentComp, reduceRel)
    return retReducePhase


def buildEnumeratePhase(previousView: Action, corReducePhase: ReducePhase, JT: JoinTree) -> EnumeratePhase:
    createSample = selectMax = selectTarget = stageEnd = semiEnumerate = None
    if (corReducePhase.reduceDirection == Direction.SemiJoin):
        viewName = 'semiEnum' + str(randint(0, maxsize))
        origiNode = JT.getNode(corReducePhase.corresNodeId)
        selectAttr, selectAttrAlias = [], []
        joinKey, joinCondList = [], []
        
        joinCond = ''
        
        if origiNode.JoinResView is None and origiNode.relationType == RelationType.TableScanRelation:
            # need alias casting for origiNode 
            joinTable = origiNode.source + ' as ' + origiNode.alias
            selectAttrAlias = list(set(origiNode.cols) | set(previousView.selectAttrAlias))
            for alias in selectAttrAlias:
                if alias in previousView.selectAttrAlias:
                    selectAttr.append('')
                else:
                    selectAttr.append(origiNode.col2vars[1][origiNode.cols.index(alias)])
                    
            joinKey = list(set(origiNode.cols) & set(previousView.selectAttrAlias))
            
        elif origiNode.JoinResView is not None:
            joinTable = origiNode.JoinResView.viewName
            selectAttrAlias = list(set(origiNode.JoinResView.selectAttrAlias) | set(previousView.selectAttrAlias))
            joinKey = list(set(origiNode.JoinResView.selectAttrAlias) & set(previousView.selectAttrAlias))
            
        else:
            joinTable = origiNode.alias
            selectAttrAlias = list(set(origiNode.cols) | set(previousView.selectAttrAlias))
            joinKey = list(set(origiNode.cols) & set(previousView.selectAttrAlias))
        
        for eachKey in joinKey:
            cond = ''
            # not root, cast to alias already in the first one side
            if origiNode.JoinResView is None and origiNode.relationType == RelationType.TableScanRelation: 
                # use original
                originalName = origiNode.col2vars[1][origiNode.col2vars[0].index(eachKey)]
                cond = origiNode.alias + '.' + originalName + '=' + previousView.viewName + '.' + eachKey
                joinKey.remove(eachKey) # remove it from using syntax
                
                joinCondList.append(cond)
        
        joinCond = ' and '.join(joinCondList)
            
        fromTable = previousView.viewName
        
        semiEnumerate = SemiEnumerate(viewName, selectAttr, selectAttrAlias, fromTable, joinTable, joinKey, joinCond)
        retEnum = EnumeratePhase(createSample, selectMax, selectTarget, stageEnd, semiEnumerate, corReducePhase.corresNodeId, corReducePhase.reduceDirection, corReducePhase.PhaseType)
        return retEnum
        
    # Not semi enumerate
    # 1. createSample
    viewName = 'sample' + str(randint(0, maxsize))
    createSample = CreateSample(viewName, [], ['*'], corReducePhase.orderView.viewName)
    # 2. selectMax
    viewName = 'maxRn' + str(randint(0, maxsize))
    selectAttrAlias = joinKey = groupCond = corReducePhase.joinView.joinKey
    fromTable = previousView.viewName
    joinTable = createSample.viewName
    
    # previous view is not semi view, must have have where: 
    # 1. last joinview of reduce 2. previous enumerate stageEnd
    
    # TODO: Here only find the first comparison
    corComp = corReducePhase.remainPathComp[0]
    l, r = corComp.getBeginNodeId, corComp.getEndNodeId
    totalLen = len(corComp.originPath)
    leftMf, rightMf = '', ''
    lFlag, rFlag= 1, 1          # sign for still set up MF value
    for i in range(totalLen):
        if lFlag == 1 and (corComp.originPath[i][0] == l or corComp.originPath[i][1] == l):
            lFlag = 0
            inIdx = 0 if corComp.originPath[i][0] == l else 1
            leftMf = corReducePhase.incidentComp[0].helperAttr[i][inIdx] if not 'mfR' in corReducePhase.incidentComp[0].helperAttr[i][inIdx] else corReducePhase.incidentComp[0].left
            
        if rFlag == 1 and (corComp.originPath[totalLen-i-1][0] == r or corComp.originPath[totalLen-i-1][1] == r):
            rFlag = 0
            inIdx = 0 if corComp.originPath[totalLen-i-1][0] == r else 1
            rightMf = corReducePhase.incidentComp[0].helperAttr[totalLen-i-1][inIdx] if not 'mfL' in corReducePhase.incidentComp[0].helperAttr[totalLen-i-1][inIdx] else corReducePhase.incidentComp[0].right
            
        if not lFlag and not rFlag:
            break
    
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

    retEnum = EnumeratePhase(createSample, selectMax, selectTarget, stageEnd, semiEnumerate, corReducePhase.corresNodeId, corReducePhase.reduceDirection, corReducePhase.PhaseType)
    return retEnum

def generateIR(JT: JoinTree, COMP: dict[int, Comparison]) -> [list[ReducePhase], list[EnumeratePhase]]:
    jointree = copy.deepcopy(JT)
    remainRelations = jointree.getRelations().values()
    comparisons = list(COMP.values())        
    reduceList: list[ReducePhase] = []
    enumerateList: list[EnumeratePhase] = []
    
    def getLeafRelation(relations: list[Edge]) -> list[Edge]:
        # TODO: Change needs for Complex comparison's two sides
        leafRelation = [rel for rel in relations if rel.dst.isLeaf and not rel.dst.isRoot]
        return leafRelation
    
    def getSupportRelation(relations: list[Edge]) -> list[Edge]:
        supportRelation = [rel for rel in relations if rel.src.relationType == RelationType.AuxiliaryRelation and rel.dst.id == rel.src.supRelationId]
        return supportRelation
        
    '''Get incident comparisons'''
    def getCompRelation(relation: Edge) -> list[Comparison]:
        corresComp = [comp for comp in comparisons if relation.dst.id == comp.beginNodeId or relation.dst.id == comp.endNodeId]
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
    
    
    '''Step1: Reduce'''
    while len(remainRelations) > 1:
        leafRelation = getLeafRelation(remainRelations)
        supportRelation = getSupportRelation(leafRelation)
        if len(supportRelation) == 0:
            rel = choice(leafRelation)
        else:
            rel = choice(supportRelation)
        # print(rel)
        incidentComp = getCompRelation(rel)
        updateDirection = []
        retReduce = None
        if len(incidentComp) <= 2:
            if len(incidentComp) == 0:  # semijoin only
                retReduce = buildReducePhase(rel, JT, incidentComp, Direction.SemiJoin)
            elif len(incidentComp) == 1:
                onlyComp = incidentComp[0]
                if (onlyComp.getPredType == predType.Long or onlyComp.getPredType == predType.Short):
                    supportRelationFlag = True if rel.src.relationType == RelationType.AuxiliaryRelation and rel.dst.id == rel.src.supRelationId else False
                    if rel.dst.id == onlyComp.getBeginNodeId:
                        pathIdx = onlyComp.originPath.index([rel.dst.id, rel.src.id])
                        helperLeftFrom = onlyComp.helperAttr[pathIdx-1][1] if rel.dst.id != onlyComp.originBeginNodeId else onlyComp.left
                        helperLeftTo = 'mfL' + str(randint(0, maxsize)) if not supportRelationFlag else helperLeftFrom
                        # use orioginal short comparison
                        if onlyComp.getPredType == predType.Short:
                            if len(onlyComp.originPath) > 1 and pathIdx + 1 < len(onlyComp.originPath):
                                helperRightFrom = onlyComp.helperAttr[pathIdx+1][0]
                            else:
                                helperRightFrom = onlyComp.right
                        else:
                            helperRightFrom = ''
                        onlyComp.helperAttr[pathIdx] = [helperLeftFrom, helperLeftTo]
                        retReduce = buildReducePhase(rel, JT, incidentComp, Direction.Left, [helperLeftFrom, helperLeftTo], [helperRightFrom, helperRightFrom])
                        updateDirection.append(Direction.Left)
                    elif rel.dst.id == onlyComp.getEndNodeId:
                        pathIdx = onlyComp.originPath.index([rel.src.id, rel.dst.id])
                        # use orioginal short comparison
                        if onlyComp.getPredType == predType.Short:
                            if len(onlyComp.originPath) > 1 and pathIdx - 1 >= 0:
                                helperLeftFrom = onlyComp.helperAttr[pathIdx-1][1]
                            else:
                                helperLeftFrom = onlyComp.left
                        else :
                            helperLeftFrom = ''
                        helperRightFrom = onlyComp.helperAttr[pathIdx+1][0] if rel.dst.id != onlyComp.originEndNodeId else onlyComp.right
                        helperRightTo = 'mfR' + str(randint(0, maxsize)) if not supportRelationFlag else helperRightFrom
                        onlyComp.helperAttr[pathIdx] = [helperRightTo, helperRightFrom]
                        retReduce = buildReducePhase(rel, JT, incidentComp, Direction.Right, [helperLeftFrom, helperLeftFrom], [helperRightFrom, helperRightTo])
                        updateDirection.append(Direction.Right)
                    else:
                        raise RuntimeError("Should not happen! ")
                else:
                    raise NotImplementedError("Error type! ")
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
        if retReduce.joinView:
            JT.getNode(rel.src.id).JoinResView = retReduce.joinView
        else:
            JT.getNode(rel.src.id).JoinResView = retReduce.semiView
            
    # remianRelations == 1
    rel = list(remainRelations)[0]
    # print(rel)
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
                    # original short comparison
                    # TODO: shoule be both left, but index error, change to path?
                    if len(onlyComp.originPath) > 1 and pathIdx + 1 < len(onlyComp.originPath):
                        helperRightFrom = onlyComp.helperAttr[pathIdx+1][0]
                    else:
                        helperRightFrom = onlyComp.right

                    onlyComp.helperAttr[pathIdx] = [helperLeftFrom, helperLeftTo] # update
                    retReduce = buildReducePhase(rel, JT, incidentComp, Direction.Left, [helperLeftFrom, helperLeftTo], [helperRightFrom, helperRightFrom])
                elif rel.dst.id == onlyComp.getEndNodeId: # root <- dst
                    pathIdx = onlyComp.originPath.index([rel.src.id, rel.dst.id])
                    # original short comparison
                    if len(onlyComp.originPath) > 1 and pathIdx - 1 >= 0:
                        helperLeftFrom = onlyComp.helperAttr[pathIdx-1][1]
                    else:
                        helperLeftFrom = onlyComp.left
                    
                    helperRightFrom = onlyComp.helperAttr[pathIdx+1][0] if rel.dst.id != onlyComp.originEndNodeId else onlyComp.right
                    helperRightTo = 'mfR' + str(randint(0, maxsize))
                    onlyComp.helperAttr[pathIdx] = [helperRightTo, helperRightFrom] # update
                    retReduce = buildReducePhase(rel, JT, incidentComp, Direction.Right, [helperLeftFrom, helperLeftFrom], [helperRightFrom, helperRightTo])
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
    if retReduce.joinView:
        JT.getNode(rel.src.id).JoinResView = retReduce.joinView
    else:
        JT.getNode(rel.src.id).JoinResView = retReduce.semiView

    '''Step2: Enumerate'''
    # only root node
    if len(JT.subset) == 1:
        return reduceList, []
    
    enumerateOrder = [enum for enum in reduceList if JT.getNode(enum.corresNodeId) in JT.subset] if not JT.isFull else reduceList.copy()
    enumerateOrder.reverse()
    for enum in enumerateOrder:
        beginPrevious = enumerateOrder[0].joinView if enumerateOrder[0].joinView else enumerateOrder[0].semiView
        if enumerateList == []: 
            previousView = beginPrevious 
        else:
            previousView = enumerateList[-1].stageEnd if enumerateList[-1].stageEnd else enumerateList[-1].semiEnumerate
        # print(enum.corresNodeId)
        retEnum = buildEnumeratePhase(previousView, enum, JT)
        enumerateList.append(retEnum)
        
    return reduceList, enumerateList
    
