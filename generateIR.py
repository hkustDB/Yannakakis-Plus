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

'''
Optimize column selection settings: 
Maintain the key set for all joinkey, used for non-full output attribute optimize
'''
allJoinKeySet = set()
compKeySet = set()
outVars = []

def buildJoinRelation(preNode: TreeNode, inNode: TreeNode) -> str:
    whereCondList = []
    joinKey = list(set(inNode.cols) & set(preNode.cols))
    # natural join
    if not len(joinKey):
        return []
        
    if preNode.relationType == RelationType.TableScanRelation and inNode.relationType == RelationType.TableScanRelation:
        joinKey1 = [preNode.col2vars[1][preNode.col2vars[0].index(key)] for key in joinKey]
        joinKey2 = [inNode.col2vars[1][inNode.col2vars[0].index(key)] for key in joinKey]
        # not using alias for var any more
        for i in range(len(joinKey1)):
            whereCond = preNode.alias + '.' + joinKey1[i] + '=' + inNode.alias + '.' + joinKey2[i]
            whereCondList.append(whereCond)
    elif preNode.relationType == RelationType.TableScanRelation:
        joinKey1 = [preNode.col2vars[1][preNode.col2vars[0].index(key)] for key in joinKey]
        for i in range(len(joinKey1)):
            whereCond = preNode.alias + '.' + joinKey1[i] + '=' + inNode.alias + '.' + joinKey[i]
            whereCondList.append(whereCond)
    elif inNode.relationType == RelationType.TableScanRelation:
        joinKey2 = [inNode.col2vars[1][inNode.col2vars[0].index(key)] for key in joinKey]
        # not using alias for var any more
        for i in range(len(joinKey2)):
            whereCond = preNode.alias + '.' + joinKey[i] + '=' + inNode.alias + '.' + joinKey2[i]
            whereCondList.append(whereCond)
    else:
        for i in range(len(joinKey)):
            whereCond = preNode.alias + '.' + joinKey[i] + '=' + inNode.alias + '.' + joinKey[i]
            whereCondList.append(whereCond)

    return whereCondList

# prepareView is ahead of joinView
def buildPrepareView(JT: JoinTree, childNode: TreeNode, childSelfComp: list[Comparison] = [], extraNode: TreeNode = None, direction: Direction = Direction.Left, extraSelfComp: list[Comparison] = [], helperLeft: list[str, str] = ['', ''], helperRight: list[str, str] = ['', '']):
    if childNode.createViewAlready: return [] # only means creave view about bag/tableagg/aux relation, not use for other join
    prepareView = []
    joinTableList, whereCondList = [], []
    
    def splitLR(LR: str):
        if '*' in LR: return LR.split('*'), '*'
        elif '+' in LR: return LR.split('+'), '+'
        else: return [LR], ''
    
    if childNode.relationType == RelationType.BagRelation:
        for index, id in enumerate(childNode.insideId):
            inNode = JT.getNode(id)
            if inNode.relationType == RelationType.TableScanRelation: # still need source alias
                joinTableList.append(inNode.source + ' as ' + inNode.alias) 
            else :
                # FIXME: Should not be aux node
                prepareView.extend(buildPrepareView(JT, inNode))
                joinTableList.append(inNode.alias)
            # NOTE: Assume internal nodes arrange by circle sequence
            if index > 0:
                # TODO: FIX alias
                preNode = JT.getNode(childNode.insideId[index-1])
                subWhereCondList = buildJoinRelation(preNode, inNode)
                whereCondList.extend(subWhereCondList)
        
        def trans2Alias(vars: list[str], nodes: list[TreeNode]) -> list[str]:
            updateVars = vars.copy()
            for index1, node in enumerate(nodes):
                for index2, var in enumerate(vars):
                    if len(updateVars) == 0:
                        return
                    if var in updateVars and var in node.cols: 
                        vars[index2] = node.alias + '.' + node.col2vars[1][index1]
                        updateVars.remove(var)

        # Add self comparison
        if len(childSelfComp) != 0:
            for comp in childSelfComp:
                leftVar, opL = splitLR(comp.left)
                rightVar, opR = splitLR(comp.right)
                nodes = [JT.getNode(id) for id in childNode.insideId]
                
                trans2Alias(leftVar, nodes)
                trans2Alias(rightVar, nodes)
                
                whereCondList.append(opL.join(leftVar) + comp.op + opR.join(rightVar))
        
        if len(childNode.insideId) > 2:
            whereCondList.extend(buildJoinRelation(JT.getNode(id), JT.getNode(childNode.insideId[0])))
        
        prepareView.append(CreateBagView(childNode.alias, childNode.col2vars[1], childNode.cols, '', joinTableList, whereCondList))
    
    # Here child means parent
    elif childNode.relationType == RelationType.AuxiliaryRelation:
    # NOTE: aux support can not be source, so the source is correct name
        # viewName = extraNode.source if extraNode.JoinResView is None else extraNode.JoinResView.viewName # leaf or join result
        mfAttr = helperLeft if direction == Direction.Left else helperRight
        if mfAttr[1] != '' and mfAttr[1] not in childNode.cols:
            if extraNode.relationType != RelationType.TableScanRelation: # can use alias directly
                selectAttributes = childNode.col2vars[1] + ['']
                selectAttributesAs = childNode.cols + [mfAttr[1]]
            else :
                idx = extraNode.cols.index(mfAttr[1])
                selectAttributes = childNode.col2vars[1] + [extraNode.col2vars[1][idx]]
                selectAttributesAs = childNode.cols + [mfAttr[1]]
        else:
            selectAttributes = childNode.col2vars[1]
            selectAttributesAs = childNode.cols
        
        # source name directly (abandon alias) or previous join result name
        if extraNode.JoinResView is not None:
            fromTable = extraNode.JoinResView.viewName 
            prepareView.append(CreateAuxView(childNode.alias, [], selectAttributesAs, fromTable))
        elif extraNode.relationType != RelationType.TableScanRelation:
            fromTable = extraNode.alias
            prepareView.append(CreateAuxView(childNode.alias, [], selectAttributesAs, fromTable))
        else:
            whereCondList = []
            if extraNode.isLeaf and len(extraSelfComp): # support relation (child) need self comparison
                whereCondList = makeSelfComp(extraSelfComp, extraNode)
            fromTable = extraNode.source
            prepareView.append(CreateAuxView(childNode.alias, selectAttributes, selectAttributesAs, fromTable, whereCondList))
        # childNode.createViewAlready = True
    
    elif childNode.relationType == RelationType.TableAggRelation: 
        aggNodes = childNode.aggRelation
        fromTable = childNode.source # + ' as ' + childNode.alias if childNode.alias != childNode.source else childNode.source
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
            
        # Add self comparison
        if len(childSelfComp) != 0:
            for comp in childSelfComp:
                leftVar, opL = splitLR(comp.left)
                rightVar, opR = splitLR(comp.right)
                
                for i in range(len(leftVar)):
                    index = childNode.cols.index(leftVar[i])
                    leftVar[i] = originalVars[index] if originalVars[index] != '' else leftVar[i]
                    
                for i in range(len(rightVar)):
                    index = childNode.cols.index(rightVar[i])
                    rightVar[i] = originalVars[index] if len(originalVars) and originalVars[index] != '' else rightVar[i]
                
                whereCondList.append(opL.join(leftVar) + comp.op + opR.join(rightVar))

        prepareView.append(CreateTableAggView(childNode.alias, originalVars, childNode.cols, fromTable, joinTableList, whereCondList))
    
    childNode.createViewAlready = True # only apply for tableAgg & bag relation
    return prepareView


