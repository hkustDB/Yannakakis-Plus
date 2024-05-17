from enumerate import *
from reduce import *
from jointree import *
from comparison import *
from enumsType import *
from random import choice, randint
from sys import maxsize
from typing import Union
from columnPrune import columnPruneYa
from topk import *
from generateIR import *


import globalVar
import re
import copy
from queue import Queue
from functools import cmp_to_key


def buildSemiUp(reduceRel: Edge, JT: JoinTree, selfComp: list[Comparison], compExtract: list[Comp] = []):
    childNode = JT.getNode(reduceRel.dst.id)
    parentNode = JT.getNode(reduceRel.src.id)
    prepareView = []
    
    childSelfComp = [comp for comp in selfComp if childNode.id == comp.path[0][0]]
    parentSelfComp = [comp for comp in selfComp if parentNode.id == comp.path[0][0]]
    parentFlag = parentNode.JoinResView is None and parentNode.relationType == RelationType.TableScanRelation
    childFlag = childNode.JoinResView is None and childNode.relationType == RelationType.TableScanRelation
    childSelfFlag = childNode.isLeaf and len(childSelfComp) and childNode.relationType == RelationType.TableScanRelation
    childExtract = [comp for comp in compExtract if comp.isChild]
    parentExtract = [comp for comp in compExtract if not comp.isChild]
    
    # 0. BAG ONLY: JV=None->no bagAuxView created->still aux node not processed in it
    if parentNode.relationType == RelationType.BagRelation and parentNode.JoinResView is None:
        auxFlag = False
        for id in parentNode.insideId:
            inNode = JT.getNode(id)
            if inNode.relationType == RelationType.AuxiliaryRelation and childNode.id == inNode.supRelationId:
                return buildBagAuxReducePhase(reduceRel, JT, [], selfComp, None, inNode)
    
    # 1-1. prepareView for child
    if childNode.isLeaf and childNode.relationType != RelationType.TableScanRelation and childNode.relationType != RelationType.AuxiliaryRelation:
        ret = buildPrepareView(JT, childNode, childSelfComp=childSelfComp, childExtract=childExtract)
        if ret != []: prepareView.extend(ret)
    
    # 1-2. prepareView for parent
    if parentNode.relationType != RelationType.TableScanRelation and parentNode.relationType != RelationType.AuxiliaryRelation:
        ret = buildPrepareView(JT, parentNode, childSelfComp=parentSelfComp, childExtract=parentExtract)
        if ret != []: prepareView.extend(ret)
    elif parentNode.relationType == RelationType.AuxiliaryRelation and childNode.id == parentNode.supRelationId:
        ret = buildPrepareView(JT, parentNode, parentSelfComp, extraNode=childNode, extraSelfComp=childSelfComp, extraExtract=childExtract)
        if ret != []: prepareView.extend(ret)

    # 2. SemiJoin
    ## Special case: parent is aux
    
    viewName = 'semiUp' + str(randint(0, maxsize))
    if parentNode.relationType == RelationType.AuxiliaryRelation and childNode.id == parentNode.supRelationId:
        semiUp = SemiUpPhase(prepareView, prepareView[-1])
        return semiUp
    
    selectAttributes, selectAttributesAs = [], []
    fromTable = ''
    if parentNode.JoinResView is not None: # already has alias
        selectAttributesAs = parentNode.JoinResView.selectAttrAlias.copy()
        fromTable = parentNode.JoinResView.viewName
    elif parentNode.relationType != RelationType.TableScanRelation: # create view node already
        selectAttributesAs = parentNode.cols.copy()
        fromTable = parentNode.alias
    else:
        selectAttributes = parentNode.col2vars[1].copy()
        selectAttributesAs = parentNode.cols.copy()
        # add support for extract
        for comp in parentExtract:
            if comp.result in outVars:
                pattern = re.compile('v[0-9]+')
                inVars = pattern.findall(comp.expr)
                for var in inVars:
                    originVar = parentNode.col2vars[1][parentNode.cols.index(var)]
                    comp.expr = comp.expr.replace(var, originVar)
                selectAttributes.append(comp.expr)
                selectAttributesAs.append(comp.result)
            else:
                raise NotImplementedError("Only support EXTRACT function in groupBy & appear in output attrs! ")
        fromTable = parentNode.source + ' AS ' + parentNode.alias

    joinTable = ''
    if childNode.JoinResView is not None: # already has alias 
        joinTable = childNode.JoinResView.viewName
    elif childNode.relationType != RelationType.TableScanRelation: # create view node already
        joinTable = childNode.alias
    else:
        joinTable = childNode.source + ' AS ' + childNode.alias
    
    joinKey = list(set(childNode.cols) & set(parentNode.cols))
    inLeft, inRight = [], []
    if childFlag and parentFlag:
        for eachKey in joinKey:
            originalNameP = parentNode.col2vars[1][parentNode.col2vars[0].index(eachKey)] if parentFlag else eachKey
            originalNameC = childNode.col2vars[1][childNode.col2vars[0].index(eachKey)] if childFlag else eachKey        
            inLeft.append(originalNameP) 
            inRight.append(originalNameC)
    elif not childFlag and parentFlag:
        for eachKey in joinKey:
            originalNameP = parentNode.col2vars[1][parentNode.col2vars[0].index(eachKey)] if parentFlag else eachKey
            inLeft.append(originalNameP) 
            inRight.append(eachKey)
    elif childFlag and not parentFlag:
        for eachKey in joinKey:
            originalNameC = childNode.col2vars[1][childNode.col2vars[0].index(eachKey)] if childFlag else eachKey        
            inLeft.append(eachKey) 
            inRight.append(originalNameC)
    else:
        inLeft.extend(joinKey)
        inRight.extend(joinKey)

    outerWhereCondList = []
    if parentFlag and len(parentSelfComp):
        outerWhereCondList = makeSelfComp(parentSelfComp, parentNode)
    # children self comparison
    if childSelfFlag:
        whereCondList = makeSelfComp(childSelfComp, childNode)
        semiView = SemiJoin(viewName, selectAttributes, selectAttributesAs, fromTable, joinTable, inLeft, inRight, whereCondList, outerWhereCondList)
    else: # could use alias
        semiView = SemiJoin(viewName, selectAttributes, selectAttributesAs, fromTable, joinTable, inLeft, inRight, [], outerWhereCondList)
    semiUp = SemiUpPhase(prepareView, semiView)
    return semiUp