# (A) Common Function for Reduce & Enumerate
def splitLR(LR: str):
    if '*' in LR: return LR.split('*'), '*'
    elif '+' in LR: return LR.split('+'), '+'
    else: return [LR], ''
        
# -1 change corres selectAttrs (actually no need to change, must be tablescan)
def transSelfComp(originalVars: list[str], comp: Comparison, childNode: TreeNode):
    if len(originalVars) == 0: return comp.left, comp.right
            
    leftVar, opL = splitLR(comp.left)
    rightVar, opR = splitLR(comp.right)
        
    for i in range(len(leftVar)):
        # NOTE: continue for constant
        if not 'v' in leftVar[i]: continue
        index = childNode.cols.index(leftVar[i])
        # leftVar[i] = (childNode.alias if tableAlias else '') + (originalVars[index] if len(originalVars) and originalVars[index] != '' else leftVar[i])
        leftVar[i] = originalVars[index] if len(originalVars) and originalVars[index] != '' else leftVar[i]        
        
    for i in range(len(rightVar)):
        # NOTE: continue for constant
        if not 'v' in rightVar[i]: continue
        index = childNode.cols.index(rightVar[i])
        # rightVar[i] = (childNode.alias if tableAlias else '') + (originalVars[index] if len(originalVars) and originalVars[index] != '' else rightVar[i])
        rightVar[i] = originalVars[index] if len(originalVars) and originalVars[index] != '' else rightVar[i]
                
    return opL.join(leftVar), opR.join(rightVar)


#  -2 TableScan childnode, use children attrs
def makeSelfComp(selfComparisons: list[Comparison], childNode: TreeNode) -> list[str]:
    whereCondList = []
    
    for comp in selfComparisons:
        left, right = transSelfComp(childNode.col2vars[1], comp, childNode)
        whereCondList.append(left + comp.op + right)
        
    return whereCondList

'''
Used for build reducePhase for bag with auxiliary inside: auxNode->childNode
'''
def buildBagAuxReducePhase(reduceRel: Edge, JT: JoinTree, incidentComp: list[Comparison], selfComp: list[Comparison], direction: Direction, auxNode: AuxTreeNode, helperLeft: list[str, str] = ['', ''], helperRight: list[str, str] = ['', '']) -> ReducePhase:
    childNode = JT.getNode(reduceRel.dst.id)
    parentNode = auxNode
    prepareView = []
    orderView = minView = joinView = semiView = bagAuxView = None
    
    childSelfComp = [comp for comp in selfComp if childNode.id == comp.path[0][0]]
    # Used for final create bag view
    childFlag = childNode.JoinResView is None and childNode.relationType == RelationType.TableScanRelation
    childSelfFlag = childNode.isLeaf and len(childSelfComp) and childNode.relationType == RelationType.TableScanRelation
    type = PhaseType.SemiJoin if direction == Direction.SemiJoin else PhaseType.CQC
    
    # 1. prepareView(Aux, Agg, Bag create view using child alias)
    if childNode.isLeaf:
        ret = buildPrepareView(JT, childNode, childSelfComp)
        if ret != []: prepareView.extend(ret)
    
    # 3. bagAuxView
    ## (1) select attributes
    mfAttr = helperLeft if direction == Direction.Left else helperRight
    
    # parent node must not have JoinView: aux -> sup only
    selectAttributes = []
    selectAttributesAs = (parentNode.cols + [mfAttr[1]]) if (mfAttr[1] != '' and mfAttr[1] not in parentNode.cols) else parentNode.cols
    
    if childFlag:
        for alias in selectAttributesAs:
            if 'mf' not in alias:
                idx = childNode.cols.index(alias)
                oriName = childNode.col2vars[1][idx]
                selectAttributes.append(oriName)
            else:
                selectAttributes.append('')
    
    ## (2) fromTable
    if childNode.JoinResView is not None:
        fromTable = childNode.JoinResView.viewName 
        prepareView.append(CreateAuxView(parentNode.alias, [], selectAttributesAs, fromTable))
    elif childNode.relationType != RelationType.TableScanRelation:
        fromTable = childNode.alias
        prepareView.append(CreateAuxView(parentNode.alias, [], selectAttributesAs, fromTable))
    else:
        whereCondList = []
        if childSelfFlag : # support relation (child) need self comparison
            whereCondList = makeSelfComp(childSelfComp, childNode)
        fromTable = childNode.source
        prepareView.append(CreateAuxView(parentNode.alias, selectAttributes, selectAttributesAs, fromTable, whereCondList))
    parentNode.JoinResView = prepareView[-1]
    parentNode.createViewAlready = True

    ## (4) bagView 
    auxCreateFlag = True    # mark for all auxNode creation
    bagNode = JT.getNode(reduceRel.src.id)
    
    for inId in bagNode.insideId:
        inNode = JT.getNode(inId)
        if inNode.relationType == RelationType.AuxiliaryRelation and not inNode.createViewAlready:
            auxCreateFlag = False
            break
    
    if auxCreateFlag:
        selectAttributesAs = []
        joinKeyList = []
        joinTableList = []
        for inId in bagNode.insideId:
            inNode = JT.getNode(inId)
            if inNode.relationType != RelationType.AuxiliaryRelation and inNode.relationType != RelationType.TableScanRelation:
                prepareView.extend(buildPrepareView(JT, inNode))
            joinKey = []
            # Add join table
            if inNode.relationType != RelationType.TableScanRelation:
                joinTableList.append(inNode.alias)
                inSelectAlias = inNode.JoinResView.selectAttrAlias
                for alias in inSelectAlias:
                    if alias in selectAttributesAs:
                        joinKey.append(alias)
                    else:
                        selectAttributesAs.append(alias)
                if len(joinKey):
                    joinKeyList.append(joinKey)
            else:
                raise NotImplementedError("TableScan Relation in bagAuxNode! ")
            
        ## bagSelfComp
        bagSelfComp = [comp for comp in selfComp if bagNode.id == comp.path[0][0]]
        bagSelfComp = [comp.left + comp.op + comp.right for comp in bagSelfComp]
        
        ## mfCond
        if len(incidentComp) and len(incidentComp[0].path) == 1:
            mfCond = [helperLeft[1], incidentComp[0].op, helperRight[1]]
            bagSelfComp.append(''.join(mfCond))
        
        bagAuxView = CreateBagAuxView(bagNode.alias, [], selectAttributesAs, '', joinTableList, joinKeyList, bagSelfComp)
        bagNode.createViewAlready = True
        
    else:
        # Should pass bag view name & attributes as joinTableView anyway -> no need, it will not be enumerated
        pass

    if len(incidentComp):
        ## not semi
        remainPathComp = copy.deepcopy(incidentComp)
        return ReducePhase(prepareView, orderView, minView, joinView, semiView, bagAuxView, childNode.id, direction, type, incidentComp[0].op, remainPathComp, incidentComp, reduceRel)
    else:
        return ReducePhase(prepareView, orderView, minView, joinView, semiView, bagAuxView, childNode.id, direction, type, '', [], [], reduceRel)