def buildSemiDown(JT: JoinTree, childNode: TreeNode, parentNode: TreeNode, selfComp: list[Comparison], compExtract: list[Comp] = []):
    childSelfComp = [comp for comp in selfComp if childNode.id == comp.path[0][0]]
    childExtract = [comp for comp in compExtract if comp.isChild]
    if not (childNode.isLeaf and len(childSelfComp) and childNode.relationType == RelationType.TableScanRelation):
        childSelfComp, childExtract = [], []
    childFlag = childNode.JoinResView is None and childNode.relationType == RelationType.TableScanRelation
    
    viewName = 'semiDown' + str(randint(0, maxsize))
    selectAttributes, selectAttributesAs = [], []
    fromTable = ''
    if childNode.JoinResView is not None:
        selectAttributesAs = childNode.JoinResView.selectAttrAlias.copy()
        fromTable = childNode.JoinResView.viewName
    elif childNode.relationType != RelationType.TableScanRelation:
        selectAttributesAs = childNode.cols
        fromTable = childNode.alias
    else:
        selectAttributes = childNode.col2vars[1].copy()
        selectAttributesAs = childNode.cols.copy()
        for comp in childExtract:
            if comp.result in outVars:
                pattern = re.compile('v[0-9]+')
                inVars = pattern.findall(comp.expr)
                for var in inVars:
                    originVar = childNode.col2vars[1][childNode.cols.index(var)]
                    comp.expr = comp.expr.replace(var, originVar)
                selectAttributes.append(comp.expr)
                selectAttributesAs.append(comp.result)
            else:
                raise NotImplementedError("Only support EXTRACT function in groupBy & appear in output attrs! ")
        fromTable = childNode.source + ' AS ' + childNode.alias

    joinTable = ''
    if parentNode.JoinResView is not None:
        joinTable = parentNode.JoinResView.viewName
    else:
        raise RuntimeError("Parent Node should have JoinResView! ")
    
    joinKey = list(set(childNode.cols) & set(parentNode.cols))
    inLeft, inRight = [], []
    if childFlag:
        for eachKey in joinKey:
            originalNameC = childNode.col2vars[1][childNode.col2vars[0].index(eachKey)]
            inLeft.append(originalNameC) 
            inRight.append(eachKey)
    else:
        inLeft.extend(joinKey)
        inRight.extend(joinKey)

    if len(childSelfComp):
        outerWhereCondList = makeSelfComp(childSelfComp, childNode)
        semiView = SemiJoin(viewName, selectAttributes, selectAttributesAs, fromTable, joinTable, inLeft, inRight, outerWhereCondList=outerWhereCondList)
    else:
        semiView = SemiJoin(viewName, selectAttributes, selectAttributesAs, fromTable, joinTable, inLeft, inRight)
    return semiView