'''For last relation, parent should also add selfComparison to joinView
helperAttrLeft/Right: helper attribute name change[from, to]
incidentComp: [first] long, [second...] short
'''
def buildReducePhase(reduceRel: Edge, JT: JoinTree, incidentComp: list[Comparison], selfComp: list[Comparison], direction: Direction, helperLeft: list[str, str] = ['', ''], helperRight: list[str, str] = ['', ''], lastRel: bool = False) -> ReducePhase:
    childNode = JT.getNode(reduceRel.dst.id)
    parentNode = JT.getNode(reduceRel.src.id)
    prepareView = []
    orderView = minView = joinView = semiView = bagAuxView = None
    
    childSelfComp = [comp for comp in selfComp if childNode.id == comp.path[0][0]]
    parentSelfComp = [comp for comp in selfComp if parentNode.id == comp.path[0][0]]
    parentFlag = parentNode.JoinResView is None and parentNode.relationType == RelationType.TableScanRelation
    childFlag = childNode.JoinResView is None and childNode.relationType == RelationType.TableScanRelation
    childSelfFlag = childNode.isLeaf and len(childSelfComp) and childNode.relationType == RelationType.TableScanRelation
    type = PhaseType.SemiJoin if direction == Direction.SemiJoin else PhaseType.CQC
        
    # 0. BAG ONLY: JV=None->no bagAuxView created->still aux node not processed in it
    if parentNode.relationType == RelationType.BagRelation and parentNode.JoinResView is None:
        auxFlag = False
        for id in parentNode.insideId:
            inNode = JT.getNode(id)
            if inNode.relationType == RelationType.AuxiliaryRelation and childNode.id == inNode.supRelationId:
                return buildBagAuxReducePhase(reduceRel, JT, incidentComp, selfComp, direction, inNode, helperLeft, helperRight)
            # elif inNode.relationType != RelationType.AuxiliaryRelation:
                # raise NotImplementedError("inNode type in not auxiliary! ")

    '''BEGIN: Normal case'''
    # 1. prepareView(Aux, Agg, Bag create view using child alias)
    if childNode.isLeaf and childNode.relationType != RelationType.TableScanRelation:
        ret = buildPrepareView(JT, childNode, childSelfComp)
        if ret != []: prepareView.extend(ret)
    # build aux for parent node is different
    if parentNode.relationType != RelationType.TableScanRelation:
        if parentNode.relationType == RelationType.AuxiliaryRelation:
            ret = buildPrepareView(JT, parentNode, parentSelfComp, extraNode=childNode, direction=direction, extraSelfComp=childSelfComp, helperLeft=helperLeft, helperRight=helperRight)
        else:
            ret = buildPrepareView(JT, parentNode, parentSelfComp)
        if ret != []: prepareView.extend(ret)

    # (B) with comparison (1 / >= 2 should all be done, just select the first comparison, others should be done during enumeration)
    if direction != Direction.SemiJoin:
        comp = incidentComp[0]
        
        # 2. Aux Node: Support Relation for auxiliary relation case, all aux relations will be create here; this is only for aux -> ndoe not used for bag(aux) -> 
        if parentNode.relationType == RelationType.AuxiliaryRelation and childNode.id == parentNode.supRelationId:
            mfAttr = helperLeft if direction == Direction.Left else helperRight
            if mfAttr[1] != '' and mfAttr[1] not in parentNode.cols:
                if parentNode.relationType != RelationType.TableScanRelation: # can use alias directly
                    selectAttributes = parentNode.col2vars[1] + ['']
                    selectAttributesAs = parentNode.cols + [mfAttr[1]]
                else :
                    idx = parentNode.cols.index(mfAttr[1])
                    selectAttributes = parentNode.col2vars[1] + [parentNode.col2vars[1][idx]]
                    selectAttributesAs = parentNode.cols + [mfAttr[1]]
            else:
                selectAttributes = parentNode.col2vars[1]
                selectAttributesAs = parentNode.cols
                
            selectAttributes = []
            selectAttributesAs = (parentNode.cols + [mfAttr[1]]) if (mfAttr[1] != '' and mfAttr[1] not in parentNode.cols) else parentNode.cols
            
            if childFlag:
                for alias in selectAttributesAs:
                    if 'mf' not in alias:
                        idx = childNode.cols.index(alias)
                        oriName = childNode.col2vars[1][idx]
                        selectAttributes.append(oriName)
                    else:
                        selectAttributes.append('')
            
            # TODO: Change to semi is more proper, change viewname
            joinView = Join2tables(prepareView[-1].viewName, selectAttributes, selectAttributesAs, '', '', [], '', '')     # pass comparison attributes
            remainPathComp = copy.deepcopy(incidentComp)
            return ReducePhase(prepareView, orderView, minView, joinView, semiView, bagAuxView, childNode.id, direction, type, comp.op, remainPathComp, incidentComp, reduceRel)
        # END
        
    # 2. orderView
        viewName = 'orderView' + str(randint(0, maxsize))
        noAliasFlag = False
        if childNode.JoinResView is not None:
            fromTable = childNode.JoinResView.viewName
            noAliasFlag = True
        elif childNode.relationType == RelationType.TableScanRelation:
            fromTable = childNode.source + ' as ' + childNode.alias if childNode.alias != childNode.source else childNode.source
        else:
            fromTable = childNode.alias
        
        if noAliasFlag:
            joinKey = list(set(childNode.JoinResView.selectAttrAlias) & set(parentNode.cols))
        else:
            joinKey = list(set(childNode.cols) & set(parentNode.cols))
        
        # maintain allJoinKey set
        allJoinKeySet.update(joinKey)
        
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
        # handle complex function like v1 * v2 * v3...
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
                    try:    
                        idx = childNode.cols.index(var)
                        transVar = childNode.alias + '.' + childNode.col2vars[1][idx]
                    except:
                        # not in the list, should be  the constant
                        transVar = var
                        
                    transVarList.append(transVar)
                
                extraAttr = op.join(transVarList)
            extraAlias = 'ori' + ('Left' if (direction == Direction.Left) else 'Right')
            helperLeft[0] = extraAlias if 'Left' in extraAlias else helperLeft[0]
            helperRight[0] = extraAlias if 'Right' in extraAlias else helperRight[0]
        
        # process orderKey alias in TableScan case, need alias casting
        if not noAliasFlag and 'mf' not in orderKey[-1] and childNode.relationType == RelationType.TableScanRelation:
            if orderKey[-1] in childNode.cols:
                idx = childNode.cols.index(orderKey[-1])
                orderKey[-1] = childNode.col2vars[1][idx]
            else:
                orderKey[-1] = extraAttr
        
        # process partitionByKey alias in TableScan case, need alias casting
        if not noAliasFlag and childNode.relationType == RelationType.TableScanRelation:
            for i in range(len(partiKey)): # multi joinKey
                idx = childNode.cols.index(partiKey[i])
                partiKey[i] = childNode.col2vars[1][idx]
        
        if noAliasFlag: # have JoinView, must not be leaf
            if extraAlias == '':
                orderView = CreateOrderView(viewName, [], childNode.JoinResView.selectAttrAlias, fromTable, partiKey, orderKey, AESC)
            else:
                orderView = CreateOrderView(viewName, ['' for i in range(len(childNode.JoinResView.selectAttrAlias))] + [extraAttr], childNode.JoinResView.selectAttrAlias + [extraAlias], fromTable, partiKey, orderKey, AESC)
        elif childNode.relationType == RelationType.TableScanRelation: 
            # # Add child node selfComp
            if  extraAlias == '':
                if childNode.isLeaf and len(childSelfComp):
                    transSelfCompList = makeSelfComp(childSelfComp, childNode)
                    
                    orderView = CreateOrderView(viewName, childNode.col2vars[1], childNode.cols, fromTable, partiKey, orderKey, AESC, transSelfCompList)
                else:
                    orderView = CreateOrderView(viewName, childNode.col2vars[1], childNode.cols, fromTable, partiKey, orderKey, AESC)
            else:
                if childNode.isLeaf and len(childSelfComp):
                    transSelfCompList = makeSelfComp(childSelfComp, childNode)
                    
                    orderView = CreateOrderView(viewName, childNode.col2vars[1] + [extraAttr], childNode.cols + [extraAlias], fromTable, partiKey, orderKey, AESC, transSelfCompList)
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
        
        def joinSplit(splitVars: list[str], op: str):
            return op.join(splitVars)
        
        # handle extra mf comaprison alias
        whereCond = [helperLeft[1], comp.op, helperRight[1]]
        if len(comp.path) == 1:
            if direction == Direction.Left:     # change right
                if parentFlag:
                    splitVars, op = splitLR(whereCond[2])
                    for idx, item in enumerate(splitVars):
                        try:
                            index = parentNode.cols.index(item)
                            newName = parentNode.col2vars[1][index]
                            splitVars[idx] = newName
                        except:
                            continue
                    whereCond[2] = joinSplit(splitVars, op)
            elif direction == Direction.Right:  # change left
                if parentFlag:
                    splitVars, op = splitLR(whereCond[0])
                    for idx, item in enumerate(splitVars):
                        try:
                            # except for constant
                            index = parentNode.cols.index(item)
                            newName = parentNode.col2vars[1][index]
                            splitVars[idx] = newName
                        except:
                            continue
                    whereCond[0] = joinSplit(splitVars, op)
        
        joinCondList = []
        
        alterJoinKey = []
        # still need alias casting, new table join
        for eachKey in joinKey:
            cond = ''
            # not root, cast to alias already in the first one side
            if parentFlag: 
                # use original
                originalName = parentNode.col2vars[1][parentNode.col2vars[0].index(eachKey)]
                cond = parentNode.alias + '.' + originalName + '=' + minView.viewName + '.' + eachKey
                joinCondList.append(cond)
            else:
                alterJoinKey.append(eachKey)
        
        joinCond = ' and '.join(joinCondList)
        
        # original table or previous view
        fromTable = ''
        if parentFlag:
            fromTable = parentNode.source + ' AS ' + parentNode.alias
        elif parentNode.JoinResView is not None:
            fromTable = parentNode.JoinResView.viewName
        else:
            fromTable = parentNode.alias
        
        # Add parent node selfComp
        addiSelfComp = []
        if parentFlag and len(parentSelfComp):
            addiSelfComp = makeSelfComp(parentSelfComp, parentNode)
        # Root of the comparison, need add mf_left < mf_right
        if len(comp.path) == 1:   
            addiSelfComp.append(''.join(whereCond))
        
        # CHECK: Add optimize for selecting attrs
        if not JT.isFull and lastRel and len(JT.subset) == 1:
            optSelectAttributes, optSelectAttributesAs = [], []
            if len(selectAttributes):
                for index, alias in enumerate(selectAttributesAs):
                    if alias in outVars:
                        optSelectAttributes.append(selectAttributes[index])
                        optSelectAttributesAs.append(alias)
            else:
                for index, alias in enumerate(selectAttributesAs):
                    if alias in outVars:
                        optSelectAttributesAs.append(alias)
                
                joinView = Join2tables(viewName, optSelectAttributes, optSelectAttributesAs, fromTable, minView.viewName, joinKey, alterJoinKey, joinCond, addiSelfComp)
        else:
            joinView = Join2tables(viewName, selectAttributes, selectAttributesAs, fromTable, minView.viewName, joinKey, alterJoinKey, joinCond, addiSelfComp)
            
        
        # End
        remainPathComp = copy.deepcopy(incidentComp)
        if childFlag:
            retReducePhase = ReducePhase(prepareView, orderView, minView, joinView, semiView, bagAuxView, childNode.id, direction, type, comp.op, remainPathComp, incidentComp, reduceRel)
        else:
            retReducePhase = ReducePhase(prepareView, orderView, minView, joinView, semiView, bagAuxView, childNode.id, direction, type, comp.op, remainPathComp, incidentComp, reduceRel)
        return retReducePhase
    
    # (D) Semijoin
    else:
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
                
        # parent self-comparison
        outerWhereCondList = []
        if parentFlag and len(parentSelfComp):
            outerWhereCondList = makeSelfComp(parentSelfComp, parentNode)
        
        # CHECK: optimize for select cols
        if not JT.isFull and lastRel and len(JT.subset) == 1:
            optSelectAttributes, optSelectAttributesAs = [], []
            if len(selectAttributes):
                for index, alias in enumerate(selectAttributesAs):
                    if alias in outVars:
                        optSelectAttributes.append(selectAttributes[index])
                        optSelectAttributesAs.append(alias)
            else:
                for index, alias in enumerate(selectAttributesAs):
                    if alias in outVars:
                        optSelectAttributesAs.append(alias)
                        
            selectAttributes, selectAttributesAs = optSelectAttributes, optSelectAttributesAs         
        
        # children self comparison
        if childSelfFlag:
            whereCondList = makeSelfComp(childSelfComp, childNode)
            
            semiView = SemiJoin(viewName, selectAttributes, selectAttributesAs, fromTable, joinTable, inLeft, inRight, whereCondList, outerWhereCondList)
        else: # could use alias
            semiView = SemiJoin(viewName, selectAttributes, selectAttributesAs, fromTable, joinTable, inLeft, inRight, [], outerWhereCondList)
        
        retReducePhase = ReducePhase(prepareView, None, None, None, semiView, bagAuxView, childNode.id, direction, type, '', [], [], reduceRel)
        return retReducePhase


def buildEnumeratePhase(previousView: Action, corReducePhase: ReducePhase, JT: JoinTree, lastEnum: bool = False) -> EnumeratePhase:
    createSample = selectMax = selectTarget = stageEnd = semiEnumerate = None
        
    if (corReducePhase.reduceDirection == Direction.SemiJoin):
        '''
        Only semi need selfComp when enumerate, because cqc already use selfComp when build orderView
        '''
        origiNode = JT.getNode(corReducePhase.corresNodeId)
        origiFlag = origiNode.JoinResView is None and origiNode.relationType == RelationType.TableScanRelation
        origiSelfCompFlag = origiNode.isLeaf and len(corReducePhase.semiView.whereCondList) and origiNode.relationType == RelationType.TableScanRelation
        
        viewName = 'semiEnum' + str(randint(0, maxsize))
        selectAttr, selectAttrAlias = [], []
        joinKey, joinCondList = [], []
        
        joinCond = ''
        
        if origiFlag:
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
            if origiFlag: 
                # use original
                originalName = origiNode.col2vars[1][origiNode.col2vars[0].index(eachKey)]
                cond = origiNode.alias + '.' + originalName + '=' + previousView.viewName + '.' + eachKey
                joinKey.remove(eachKey) # remove it from using syntax
                
                joinCondList.append(cond)
        
        joinCond = ' and '.join(joinCondList)
            
        fromTable = previousView.viewName
        
        # CHECK: Optimize for enumerate selction cols
        if not JT.isFull:
            selectAttrAlias = [alias for alias in selectAttrAlias if 'mf' in alias or alias in allJoinKeySet or alias in outVars or alias in compKeySet]
        
        if origiSelfCompFlag:
            semiEnumerate = SemiEnumerate(viewName, selectAttr, selectAttrAlias, fromTable, joinTable, joinKey, joinCond, corReducePhase.semiView.whereCondList)
        else:
            semiEnumerate = SemiEnumerate(viewName, selectAttr, selectAttrAlias, fromTable, joinTable, joinKey, joinCond)
        retEnum = EnumeratePhase(createSample, selectMax, selectTarget, stageEnd, semiEnumerate, corReducePhase.corresNodeId, corReducePhase.reduceDirection, corReducePhase.PhaseType)
        return retEnum
    
    