def buildAggUp(JT: JoinTree, reduceRel: Edge, Agg: Aggregation, outputVariables: list[str], aggFuncList: list[AggFunc] = [], lastRel: bool = False):
    childNode = JT.getNode(reduceRel.dst.id)
    parentNode = JT.getNode(reduceRel.src.id)
    childFlag = childNode.isLeaf and childNode.relationType == RelationType.TableScanRelation

    aggView = aggJoin = None

    # 1. aggView
    viewName = 'aggView' + str(randint(0, maxsize))
    fromTable = childNode.JoinResView.viewName
    joinKey = list(set(parentNode.JoinResView.selectAttrAlias) & set(childNode.reserve))

    pkFlag = False
    if (reduceRel.keyType == EdgeType.Child or reduceRel.keyType == EdgeType.Both) and childFlag:
        pkFlag = True
    selectAttr, selectAttrAlias  = [], []
    aggPass2Join, groupBy = [], []
    ## -1. joinKey
    for key in joinKey:
        selectAttr.append('')
        selectAttrAlias.append(key)
        groupBy.append(key)

    # NOTE: extra join key pass
    if len(childNode.reserve) > 1:
        for key in set(childNode.reserve) - set(joinKey):
            selectAttrAlias.append(key)
            selectAttr.append('')
            groupBy.append(key)
            aggPass2Join.append(key)

    ## -2. previousAgg
    for var in childNode.JoinResView.selectAttrAlias:
        if var in Agg.allAggAlias:
            if not pkFlag:
                if Agg.alias2AggFunc[var].funcName != AggFuncType.AVG:
                    selectAttr.append(Agg.alias2AggFunc[var].funcName.name + '(' + var + ')')
                else:
                    selectAttr.append('SUM(' + var + ')')
            else:
                selectAttr.append(var)
            selectAttrAlias.append(var)
            aggPass2Join.append(var)
        # Add support for case aggregation
        if var in set({'caseCond', 'caseRes'}):
            selectAttr.append('')
            selectAttrAlias.append(var)
            aggPass2Join.append(var)
        
    ## -3. newAgg -> only new aggAlias need `* annot`
    for agg in aggFuncList:
        if agg.doneFlag: continue
        passAggAlias = True
        if not len(agg.inVars):
            raise RuntimeError("Only count(*) is considered! ")
        elif len(agg.inVars) == 1:
            # inVar or alias
            findInVars = childNode.JoinResView.selectAttrAlias
            if agg.inVars[0] in findInVars:
                if not pkFlag:
                    if childNode.JoinResView and 'annot' in findInVars:
                        # FIXME: why replace
                        if agg.funcName == AggFuncType.SUM:
                            selectAttr.append(agg.funcName.name + '(' + agg.formular + ' * annot' + ')')
                        elif agg.funcName == AggFuncType.AVG:
                            selectAttr.append('SUM(' + agg.formular + ' * annot' + ')')
                        elif agg.funcName == AggFuncType.COUNT:
                            selectAttr.append(agg.funcName.name + '(' + agg.formular + ' * annot' + ')' )
                        else:
                            # MIN/MAX
                            selectAttr.append(agg.funcName.name + '(' + agg.formular + ')')
                    else:
                        selectAttr.append(agg.funcName.name + '(' + agg.formular + ')')
                else:
                    if childNode.JoinResView and 'annot' in findInVars:
                        if agg.funcName == AggFuncType.MIN or agg.funcName == AggFuncType.MAX:
                            selectAttr.append(agg.formular)
                        else:
                            selectAttr.append(agg.formular + ' * annot')
                    elif childNode.JoinResView:
                        selectAttr.append(agg.formular)

                Agg.alias2AggFunc[agg.alias].doneFlag = True
                agg.doneFlag = True 
                selectAttrAlias.append(agg.alias)
            else:
                raise RuntimeError("Must be one name in inVars/aggFunciton alias! ")
        else:
            findInVars = childNode.JoinResView.selectAttrAlias
                
            if 'CASE' in agg.formular:
                _, caseCond, caseRes1, caseRes2 = re.split(' WHEN | THEN | ELSE | END', agg.formular)[:-1]
                if not '0.0' in caseRes2:
                    raise NotImplementedError("Case aggregation res2 not equal 0.0! ")
                passAggAlias = False
                caseCond = caseCond[1:-1]
                caseRes1 = caseRes1[1:-1]
                pattern = re.compile('v[0-9]+')
                condVar = pattern.findall(caseCond)
                res1Var = pattern.findall(caseRes1)
                annotFlag = '*annot' if childNode.JoinResView and 'annot' in findInVars else ''
                if condVar[0] in findInVars and res1Var[0] in findInVars:
                    Agg.alias2AggFunc[agg.alias].doneFlag = True
                    agg.doneFlag = True
                    passAggAlias = True
                    selectAttrAlias.append(agg.alias)
                    if not pkFlag:
                        if agg.funcName == AggFuncType.AVG:
                            selectAttr.append('SUM(' + agg.formular + annotFlag + ')')
                        elif agg.funcName == AggFuncType.MIN or agg.funcName == AggFuncType.MAX:
                            selectAttr.append(agg.funcName.name + '(' + agg.formular + ')')
                        else:
                            selectAttr.append(agg.funcName.name + '(' + agg.formular + annotFlag + ')')
                    else:
                        if agg.funcName == AggFuncType.MIN or agg.funcName == AggFuncType.MAX:
                            selectAttr.append(agg.formular)
                        else:
                            selectAttr.append(agg.formular + annotFlag)
                elif 'caseCond' in findInVars and res1Var[0] in findInVars:
                    Agg.alias2AggFunc[agg.alias].doneFlag = True
                    agg.doneFlag = True
                    passAggAlias = True
                    selectAttrAlias.append(agg.alias)
                    dIndex = selectAttrAlias.index('caseCond')
                    selectAttrAlias.pop(dIndex)
                    selectAttr.pop(dIndex)
                    aggPass2Join.remove('caseCond')
                    if agg.funcName == AggFuncType.MIN or agg.funcName == AggFuncType.MAX:
                        selectAttr.append(agg.funcName.name + '( CASE WHEN caseCond = 1 THEN ' + caseRes1 + ' ELSE 0.0 END)')
                    elif agg.funcName != AggFuncType.AVG:
                        selectAttr.append(agg.funcName.name + '( CASE WHEN caseCond = 1 THEN ' + caseRes1 + annotFlag + ' ELSE 0.0 END)')
                    else:
                        selectAttr.append('SUM( CASE WHEN caseCond = 1 THEN ' + caseRes1 + annotFlag + ' ELSE 0.0 END)')
                elif 'caseRes' in findInVars and condVar[0] in findInVars:
                    Agg.alias2AggFunc[agg.alias].doneFlag = True
                    agg.doneFlag = True
                    passAggAlias = True
                    selectAttrAlias.append(agg.alias)
                    dIndex = selectAttrAlias.index('caseRes')
                    selectAttrAlias.pop(dIndex)
                    selectAttr.pop(dIndex)
                    aggPass2Join.remove('caseRes')
                    if agg.funcName == AggFuncType.MIN or agg.funcName == AggFuncType.MAX:
                        selectAttr.append(agg.funcName.name + '( CASE WHEN ' + caseCond + ' THEN caseRes ELSE 0.0 END)')
                    elif agg.funcName != AggFuncType.AVG:
                        selectAttr.append(agg.funcName.name + '( CASE WHEN ' + caseCond + ' THEN caseRes' + annotFlag + ' ELSE 0.0 END)')
                    else:
                        selectAttr.append('SUM( CASE WHEN ' + caseCond + ' THEN caseRes' + annotFlag + ' ELSE 0.0 END)')
                elif condVar[0] in findInVars and res1Var[0] in findInVars:
                    Agg.alias2AggFunc[agg.alias].doneFlag = True
                    agg.doneFlag = True
                    passAggAlias = True
                    selectAttrAlias.append(agg.alias)
                    if not pkFlag:
                        if agg.funcName == AggFuncType.MIN or agg.funcName == AggFuncType.MAX:
                            selectAttr.append(agg.funcName.name + '(' + agg.formular + ')')
                        elif agg.funcName != AggFuncType.AVG:
                            selectAttr.append(agg.funcName.name + '(' + agg.formular + annotFlag + ')')
                        else:
                            selectAttr.append('SUM(' + agg.formular + annotFlag + ')')
                    else:
                        if agg.funcName == AggFuncType.MIN or agg.funcName == AggFuncType.MAX:
                            selectAttr.append(agg.formular)
                        else:
                            selectAttr.append(agg.formular + annotFlag)
                elif condVar[0] in findInVars:
                    selectAttr.append('CASE WHEN ' + caseCond + ' THEN 1 ELSE 0 END')
                    selectAttrAlias.append('caseCond')
                    aggPass2Join.append('caseCond')
                elif res1Var[0] in findInVars:
                    if agg.funcName == AggFuncType.MIN or agg.funcName == AggFuncType.MAX:
                        selectAttr.append(caseRes1)
                    else:
                        selectAttr.append(caseRes1 + annotFlag)
                    selectAttrAlias.append('caseRes')
                    aggPass2Join.append('caseRes')
                else:
                    raise NotImplementedError("Error case! ")
                        
            else:
                allInOne = True
                for invar in agg.inVars:
                    if invar not in findInVars:
                        allInOne = False
                        break
                if allInOne:
                    Agg.alias2AggFunc[agg.alias].doneFlag = True
                    agg.doneFlag = True
                    selectAttrAlias.append(agg.alias)
                    if childNode.JoinResView and 'annot' in findInVars:
                        if not pkFlag:
                            if agg.funcName == AggFuncType.SUM:
                                selectAttr.append(agg.funcName.name + '(' + agg.formular + ' * annot' + ')')
                            elif agg.funcName == AggFuncType.AVG:
                                selectAttr.append('SUM' + '(' + agg.formular + ' * annot' + ')')
                            elif agg.funcName == AggFuncType.COUNT:
                                selectAttr.append(agg.funcName.name + '(' + agg.formular + ' * annot' + ')')
                            else:
                                # MIN/MAX
                                selectAttr.append(agg.funcName.name + agg.formular)
                        else:
                            if agg.funcName != AggFuncType.MIN and agg.funcName != AggFuncType.MAX:
                                selectAttr.append(agg.formular + ' * annot')
                            else:
                                selectAttr.append(agg.formular)
                    else:
                        if not pkFlag:
                            if agg.formular[0] != '(':
                                selectAttr.append(agg.funcName.name + '(' + agg.formular + ')')
                            else:
                                selectAttr.append(agg.funcName.name + agg.formular)
                        else:
                            selectAttr.append(agg.formular)
                else:   # need to pass variables
                    passAggAlias = False
                    for invar in agg.inVars:
                        # pass agg vars may have duplicates
                        if invar in findInVars and invar not in selectAttrAlias:
                            if not pkFlag:
                                if not len(selectAttr):
                                    selectAttr = [''] * len(selectAttrAlias)
                                selectAttr.append('SUM(' + invar + ')/COUNT(*)')
                            else:
                                if len(selectAttr):
                                    selectAttr.append('')
                            selectAttrAlias.append(invar)
                            aggPass2Join.append(invar)

        if passAggAlias:
            aggPass2Join.append(agg.alias)
                
    # FIXME: extraCond
    setExtraCond: set[str] = set(childNode.JoinResView.selectAttrAlias) & JT.extraCondList.allAlias
    if len(setExtraCond):
        for alias in setExtraCond:
            if alias not in selectAttrAlias:
                selectAttr.append('')
                selectAttrAlias.append(alias)
            if alias not in aggPass2Join: aggPass2Join.append(alias)
            if alias not in groupBy: groupBy.append(alias)
    setOutVars = set(childNode.JoinResView.selectAttrAlias) & set(outputVariables)
    if len(setOutVars):
        for alias in setOutVars:
            if alias not in selectAttrAlias:
                selectAttr.append('')
                selectAttrAlias.append(alias)
            if alias not in aggPass2Join: aggPass2Join.append(alias)
            if alias not in groupBy: groupBy.append(alias)
    
    # Pass extra group by
    for var in childNode.JoinResView.selectAttrAlias:
        if var in Agg.groupByVars:
            if var not in groupBy and not pkFlag:
                groupBy.append(var)
            if var not in selectAttrAlias:
                if len(selectAttr):
                    selectAttr.append('')
                selectAttrAlias.append(var)
            if var not in aggPass2Join:
                aggPass2Join.append(var)
    
    ## d. append annot
    # NOTE: Extra optimization for job benchmark
    if globalVar.get_value('DDL_NAME') != 'job.ddl':
        if not 'annot' in childNode.JoinResView.selectAttrAlias and not pkFlag:
            if not len(selectAttr):
                selectAttr = [''] * len(selectAttrAlias)
            selectAttr.append('COUNT(*)')
            selectAttrAlias.append('annot')
        elif not pkFlag:
            if not len(selectAttr):
                selectAttr = [''] * len(selectAttrAlias)
            selectAttr.append('SUM(annot)')
            selectAttrAlias.append('annot')
    # Add caseCond, caseRes in groupBy
    if 'caseCond' in selectAttrAlias and 'caseCond' not in groupBy:
        groupBy.append('caseCond')
    if 'caseRes' in selectAttrAlias and 'caseRes' not in groupBy:
        groupBy.append('caseRes')

    if pkFlag:
        groupBy = []
    aggView = AggView(viewName, selectAttr, selectAttrAlias, fromTable, groupBy)

    # Step3: aggJoin
    ## a. name, fromTable
    viewName = 'aggJoin' + str(randint(0, maxsize))
    if parentNode.relationType == RelationType.AuxiliaryRelation and parentNode.supRelationId == childNode.id:
        fromTable = ''
    else:
        fromTable = parentNode.JoinResView.viewName
    
    ## b. joinTable
    joinTable = aggView.viewName
    
    ## c. select attributes: original + annot + aggregation from childNode(aggPass2Join)
    selectAttr = []
    selectAttrAlias = parentNode.JoinResView.selectAttrAlias.copy()
    if 'annot' in selectAttrAlias and not pkFlag:   # Should not happen for job.ddl <- no annot at all
        # update annotation
        selectAttr.extend(['' for _ in range(len(selectAttrAlias))])
        index = selectAttrAlias.index('annot')
        mulAnnot = parentNode.JoinResView.viewName + '.annot * ' + joinTable + '.annot'
        selectAttr[index] = mulAnnot
        selectAttrAlias[index] = 'annot'
        # original aggregation
        for index, val in enumerate(selectAttrAlias):
            if val in Agg.allAggAlias and Agg.alias2AggFunc[val].funcName != AggFuncType.MIN and Agg.alias2AggFunc[val].funcName != AggFuncType.MAX:
                selectAttr[index] = val + '*' + joinTable + '.annot'
                selectAttrAlias[index] = val
            elif val in Agg.allAggAlias:
                selectAttr[index] = val
                selectAttrAlias[index] = val
        # new aggregation & pass on aggregation variables
        for agg in aggPass2Join:
            if agg in Agg.allAggAlias and Agg.alias2AggFunc[agg].funcName != AggFuncType.MIN and Agg.alias2AggFunc[agg].funcName != AggFuncType.MAX:
                # aggregation function
                selectAttr.append(agg + ' * ' + parentNode.JoinResView.viewName + '.annot')
                selectAttrAlias.append(agg)
            elif agg in Agg.allAggAlias:
                selectAttr.append('')
                selectAttrAlias.append(agg)
            elif agg not in selectAttrAlias:
                # FIXME: just pass on alias for later aggregation for special case
                selectAttr.append('')
                selectAttrAlias.append(agg)         
    elif 'annot' not in selectAttrAlias and not pkFlag:
        if fromTable != '':
            selectAttr.extend(['' for _ in range(len(selectAttrAlias))])
            # original aggregation
            for index, val in enumerate(selectAttrAlias):
                if val in Agg.allAggAlias and Agg.alias2AggFunc[val].funcName != AggFuncType.MIN and Agg.alias2AggFunc[val].funcName != AggFuncType.MAX:
                    selectAttr[index] = val + '*' + joinTable + '.annot'
                    selectAttrAlias[index] = val
                elif val in Agg.allAggAlias:
                    selectAttr[index] = val
                    selectAttrAlias[index] = val
            # new aggregation & pass on aggregation variables
            for agg in aggPass2Join:
                if agg not in selectAttrAlias: 
                    selectAttr.append('')
                    selectAttrAlias.append(agg)
            if globalVar.get_value('DDL_NAME') != 'job.ddl':
                selectAttr.append('')
                selectAttrAlias.append('annot')
    elif 'annot' in selectAttrAlias and pkFlag:
        # update annotation
        selectAttr.extend(['' for _ in range(len(selectAttrAlias))])
        # new aggregation & pass on aggregation variables
        for agg in aggPass2Join:
            if agg in Agg.allAggAlias and Agg.alias2AggFunc[agg].funcName != AggFuncType.MIN and Agg.alias2AggFunc[agg].funcName != AggFuncType.MAX:
                # aggregation function
                selectAttr.append(agg + ' * ' + parentNode.JoinResView.viewName + '.annot')
                selectAttrAlias.append(agg)
            elif agg in Agg.allAggAlias:
                selectAttr.append(agg)
                selectAttrAlias.append(agg)
            elif agg not in selectAttrAlias:
                # just pass on alias for later aggregation
                selectAttr.append('')
                selectAttrAlias.append(agg)
    else:
        selectAttrAlias.extend(aggPass2Join)
    
    ## d.joinCond
    usingJoinKey = joinKey.copy()
    
    ## g. addExtraEqualCond process:
    extraEqualWhere = []
    if lastRel:
        if not parentNode.JoinResView and parentNode.relationType == RelationType.TableScanRelation:
            for eachExtra in JT.extraCondList.condList:
                if '=' in eachExtra.cond and len(eachExtra.vars) == 2:
                    left, right = eachExtra.cond.split('=')
                    if left in parentNode.cols:
                        extraEqualWhere.append(parentNode.col2vars[1][parentNode.cols.index(left)] + '=' + right)
                    elif right in parentNode.cols:
                        extraEqualWhere.append(left + '=' + parentNode.col2vars[1][parentNode.cols.index(right)])
                else:
                    raise NotImplementedError("ExtraEqualCond not in 'a=b' case! ")  
        else:
            for eachExtra in JT.extraCondList.condList:
                if '=' in eachExtra.cond and len(eachExtra.vars) == 2:
                    extraEqualWhere.append(eachExtra.cond)
                else:
                    raise NotImplementedError("ExtraEqualCond not in 'a=b' case! ")

    aggJoin = AggJoin(viewName, selectAttr, selectAttrAlias, fromTable, joinTable, joinKey, usingJoinKey, extraEqualWhere)
    if fromTable == '' and len(aggJoin.whereCondList) == 0:
        aggJoin.viewName = aggView.viewName
    aggReduce = AggReducePhase(None, aggView, aggJoin, reduceRel.dst.id)
    return aggReduce