# 1. createSample
    viewName = 'sample' + str(randint(0, maxsize))
    createSample = CreateSample(viewName, [], ['*'], corReducePhase.orderView.viewName)
# 2. selectMax
    viewName = 'maxRn' + str(randint(0, maxsize))
    # NOTE: For auxiliary relation, it will never be enumerated to its support relation
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
    viewName = 'end' + str(randint(0, maxsize))
    selectAttrAlias = set(previousView.selectAttrAlias) | set(selectTarget.selectAttrAlias) # alias union + mf value
    selectAttrAlias = [alias for alias in selectAttrAlias if 'mf' not in alias and (alias in allJoinKeySet or alias in outVars or alias in compKeySet)]             # remove all old mf first
    
    # CHECK: optimize -> last enum, no need to select mf attributes
    if not lastEnum:
        if 'mf' in leftMf and 'mf' in rightMf:
            mfAdd = ([leftMf] if leftMf != '' and 'mf' in leftMf else []) + ([rightMf] if rightMf != '' and 'mf' in rightMf else [])
            # NOTE: Which side mf to delete is about the next reduciable relation's direction: left -> keep mfR; right -> keep mfL
            selectAttrAlias += mfAdd
        
        elif 'mf' in leftMf: # not append leftMf
            selectAttrAlias += [rightMf] if rightMf != '' and 'mf' in rightMf else []
        elif 'mf' in rightMf: # not append rightMf
            selectAttrAlias += [leftMf] if leftMf != '' and 'mf' in leftMf else []
        
    fromTable = previousView.viewName
    joinTable = selectTarget.viewName
    joinKey = selectMax.joinKey
    
    # deal with comparison
    whereCondList = []
    for comp in corReducePhase.incidentComp[1:]:
        whereCondList.append(comp.left + comp.op + comp.right)
    
    stageEnd = StageEnd(viewName, [], selectAttrAlias, fromTable, joinTable, joinKey, '', whereCond, whereCondList)

    retEnum = EnumeratePhase(createSample, selectMax, selectTarget, stageEnd, semiEnumerate, corReducePhase.corresNodeId, corReducePhase.reduceDirection, corReducePhase.PhaseType)
    return retEnum