def buildNonAggUp(JT: JoinTree, reduceRel: Edge, extraEqualCond: list[str] = []):
    childNode = JT.getNode(reduceRel.dst.id)
    parentNode = JT.getNode(reduceRel.src.id)

    viewName = 'joinView' + str(randint(0, maxsize))
    selectAttributes, selectAttributesAs = [], []
    selectAttributesAs = parentNode.JoinResView.selectAttrAlias.copy()

    alterJoinKey = []
    if parentNode.JoinResView:
        joinKey = list(set(parentNode.JoinResView.selectAttrAlias) & set(childNode.reserve))
    else:
        joinKey = list(set(parentNode.cols) & set(childNode.reserve))

    alterJoinKey.extend(joinKey)
    
    # original table or previous view
    fromTable = parentNode.JoinResView.viewName
    if childNode.JoinResView:
        joinTable = childNode.JoinResView.viewName
        for alias in childNode.JoinResView.selectAttrAlias:
            if alias not in selectAttributesAs:
                selectAttributesAs.append(alias)
    elif childNode.relationType == RelationType.TableScanRelation:
        joinTable = childNode.source + ' AS ' + childNode.alias
        selectAttributes = [''] * len(selectAttributesAs)
        for idx, alias in enumerate(childNode.cols):
            if alias not in selectAttributesAs:
                selectAttributes.append(childNode.col2vars[1][idx])
                selectAttributesAs.append(alias)
    else:
        joinTable = childNode.alias
        for alias in childNode.cols:
            if alias not in selectAttributesAs:
                selectAttributesAs.append(alias)

    joinView = Join2tables(viewName, selectAttributes, selectAttributesAs, fromTable, joinTable, joinKey, alterJoinKey)
    return joinView        
    