def generateIR(JT: JoinTree, COMP: dict[int, Comparison], outputVariables: list[str]) -> [list[ReducePhase], list[EnumeratePhase]]:
    jointree = copy.deepcopy(JT)
    remainRelations = jointree.getRelations().values()
    comparisons = list(COMP.values())   
    selfComparisons = [comp for comp in comparisons if comp.getPredType == predType.Self]     
    
    global outVars, compKeySet
    outVars = outputVariables
    for comp in comparisons:
        left, _ = splitLR(comp.left)
        compKeySet.update(left)
        right, _ = splitLR(comp.right)
        compKeySet.update(right)
    
    reduceList: list[ReducePhase] = []
    enumerateList: list[EnumeratePhase] = []
    
    def getLeafRelation(relations: list[Edge]) -> list[Edge]:
        # leafRelation = [rel for rel in relations if rel.dst.isLeaf and not rel.dst.isRoot]
        leafRelation = []
        for rel in relations:
            if rel.dst.isLeaf and not rel.dst.isRoot:
                leafRelation.append(rel)
        return leafRelation
    
    def getSupportRelation(relations: list[Edge]) -> list[Edge]:
        supportRelation = []
        
        # case1
        for rel in relations :
            childNode = rel.dst
            parentNode = rel.src
            if parentNode.relationType == RelationType.AuxiliaryRelation and childNode.id == parentNode.supRelationId:
                supportRelation.append(rel)
        # case2 
        for rel in relations:
            childNode = rel.dst
            while childNode.id != jointree.root.id:
                if childNode.id in jointree.supId:
                    supportRelation.append(rel)
                    break
                childNode = childNode.parent
                
        return supportRelation
        
    '''Get incident comparisons'''
    def getCompRelation(relation: Edge) -> list[Comparison]:
        # corresComp = [comp for comp in comparisons if relation.dst.id == comp.beginNodeId or relation.dst.id == comp.endNodeId]
        corresComp = [comp for comp in comparisons if [relation.dst.id, relation.src.id] in comp.path or [relation.src.id, relation.dst.id] in comp.path]
        numLong = len([comp for comp in corresComp if len(comp.path) > 1])
        if numLong < 2 and not relation.dst.isRoot:
            return corresComp
        else:
            raise NotImplementedError("Can only Support one incident long comparison or the dst is root! ")
    
    def getSelfComp(relation: Edge) -> list[Comparison]:
        selfComp = [comp for comp in selfComparisons if len(comp.path) and (relation.dst.id == comp.path[0][0] or relation.src.id == comp.path[0][0])]
        return selfComp
    
    def updateComprison(compList: list[Comparison], updateDirection: list[Direction]):
        '''Update comparisons'''
        if len(compList) == 0: return
        else:
            for index, update in enumerate(updateDirection):
                if update == Direction.Left:
                    compList[index].deletePath(Direction.Left) # compList reference to comparisons
                elif update == Direction.Right:
                    compList[index].deletePath(Direction.Right)
                    
    def updateSelfComparison(compList: list[Comparison]):
        if len(compList) == 0: return
        else:
            for comp in compList:
                comp.deletePath(Direction.Left)
    
    
    '''Step1: Reduce'''
    while len(remainRelations) > 1:
        leafRelation = getLeafRelation(remainRelations)
        supportRelation = getSupportRelation(leafRelation)
        if len(supportRelation) == 0:
            rel = choice(leafRelation)
        else:
            rel = choice(supportRelation)
        # print(rel)
        incidentComp = getCompRelation(rel) # long/short
        selfComp = getSelfComp(rel)
        updateDirection = []
        retReduce = None
        if len(incidentComp) == 0:  # semijoin only
            retReduce = buildReducePhase(rel, JT, incidentComp, selfComp, Direction.SemiJoin)
        else: # default, for short comaprison use cqc if only one incident comparison
            if len(incidentComp) > 1:
                incidentComp.sort(key=lambda comp: (len(comp.originPath), comp.predType), reverse=True)
            onlyComp = incidentComp[0]
            supportRelationFlag = True if rel.dst.id in jointree.supId else False
            if rel.dst.id == onlyComp.getBeginNodeId:
                pathIdx = onlyComp.originPath.index([rel.dst.id, rel.src.id])
                helperLeftFrom = onlyComp.helperAttr[pathIdx-1][1] if rel.dst.id != onlyComp.originBeginNodeId else onlyComp.left
                helperLeftTo = 'mfL' + str(randint(0, maxsize)) if not supportRelationFlag else helperLeftFrom
                # use orioginal short comparison
                if onlyComp.getPredType == predType.Short: # do only once
                    if len(onlyComp.originPath) > 1 and pathIdx + 1 < len(onlyComp.originPath):
                        helperRightFrom = onlyComp.helperAttr[pathIdx+1][0]
                    else:
                        helperRightFrom = onlyComp.right
                else:
                    helperRightFrom = ''
                onlyComp.helperAttr[pathIdx] = [helperLeftFrom, helperLeftTo]
                retReduce = buildReducePhase(rel, JT, incidentComp, selfComp, Direction.Left, [helperLeftFrom, helperLeftTo], [helperRightFrom, helperRightFrom])
                updateDirection.append(Direction.Left)
            elif rel.dst.id == onlyComp.getEndNodeId:
                pathIdx = onlyComp.originPath.index([rel.src.id, rel.dst.id])
                # use orioginal short comparison
                if onlyComp.getPredType == predType.Short:
                    if len(onlyComp.originPath) > 1 and pathIdx - 1 >= 0:
                        helperLeftFrom = onlyComp.helperAttr[pathIdx-1][1]
                    else:
                        helperLeftFrom = onlyComp.left
                else:
                    helperLeftFrom = ''
                helperRightFrom = onlyComp.helperAttr[pathIdx+1][0] if rel.dst.id != onlyComp.originEndNodeId else onlyComp.right
                helperRightTo = 'mfR' + str(randint(0, maxsize)) if not supportRelationFlag else helperRightFrom
                onlyComp.helperAttr[pathIdx] = [helperRightTo, helperRightFrom]
                retReduce = buildReducePhase(rel, JT, incidentComp, selfComp, Direction.Right, [helperLeftFrom, helperLeftFrom], [helperRightFrom, helperRightTo])
                updateDirection.append(Direction.Right)
            else:
                raise RuntimeError("Should not happen! ")
        
        # Update relation & comparisons
        jointree.removeEdge(rel)
        remainRelations = jointree.getRelations().values()
        # selfComparisons = [comp for comp in selfComparisons if len(comp.path)]? not working
        updateComprison(incidentComp, updateDirection)
        updateSelfComparison(selfComp)
        
        # Attach reduce to JoinTree & update previous join result view name
        JT.getNode(rel.dst.id).reducePhase = retReduce  
        if JT.getNode(rel.src.id).relationType == RelationType.BagRelation and retReduce.bagAuxView is not None:
            JT.getNode(rel.src.id).JoinResView = retReduce.bagAuxView
        elif retReduce.semiView:
            JT.getNode(rel.src.id).JoinResView = retReduce.semiView
        else:
            JT.getNode(rel.src.id).JoinResView = retReduce.joinView
        
        # Append to ReduceList
        reduceList.append(retReduce)
            

    def checkSupportRelation(rel: Edge) -> list[Edge]:
        childNode = rel.dst
        parentNode = rel.src
        
        if parentNode.relationType == RelationType.AuxiliaryRelation and childNode.id == parentNode.supRelationId:
            return True
        '''
        if parentNode.relationType == RelationType.BagRelation:
            for inId in parentNode.insideId:
                inNode = JT.getNode(inId)
                if inNode.relationType == RelationType.AuxiliaryRelation and childNode.id == inNode.supRelationId:
                    return True
        ''' 
        if childNode.id in jointree.supId:
            return True
        
        return False
        

    # remianRelations == 1
    rel = list(remainRelations)[0]
    supportRelationFlag = checkSupportRelation(rel)
    # print(rel)
    incidentComp = getCompRelation(rel)
    selfComp = getSelfComp(rel)
    # no differ number of comparison cases
    if len(incidentComp) == 0:  # semijoin only
        retReduce = buildReducePhase(rel, JT, incidentComp, selfComp, Direction.SemiJoin, lastRel=True)
    else:
        if len(incidentComp) > 1:
            incidentComp.sort(key=lambda comp: (len(comp.originPath), comp.predType), reverse=True)
        onlyComp = incidentComp[0]
        if (onlyComp.getPredType == predType.Short or onlyComp.getPredType == predType.Self):
            # last relation mfToLeft #COMP mfToRight
            if rel.dst.id == onlyComp.getBeginNodeId: # dst -> root
                pathIdx = onlyComp.originPath.index([rel.dst.id, rel.src.id])
                helperLeftFrom = onlyComp.helperAttr[pathIdx-1][1] if rel.dst.id != onlyComp.originBeginNodeId else onlyComp.left
                helperLeftTo = 'mfL' + str(randint(0, maxsize)) if not supportRelationFlag else helperLeftFrom
                # original short comparison
                if len(onlyComp.originPath) > 1 and pathIdx + 1 < len(onlyComp.originPath):
                    helperRightFrom = onlyComp.helperAttr[pathIdx+1][0]
                else:
                    helperRightFrom = onlyComp.right

                onlyComp.helperAttr[pathIdx] = [helperLeftFrom, helperLeftTo] # update
                retReduce = buildReducePhase(rel, JT, incidentComp, selfComp, Direction.Left, [helperLeftFrom, helperLeftTo], [helperRightFrom, helperRightFrom], lastRel=True)
            elif rel.dst.id == onlyComp.getEndNodeId: # root <- dst
                pathIdx = onlyComp.originPath.index([rel.src.id, rel.dst.id])
                # original short comparison
                if len(onlyComp.originPath) > 1 and pathIdx - 1 >= 0:
                    helperLeftFrom = onlyComp.helperAttr[pathIdx-1][1]
                else:
                    helperLeftFrom = onlyComp.left
                
                helperRightFrom = onlyComp.helperAttr[pathIdx+1][0] if rel.dst.id != onlyComp.originEndNodeId else onlyComp.right
                helperRightTo = 'mfR' + str(randint(0, maxsize)) if not supportRelationFlag else helperRightFrom
                onlyComp.helperAttr[pathIdx] = [helperRightTo, helperRightFrom] # update
                retReduce = buildReducePhase(rel, JT, incidentComp, selfComp, Direction.Right, [helperLeftFrom, helperLeftFrom], [helperRightFrom, helperRightTo], lastRel=True)
            else:
                raise RuntimeError("Last comparison error! ")
        else:
            # Long comparison
            raise NotImplementedError("Should only be short/self comparison!")
    
    reduceList.append(retReduce)
    # attach ReducePhase to the TreeNode
    JT.getNode(rel.dst.id).reducePhase = retReduce
    if JT.getNode(rel.src.id).relationType == RelationType.BagRelation and retReduce.bagAuxView is not None:
        JT.getNode(rel.src.id).JoinResView = retReduce.bagAuxView
    elif retReduce.semiView:
        JT.getNode(rel.src.id).JoinResView = retReduce.semiView
    else:
        JT.getNode(rel.src.id).JoinResView = retReduce.joinView
    
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
        
        # lastEnum = optimize flag
        if enum != enumerateOrder[-1]:
            retEnum = buildEnumeratePhase(previousView, enum, JT)
        else:
            retEnum = buildEnumeratePhase(previousView, enum, JT, lastEnum=True)
            
        enumerateList.append(retEnum)
        
    return reduceList, enumerateList
    