def yaGenerateIR(JT: JoinTree, COMP: dict[int, Comparison], outputVariables: list[str], computations: CompList, isAgg = False, Agg: Aggregation = None):
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
    
    semiUp: list[SemiUpPhase] = []
    semiDown: list[SemiJoin] = []
    lastUp: Union[list[AggReducePhase], list[Join2tables]] = []
    
    # Get incident aggregation for each node
    def getAggRelation(node: TreeNode) -> list[AggFunc]:
        if not Agg:
            return []
        aggs = []
        statisKeys = set(node.cols) if not node.JoinResView else set(node.JoinResView.selectAttrAlias)
        for aggF in Agg.aggFunc:
            if aggF.doneFlag:
                continue
            if len(aggF.inVars) != 0 and set(aggF.inVars).issubset(statisKeys): # no input vars case
                aggs.append(aggF)
            elif len(aggF.inVars) > 1 and len(set(aggF.inVars) & set(statisKeys)) != 0:
                aggs.append(aggF)
        
        aggs.sort(key=lambda agg: agg.funcName.value)
        return aggs
    
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
    
    def getNodeSelfComp(node: TreeNode) -> list[Comparison]:
        selfComp = [comp for comp in selfComparisons if len(comp.path) and node.id == comp.path[0][0]]
        return selfComp
    
    def getCompExtract(relation: Edge) -> list[Comp]:
        parentCols = set(relation.src.cols)
        childCols = set(relation.dst.cols)
        ret: list[Comp] = []
        for alias, vars in computations.alias2Var.items():
            if vars.issubset(parentCols) or vars.issubset(childCols):
                if computations.alias2Comp[alias].isExtract and not computations.alias2Comp[alias].isDone:
                    computations.alias2Comp[alias].isChild = vars.issubset(childCols)
                    computations.alias2Comp[alias].isDone = True
                    ret.append(computations.alias2Comp[alias])
        return ret
    
    def getNodeCompExtract(node: TreeNode):
        nodeCols = set(node.cols)
        ret: list[Comp] = []
        for alias, vars in computations.alias2Var.items():
            if vars.issubset(nodeCols):
                if computations.alias2Comp[alias].isExtract and not computations.alias2Comp[alias].isDone:
                    computations.alias2Comp[alias].isDone = True
                    ret.append(computations.alias2Comp[alias])
        return ret
                    
    def updateSelfComparison(compList: list[Comparison]):
        if len(compList) == 0: return
        else:
            for comp in compList:
                comp.deletePath(Direction.Left)
    
    '''Step1: semiUp'''
    while len(remainRelations) > 0:
        leafRelation = getLeafRelation(remainRelations)
        supportRelation = getSupportRelation(leafRelation)
        if len(supportRelation) == 0:
            rel = choice(leafRelation)
        else:
            rel = choice(supportRelation)
        incidentComp = getCompRelation(rel) # long/short
        selfComp = getSelfComp(rel)
        compExtract = getCompExtract(rel)
        if len(incidentComp) != 0:  # semijoin only
            raise RuntimeError("Yannakakais does not support short/long comparison! ")
        retSemiUp = buildSemiUp(rel, JT, selfComp, compExtract=compExtract)
        
        jointree.removeEdge(rel)
        remainRelations = jointree.getRelations().values()
        # updateSelfComparison(selfComp)
        JT.getNode(rel.src.id).JoinResView = retSemiUp.semiView
        semiUp.append(retSemiUp)
    
    '''Step2: SemiDown'''
    JTqueue = Queue()
    JTqueue.put(JT.root)
    while (JTqueue.qsize() > 0):
        node = JTqueue.get()
        for child in node.children:
            childNode = JT.getNode(child.id)
            JTqueue.put(childNode)
            # need selfcomp for leaf & tablescan
            selfComp = getNodeSelfComp(childNode)
            compExtract = getNodeCompExtract(childNode)
            retSemiDown = buildSemiDown(JT, childNode, node, selfComp, compExtract)
            JT.getNode(child.id).JoinResView = retSemiDown
            semiDown.append(retSemiDown)
    
    '''Step3: AggUp'''
    def aggCmp(rel1: list[Edge], rel2: list[Edge]):
        if jointree.getNode(rel1.dst.id).reduceOrder < jointree.getNode(rel2.dst.id).reduceOrder:
            return -1
        elif jointree.getNode(rel1.dst.id).reduceOrder > jointree.getNode(rel2.dst.id).reduceOrder:
            return 1
        else:
            if jointree.getNode(rel1.dst.id).depth2Root > jointree.getNode(rel2.dst.id).depth2Root:
                return -1
            elif jointree.getNode(rel1.dst.id).depth2Root < jointree.getNode(rel2.dst.id).depth2Root:
                return 1
            else:
                return jointree.getNode(rel1.dst.id).estimateSize < jointree.getNode(rel2.dst.id).estimateSize

    jointree = copy.deepcopy(JT)
    remainRelations = jointree.getRelations().values()
    while len(remainRelations) > 0:
        leafRelation = getLeafRelation(remainRelations)
        leafRelation.sort(key=cmp_to_key(aggCmp))
        supportRelation = getSupportRelation(leafRelation)
        if len(supportRelation) == 0:
            rel = leafRelation[0]
        else:
            rel = supportRelation[0]
        aggs = getAggRelation(JT.getNode(rel.dst.id))
        if isAgg:
            retAggUp = buildAggUp(JT, rel, Agg, outputVariables, aggs, lastRel=len(jointree.edge)==1)
            if not 'Join' in retAggUp.aggJoin.viewName:
                JT.getNode(rel.src.id).JoinResView = retAggUp.aggView
            else:
                JT.getNode(rel.src.id).JoinResView = retAggUp.aggJoin
        else:
            retAggUp = buildNonAggUp(JT, rel)
            JT.getNode(rel.src.id).JoinResView = retAggUp
        jointree.removeEdge(rel)
        remainRelations = jointree.getRelations().values()
        lastUp.append(retAggUp)

    '''Step4: FinalResult'''
    selectName = []
    compKeys = list(computations.allAlias)
    finalResult = ''
    
    if isAgg:
        lastView = lastUp[-1].aggJoin if 'Join' in lastUp[-1].aggJoin.viewName else lastUp[-1].aggView
        fromTable = lastView.viewName
        finalAnnotFlag = True if 'annot' in lastView.selectAttrAlias else False
        for out in outputVariables:
            if out in Agg.groupByVars:
                selectName.append(out)
            else:
                if out in Agg.allAggAlias:
                    func = Agg.alias2AggFunc[out]
                    if JT.isFreeConnex and len(jointree.subset): # select a, b, c-done, d*annot-undone from A; group by = a, b
                        if func.doneFlag: # do aggregation till root node, not need annotation for done aggregation
                            if func.funcName == AggFuncType.AVG:
                                selectName.extend([out + '/annot' * finalAnnotFlag + 'as ' + out for _ in range(outputVariables.count(out))])
                            elif func.funcName == AggFuncType.COUNT:
                                if finalAnnotFlag:
                                    selectName.extend(['annot as ' + out for _ in range(outputVariables.count(out))])
                                else:
                                    selectName.extend(['1 as ' + out for _ in range(outputVariables.count(out))])
                            else:
                                selectName.extend([out for _ in range(outputVariables.count(out))])
                        else:
                            if func.funcName == AggFuncType.AVG:
                                selectName.extend(['(' + func.originForm + ')' + '/annot' * finalAnnotFlag + 'as ' + out for _ in range(outputVariables.count(out))])
                            elif func.funcName == AggFuncType.COUNT:
                                if finalAnnotFlag:
                                    selectName.extend(['annot as ' + out for _ in range(outputVariables.count(out))])
                                else:
                                    selectName.extend(['1 as ' + out for _ in range(outputVariables.count(out))])
                            elif func.funcName == AggFuncType.SUM:
                                selectName.extend(['(' + func.originForm + ')' + '* annot' * finalAnnotFlag + ' as ' + out for _ in range(outputVariables.count(out))])
                            else:
                                selectName.extend(['(' + func.originForm + ')' + ' as ' + out for _ in range(outputVariables.count(out))])
                    elif not len(jointree.subset): # free-connex but subset = 0 -> len(group by) == 0
                        if 'CASE' in func.formular:
                            _, caseCond, caseRes1, caseRes2 = re.split(' WHEN | THEN | ELSE | END', func.originForm)[:-1]
                            caseCond = caseCond[1:-1]
                            caseRes1 = caseRes1[1:-1]
                            if 'caseCond' in lastView.selectAttrAlias:
                                if func.funcName == AggFuncType.AVG:
                                    selectName.append(func.funcName.name + '( CASE WHEN caseCond = 1 THEN ' + caseRes1 + '/ annot' * finalAnnotFlag + ' ELSE 0.0 END)')
                                elif func.funcName == AggFuncType.COUNT:
                                    selectName.append('SUM((CASE WHEN caseCond = 1 THEN 1 ELSE 0.0 END)' + '*annot' * finalAnnotFlag + ')')
                                elif func.funcName == AggFuncType.SUM:
                                    selectName.append(func.funcName.name + '( CASE WHEN caseCond = 1 THEN ' + caseRes1 + '* annot' * finalAnnotFlag + ' ELSE 0.0 END)')
                                else:
                                    selectName.append(func.funcName.name + '( CASE WHEN caseCond = 1 THEN ' + caseRes1 + ' ELSE 0.0 END)')
                            elif 'caseRes' in lastView.selectAttrAlias:
                                if func.funcName == AggFuncType.AVG:
                                    selectName.append(func.funcName.name + '( CASE WHEN ' + caseCond + ' THEN caseRes ' + '/ annot' * finalAnnotFlag + ' ELSE 0.0 END)')
                                elif func.funcName == AggFuncType.COUNT:
                                    selectName.append('SUM( CASE WHEN ' + caseCond + ' THEN 1' + '* annot' * finalAnnotFlag + ' ELSE 0.0 END)')
                                elif func.funcName == AggFuncType.SUM:
                                    selectName.append(func.funcName.name + '( CASE WHEN ' + caseCond + ' THEN caseRes ' + '* annot' * finalAnnotFlag + ' ELSE 0.0 END)')
                                else:
                                    selectName.append(func.funcName.name + '( CASE WHEN ' + caseCond + ' THEN caseRes ELSE 0.0 END)')
                            else:
                                if func.doneFlag == True:
                                    continue
                                if func.funcName == AggFuncType.AVG:
                                    selectName.append(func.funcName.name + '(' + func.originForm + ')')
                                elif func.funcName == AggFuncType.COUNT:
                                    if finalAnnotFlag:
                                        selectName.append('SUM(' + '(' + func.originForm + ') * annot' + ')')
                                    else:
                                        selectName.append('COUNT(' + func.originForm + ')') # FIXME: split
                                elif func.funcName == AggFuncType.SUM:
                                    selectName.append(func.funcName.name + '(' + func.originForm + '* annot' * finalAnnotFlag + ')')
                                else:
                                    selectName.append(func.funcName.name + '(' + func.originForm + ')')
                        else:
                            if func.doneFlag:
                                if func.funcName == AggFuncType.AVG:
                                    selectName.extend(['AVG(' + out + '/annot' * finalAnnotFlag + ') as ' + out for _ in range(outputVariables.count(out))])
                                elif func.funcName == AggFuncType.COUNT:
                                    if finalAnnotFlag:
                                        selectName.extend(['SUM(annot) as ' + out for _ in range(outputVariables.count(out))])
                                    else:
                                        selectName.extend(['COUNT(*) as ' + out for _ in range(outputVariables.count(out))])
                                else:
                                    selectName.extend([func.funcName.name + '(' + out + ') as ' + out for _ in range(outputVariables.count(out))])
                            else:
                                if func.funcName == AggFuncType.COUNT:
                                    if finalAnnotFlag:
                                        selectName.extend(['SUM(annot) as ' + out for _ in range(outputVariables.count(out))])
                                    else:
                                        selectName.extend(['COUNT(*) as ' + out for _ in range(outputVariables.count(out))])
                                elif func.funcName == AggFuncType.AVG:
                                    selectName.extend(['AVG(' + func.originForm + '/annot' * finalAnnotFlag + ') as ' + out for _ in range(outputVariables.count(out))])
                                elif func.funcName == AggFuncType.MIN and func.funcName == AggFuncType.MAX:
                                    selectName.extend([func.funcName.name + '(' + func.originForm + ') as ' + out for _ in range(outputVariables.count(out))])
                                else:
                                    selectName.extend([func.funcName.name + '(' + func.originForm + '* annot' * finalAnnotFlag + ') as ' + out for _ in range(outputVariables.count(out))])
                    else: # non-freeConnex without subset=0?
                        if func.doneFlag:
                            if func.funcName == AggFuncType.AVG:
                                selectName.extend(['SUM(' + out + '/annot' * finalAnnotFlag + ') as ' + out for _ in range(outputVariables.count(out))])
                            elif func.funcName == AggFuncType.COUNT:
                                if finalAnnotFlag:
                                    selectName.extend(['SUM(annot) as ' + out for _ in range(outputVariables.count(out))])
                                else:
                                    selectName.extend(['COUNT(*) as ' + out for _ in range(outputVariables.count(out))])
                            else:
                                selectName.extend([func.funcName.name + '(' + out + ') as ' + out for _ in range(outputVariables.count(out))])
                        else:
                            if func.funcName == AggFuncType.AVG:
                                selectName.extend(['SUM(' + '(' + func.originForm + ')' + '/annot' * finalAnnotFlag + ') as ' + out for _ in range(outputVariables.count(out))])
                            elif func.funcName == AggFuncType.COUNT:
                                if finalAnnotFlag:
                                    selectName.extend(['SUM(annot) as ' + out for _ in range(outputVariables.count(out))])
                                else:
                                    selectName.extend(['COUNT(*) as ' + out for _ in range(outputVariables.count(out))])
                            elif func.funcName == AggFuncType.MIN and func.funcName == AggFuncType.MAX:
                                    selectName.extend([func.funcName.name + '(' + func.originForm + ') as ' + out for _ in range(outputVariables.count(out))])
                            else:
                                selectName.extend([func.funcName.name + '(' + func.originForm + '*annot' * finalAnnotFlag + ') as ' + out for _ in range(outputVariables.count(out))])
                elif out in compKeys:
                    newForm = computations.alias2Comp[out].expr
                    pattern = re.compile('v[0-9]+')
                    inVars = pattern.findall(newForm)
                    for var in inVars:
                        if var in Agg.allAggAlias:
                            func = Agg.alias2AggFunc[var]
                            if JT.isFreeConnex and len(JT.subset):
                                if func.doneFlag: # not use annot
                                    if func.funcName == AggFuncType.AVG:
                                        newForm = newForm.replace(var, func.alias + '/annot' * finalAnnotFlag)
                                    elif func.funcName == AggFuncType.COUNT:
                                        if finalAnnotFlag:
                                            newForm = newForm.replace(var, 'annot')
                                        else:
                                            newForm = newForm.replace(var, '1')
                                    else:
                                        newForm = newForm.replace(var, func.alias)
                                else:
                                    if func.funcName == AggFuncType.AVG:
                                        newForm = newForm.replace(var, '(' + func.originForm + ')' + '/annot' * finalAnnotFlag)
                                    elif func.funcName == AggFuncType.COUNT:
                                        if finalAnnotFlag:
                                            newForm = newForm.replace(var, 'annot')
                                        else:
                                            newForm = newForm.replace(var, '1')
                                    elif func.funcName == AggFuncType.SUM:
                                        newForm = newForm.replace(var, '(' + func.originForm + ')' + '* annot' * finalAnnotFlag)
                                    else:
                                        newForm = newForm.replace(var, '(' + func.originForm + ')')
                            elif not len(JT.subset):
                                if 'CASE' in func.formular:
                                    _, caseCond, caseRes1, caseRes2 = re.split(' WHEN | THEN | ELSE | END', func.originForm)[:-1]
                                    caseCond = caseCond[1:-1]
                                    caseRes1 = caseRes1[1:-1]
                                    if 'caseCond' in lastView.selectAttrAlias:
                                        if func.funcName == AggFuncType.AVG:
                                            newForm = newForm.replace(var, func.funcName.name + '( CASE WHEN caseCond = 1 THEN ' + caseRes1 + '/ annot' * finalAnnotFlag + ' ELSE 0.0 END)')
                                        elif func.funcName == AggFuncType.COUNT:
                                            newForm = newForm.replace(var, 'SUM((CASE WHEN caseCond = 1 THEN 1 ELSE 0.0 END)' + '*annot' * finalAnnotFlag + ')')
                                        elif func.funcName == AggFuncType.SUM:
                                            newForm = newForm.replace(var, func.funcName.name + '( CASE WHEN caseCond = 1 THEN ' + caseRes1 + '* annot' * finalAnnotFlag + ' ELSE 0.0 END)')
                                        else:
                                            newForm = newForm.replace(var, func.funcName.name + '( CASE WHEN caseCond = 1 THEN ' + caseRes1 + ' ELSE 0.0 END)')
                                    elif 'caseRes' in lastView.selectAttrAlias:
                                        if func.funcName == AggFuncType.AVG:
                                            newForm = newForm.replace(var, func.funcName.name + '( CASE WHEN ' + caseCond + ' THEN caseRes ' + '/ annot' * finalAnnotFlag + ' ELSE 0.0 END)')
                                        elif func.funcName == AggFuncType.COUNT:
                                            newForm = newForm.replace(var, func.funcName.name + '( CASE WHEN ' + caseCond + ' THEN caseRes ' + '* annot' * finalAnnotFlag + ' ELSE 0.0 END)')
                                        elif func.funcName == AggFuncType.SUM:
                                            newForm = newForm.replace(var, func.funcName.name + '( CASE WHEN ' + caseCond + ' THEN caseRes ' + '* annot' * finalAnnotFlag + ' ELSE 0.0 END)')
                                        else:
                                            newForm = newForm.replace(var, func.funcName.name + '( CASE WHEN ' + caseCond + ' THEN caseRes ELSE 0.0 END)')
                                    else:
                                        if func.doneFlag:
                                            continue
                                        if func.funcName == AggFuncType.AVG:
                                            newForm = newForm.replace(var, func.funcName.name + '(' + func.originForm + ')')
                                        elif func.funcName == AggFuncType.COUNT:
                                            if finalAnnotFlag:
                                                newForm = newForm.replace(var, 'SUM(' + '(' + func.originForm + ') * annot' + ')')
                                            else:
                                                newForm = newForm.replace(var, 'COUNT(' + func.originForm + ')')
                                        elif func.funcName == AggFuncType.SUM:
                                            newForm = newForm.replace(var, func.funcName.name + '(' + func.originForm + '* annot' * finalAnnotFlag + ')')
                                        else:
                                            newForm = newForm.replace(var, func.funcName.name + '(' + func.originForm + ')')
                                else:
                                    if func.doneFlag:
                                        newForm = newForm.replace(var, func.funcName.name + '(' + func.alias + ')')
                                    else:
                                        if func.funcName == AggFuncType.AVG:
                                            newForm = newForm.replace(var, func.funcName.name + '((' + func.originForm + ')' + '/ annot' * finalAnnotFlag + ')')
                                        elif func.funcName == AggFuncType.COUNT:
                                            if finalAnnotFlag:
                                                newForm = newForm.replace(var, 'SUM(annot)')
                                            else:
                                                newForm = newForm.replace(var, 'COUNT(*)')
                                        elif func.funcName == AggFuncType.SUM:
                                            newForm = newForm.replace(var, func.funcName.name + '((' + func.originForm + ')' + '* annot' * finalAnnotFlag + ')')
                                        else:
                                            newForm = newForm.replace(var, func.funcName.name + '(' + func.originForm + ')')
                            else:
                                if func.doneFlag:
                                    if func.funcName == AggFuncType.AVG:
                                        newForm = newForm.replace(var, 'SUM(' + out + '/annot' * finalAnnotFlag + ') as ')
                                    elif func.funcName == AggFuncType.COUNT:
                                        if finalAnnotFlag:
                                            newForm = newForm.replace(var, 'SUM(annot) as ' + out)
                                        else:
                                            newForm = newForm.replace(var, 'COUNT(*) as ')
                                    else:
                                        newForm = newForm.replace(var, func.funcName.name + '(' + out + ') as ')
                                else:
                                    if func.funcName == AggFuncType.AVG:
                                        newForm = newForm.replace(var, 'SUM(' + '(' + func.originForm + ')' + '/annot' * finalAnnotFlag + ') as ' + out)
                                    elif func.funcName == AggFuncType.COUNT:
                                        if finalAnnotFlag:
                                            newForm = newForm.replace(var, 'SUM(annot) as ' + out)
                                        else:
                                            newForm = newForm.replace(var, 'COUNT(*) as ' + out)
                                    elif func.funcName == AggFuncType.MIN and func.funcName == AggFuncType.MAX:
                                            newForm = newForm.replace(var, func.funcName.name + '(' + func.originForm + ') as ' + out)
                                    else:
                                        newForm = newForm.replace(var, func.funcName.name + '(' + func.originForm + '*annot' * finalAnnotFlag + ') as ' + out)
                    selectName.append(newForm + ' as ' + out)
                else:
                    raise NotImplementedError("Other output variables exists! ")
                
        if globalVar.get_value('GEN_TYPE') == 'Mysql':
            finalResult = 'create or replace view res as select ' + ', '.join(selectName) + ' from ' + fromTable + (' group by ' + ', '.join(Agg.groupByVars) if not JT.isFreeConnex else '') + ';\n'
            for id, alias in enumerate(selectName):
                if 'as' in alias:
                    selectName[id] = alias.split(' as ')[1]
            finalResult += 'select sum(' + '+'.join(selectName) +') from res;\n'
        else:
            finalResult = 'select ' + ','.join(selectName) + ' from ' + fromTable + (' group by ' + ', '.join(Agg.groupByVars) if not JT.isFreeConnex else '') + ';\n'
    else:
        fromTable = lastUp[-1].viewName
        totalName = lastUp[-1].selectAttrAlias
        for out in outputVariables:
            if out in totalName:
                selectName.append(out)
            elif out in compKeys:
                if globalVar.get_value('GEN_TYPE') == 'Mysql':
                    selectName.append(computations.alias2Comp[out] + ' as ' + out)
                else:
                    selectName.append(computations.alias2Comp[out])

        if len(selectName) != len(outputVariables):
            raise RuntimeError("Miss some outputs! ")

        if globalVar.get_value('GEN_TYPE') == 'Mysql':
            if JT.isFull:
                finalResult = 'select sum(' + '+'.join(selectName) +') from ' + fromTable + ';\n'
            else:
                finalResult = 'create or replace view res as select distinct ' + ', '.join(selectName) +' from ' + fromTable + ';\n'
                finalResult += 'select sum(' + '+'.join(selectName) +') from res;\n'
        else:
            finalResult = 'select ' + ('distinct ' if not JT.isFull else '') + ', '.join(selectName) +' from ' + fromTable + ';\n'
    
    semiUp, semiDown, lastUp = columnPruneYa(JT, semiUp, semiDown, lastUp, finalResult, set(outputVariables), Agg, list(COMP.values()))

    return semiUp, semiDown, lastUp, finalResult