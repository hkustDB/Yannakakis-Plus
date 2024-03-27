from jointree import *
from comparison import *
from enumsType import *
from treenode import *

from aggregation import *
from reduce import *
from enumerate import *
from generateIR import *
from codegen import transSelectData
from columnPrune import columnPrune
from topk import *
import globalVar

from random import choice, randint
from functools import cmp_to_key
from sys import maxsize


def buildAggReducePhase(reduceRel: Edge, JT: JoinTree, Agg: Aggregation, aggFuncList: list[AggFunc] = [], selfComp: list[Comparison] = [], incidentComp: list[Comparison] = [], compExtract: list[Comp] = [], updateDirection: list[Direction] = [], extraEqualCond: list[str] = [], childIsOriLeaf: bool = False) -> AggReducePhase:
    childNode = JT.getNode(reduceRel.dst.id)
    parentNode = JT.getNode(reduceRel.src.id)
    prepareView = []
    aggView = aggJoin = None

    
    childSelfComp = [comp for comp in selfComp if childNode.id == comp.path[0][0]]
    parentSelfComp = [comp for comp in selfComp if parentNode.id == comp.path[0][0]]
    childExtract = [comp for comp in compExtract if comp.isChild]
    parentExtract = [comp for comp in compExtract if not comp.isChild]
    childFlag = childNode.JoinResView is None and childNode.relationType == RelationType.TableScanRelation
    
    # FIXME: Add non-free connex auxiliary bag relation
    
    if childIsOriLeaf and childNode.relationType != RelationType.TableScanRelation:
        ret = buildPrepareView(JT, childNode, childSelfComp, childExtract=childExtract)
        if ret != []: prepareView.extend(ret)
    
    # Step1: create additional view: SPECIAL: not build auxiliary relation for aux, derive from aggView
    if parentNode.relationType != RelationType.TableScanRelation and parentNode.relationType != RelationType.AuxiliaryRelation:
        ret = buildPrepareView(JT, parentNode, parentSelfComp, childExtract=parentExtract)
        if ret != []: prepareView.extend(ret)
    
    # Step2: aggView
    ## a. name, fromTable
    viewName = 'aggView' + str(randint(0, maxsize))
    if childNode.JoinResView:
        fromTable = childNode.JoinResView.viewName
    elif childNode.relationType == RelationType.TableScanRelation:
        fromTable = childNode.source + ' as ' + childNode.alias
    else:
        fromTable = childNode.alias
    
    ## b. Joinkey: No need to distinguish, it must appear in original alias  
    joinKey = list(set(parentNode.cols) & set(childNode.cols))
    
    ## c. select attributes: joinKey, previousAgg, newAgg
    selectAttr, selectAttrAlias  = [], []
    aggPass2Join, groupBy = [], []
    pkFlag = False
    if (reduceRel.keyType == EdgeType.Child or reduceRel.keyType == EdgeType.Both) and childFlag:
        pkFlag = True
    
    if childFlag: # xjoinview & tablescan
        for key in joinKey:
            selectAttrAlias.append(key)
            index = childNode.cols.index(key)
            selectAttr.append(childNode.col2vars[1][index])
            groupBy.append(childNode.col2vars[1][index])
                
        # NOTE: support for EXTRACT
        for comp in childExtract:
            if comp.result in Agg.groupByVars:
                pattern = re.compile('v[0-9]+')
                inVars = pattern.findall(comp.expr)
                for var in inVars:
                    originVar = childNode.col2vars[1][childNode.cols.index(var)]
                    comp.expr.replace(var, originVar)
                selectAttr.append(comp.expr)
                selectAttrAlias.append(comp.result)
                aggPass2Join.append(comp.result)
            else:
                raise NotImplementedError("Only support EXTRACT function in groupBy & appear in output attrs! ")
        for agg in aggFuncList:
            if agg.doneFlag: continue
            passAggAlias = True
            if not len(agg.inVars):
                raise RuntimeError("Should not happen! ")
            elif len(agg.inVars) == 1:
                # can only be inVar name
                aggVar = agg.inVars[0]
                if aggVar in childNode.cols:
                    selectAttrAlias.append(agg.alias)
                    index = childNode.cols.index(aggVar)
                    sourceName = childNode.col2vars[1][index]
                    agg.formular = agg.formular.replace(aggVar, sourceName)
                    if not pkFlag:
                        if agg.funcName != AggFuncType.AVG:
                            selectAttr.append(agg.funcName.name + '(' + agg.formular + ')')
                        else:
                            selectAttr.append('SUM(' + agg.formular + ')')
                    else:
                        selectAttr.append(agg.formular)
                    Agg.alias2AggFunc[agg.alias].doneFlag = True
                    agg.doneFlag = True
            else:
                if 'CASE' in agg.formular:
                    _, caseCond, caseRes1, caseRes2 = re.split(' WHEN | THEN | ELSE | END', agg.formular)[:-1]
                    if not '0.0' in caseRes2:
                        print(caseRes2)
                        raise NotImplementedError("Case aggregation res2 not equal 0.0! ")
                    passAggAlias = False
                    caseCond = caseCond[1:-1]
                    caseRes1 = caseRes1[1:-1]
                    pattern = re.compile('v[0-9]+')
                    condVar = pattern.findall(caseCond)
                    res1Var = pattern.findall(caseRes1)
                    # both cond&res at the same node
                    if condVar[0] in childNode.cols and res1Var[0] in childNode.cols:
                        Agg.alias2AggFunc[agg.alias].doneFlag = True
                        agg.doneFlag = True
                        passAggAlias = True
                        for var in condVar:
                            index = childNode.cols.index(var)
                            originVar = childNode.col2vars[1][index]
                            agg.formular = agg.formular.replace(var, originVar)
                        for var in res1Var:
                            index = childNode.cols.index(var)
                            originVar = childNode.col2vars[1][index]
                            agg.formular = agg.formular.replace(var, originVar)
                        if not pkFlag:
                            if agg.funcName != AggFuncType.AVG:
                                selectAttr.append(agg.funcName.name + '(' + agg.formular + ')')
                            else:
                                selectAttr.append('SUM(' + agg.formular + ')')
                        else:
                            selectAttr.append(agg.formular)
                    # Only support one attr in condition
                    elif condVar[0] in childNode.cols:
                        index = childNode.cols.index(condVar[0])
                        originVar = childNode.col2vars[1][index]
                        # NOTE: cond satisfies -> caseCond=1 else 0
                        selectAttr.append('CASE WHEN ' + caseCond.replace(condVar[0], originVar) + ' THEN 1 ELSE 0 END')
                        selectAttrAlias.append('caseCond')
                        aggPass2Join.append('caseCond')
                    elif res1Var[0] in childNode.cols:
                        for var in res1Var:
                            index = childNode.cols.index(var)
                            originVar = childNode.col2vars[1][index]
                            caseRes1 = caseRes1.replace(var, originVar)
                        selectAttr.append(caseRes1)
                        selectAttrAlias.append('caseRes')
                        aggPass2Join.append('caseRes')
                    else:
                        raise NotImplementedError("Error case! ")
                else:
                    allInOne = True
                    for invar in agg.inVars:
                        if invar not in childNode.cols:
                            allInOne = False
                            break
                    # complex formular in original same node
                    if allInOne:    # can do aggregatiom
                        Agg.alias2AggFunc[agg.alias].doneFlag = True
                        agg.doneFlag = True
                        selectAttrAlias.append(agg.alias)
                        for invar in agg.inVars:
                            index = childNode.cols.index(invar)
                            sourceName = childNode.col2vars[1][index]
                            agg.formular = agg.formular.replace(invar, sourceName)
                        if not pkFlag:
                            if agg.funcName != AggFuncType.AVG:
                                selectAttr.append(agg.funcName.name + agg.formular)
                            else:
                                selectAttr.append('SUM'+ agg.formular)
                        else:
                            selectAttr.append(agg.formular)
                    else:   # FIXME: need to aggregate & pass variables
                        passAggAlias = False
                        for invar in agg.inVars:
                            # pass agg vars may have duplicates
                            if invar in childNode.cols and invar not in selectAttrAlias:
                                index = childNode.cols.index(invar)
                                sourceName = childNode.col2vars[1][index]
                                # NOTE: add aggregate attribute
                                if not pkFlag:
                                    selectAttr.append('SUM(' + sourceName + ')/COUNT(*)')
                                else:
                                    selectAttr.append('SUM(' + sourceName + ')')
                                selectAttrAlias.append(invar)
                                aggPass2Join.append(invar)
            if passAggAlias:
                aggPass2Join.append(agg.alias)
                # Agg.alias2AggFunc[agg.alias].doneFlag = True
                # agg.doneFlag = True
        # FIXME: support for extraCond (process for bag)
        if len(extraEqualCond) == 1:
            eq1, eq2 = extraEqualCond[0][0], extraEqualCond[0][1]
            if eq1 in childNode.cols:
                appData = eq1
            else:
                appData = eq2
            if appData not in selectAttrAlias:
                selectAttr.append(childNode.col2vars[1][childNode.cols.index(appData)])
                selectAttrAlias.append(appData)
            if appData not in aggPass2Join: aggPass2Join.append(appData)
            if appData not in groupBy: groupBy.append(appData)
        elif len(extraEqualCond) != 0:
            raise NotImplementedError("Multiple extraEqualCond! ")
    else:
        ## -1. joinKey
        for key in joinKey:
            selectAttr.append('')
            selectAttrAlias.append(key)
            groupBy.append(key)
        ## -2. previousAgg
        if childNode.JoinResView:
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
        else:   # x joinresview & x tablescan
            for comp in childExtract:
                if comp.result in Agg.groupByVars:
                    selectAttr.append(comp.expr)
                    selectAttrAlias.append(comp.result)
                    aggPass2Join.append(comp.result)
                else:
                    raise NotImplementedError("EXTRACT not in groupBy! ")
        
        ## -3. newAgg -> only new aggAlias need `* annot`
        for agg in aggFuncList:
            if agg.doneFlag: continue
            passAggAlias = True
            if not len(agg.inVars):
                raise RuntimeError("Only count(*) is considered! ")
            elif len(agg.inVars) == 1:
                # inVar or alias
                if childNode.JoinResView:
                    findInVars = childNode.JoinResView.selectAttrAlias
                elif childNode.relationType != RelationType.TableScanRelation:
                    findInVars = childNode.cols
                else:
                    raise NotImplementedError("Must be JoinView/not TS case! ")
                if not childNode.JoinResView:  # not tablescan -> like tableAgg
                    index = childNode.cols.index(agg.inVars[0])
                    sourceName = childNode.col2vars[1][index]
                    agg.formular = agg.formular.replace(agg.inVars[0], sourceName)
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

                    Agg.alias2AggFunc[agg.alias].doneFlag = True
                    agg.doneFlag = True 
                    selectAttrAlias.append(agg.alias)
                else:
                    raise RuntimeError("Must be one name in inVars/aggFunciton alias! ")
            else:
                if childNode.JoinResView:
                    findInVars = childNode.JoinResView.selectAttrAlias
                elif childNode.relationType != RelationType.TableScanRelation:
                    findInVars = childNode.cols
                
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
                                    selectAttr.append('SUM(' + invar + ')/COUNT(*)')
                                else:
                                    selectAttr.append('SUM(' + invar + ')')
                                selectAttrAlias.append(invar)
                                aggPass2Join.append(invar)
            
            if passAggAlias:
                aggPass2Join.append(agg.alias)
                # Agg.alias2AggFunc[agg.alias].doneFlag = True
                # agg.doneFlag = True
                
        # FIXME: extraCond
        if childNode.JoinResView:
            if len(extraEqualCond) == 1:
                eq1, eq2 = extraEqualCond[0][0], extraEqualCond[0][1]
                if eq1 in childNode.JoinResView.selectAttrAlias:
                    appData = eq1
                else:
                    appData = eq2
                if appData not in selectAttrAlias:
                    selectAttr.append('')
                    selectAttrAlias.append(appData)
                if appData not in aggPass2Join: aggPass2Join.append(appData)
                if appData not in groupBy: groupBy.append(appData)
            elif len(extraEqualCond) != 0:
                raise NotImplementedError("Multiple extraEqualCond! ")
        else:
            # FIXME: support for extraCond (process for bag)
            if len(extraEqualCond) == 1:
                eq1, eq2 = extraEqualCond[0][0], extraEqualCond[0][1]
                if eq1 in childNode.cols:
                    appData = eq1
                else:
                    appData = eq2
                if appData not in selectAttrAlias:
                    selectAttr.append(childNode.col2vars[1][childNode.cols.index(appData)])
                    selectAttrAlias.append(appData)
                if appData not in aggPass2Join: aggPass2Join.append(appData)
                if appData not in groupBy: groupBy.append(appData)
            elif len(extraEqualCond) != 0:
                raise NotImplementedError("Multiple extraEqualCond! ")
    
    ## d. append annot
    # NOTE: Extra optimization foe job benchmark
    if globalVar.get_value('DDL_NAME') != 'job.ddl':
        if childFlag and not pkFlag:
            selectAttr.append('COUNT(*)')
            selectAttrAlias.append('annot')
        elif childNode.JoinResView:
            if not 'annot' in childNode.JoinResView.selectAttrAlias and not pkFlag:
                selectAttr.append('COUNT(*)')
                selectAttrAlias.append('annot')
            elif not pkFlag:
                selectAttr.append('SUM(annot)')
                selectAttrAlias.append('annot')
        elif childNode.relationType != RelationType.TableScanRelation and not pkFlag:
            selectAttr.append('COUNT(*)')
            selectAttrAlias.append('annot')
    
    # Extra process for comparison case
    if len(incidentComp):
        if len(incidentComp) == 1:
            if updateDirection[0] == Direction.Left:
                compVar = incidentComp[0].left
            else:
                compVar = incidentComp[0].right
            if childNode.JoinResView and compVar in childNode.JoinResView.selectAttrAlias:
                if compVar not in groupBy: groupBy.append(compVar)
                if compVar not in selectAttrAlias:
                    selectAttr.append('')
                    selectAttrAlias.append(compVar)
                    aggPass2Join.append(compVar)
            elif childNode.relationType != RelationType.TableScanRelation:
                if compVar in childNode.cols:
                    groupBy.append(compVar)
                    if compVar not in selectAttrAlias:
                        selectAttr.append('')
                        selectAttrAlias.append(compVar)
                        aggPass2Join.append(compVar)
            else:
                if compVar in childNode.cols:
                    index = childNode.cols.index(compVar)
                    oriVal = childNode.col2vars[1][index]
                    if oriVal not in groupBy:
                        groupBy.append(oriVal)
                    if oriVal not in selectAttrAlias:
                        selectAttr.append(oriVal)
                        selectAttrAlias.append(compVar)
                        aggPass2Join.append(compVar)
        else:
            raise NotImplementedError("More than one aggregation incident comparison is not implemented! ")

    # Add caseCond, caseRes in groupBy
    if 'caseCond' in selectAttrAlias and 'caseCond' not in groupBy:
        groupBy.append('caseCond')
    if 'caseRes' in selectAttrAlias and 'caseRes' not in groupBy:
        groupBy.append('caseRes')

    if pkFlag:
        groupBy = []
    
    if childNode.JoinResView is None and childNode.relationType == RelationType.TableScanRelation and childIsOriLeaf and len(childSelfComp):
        transSelfCompList = makeSelfComp(childSelfComp, childNode)
        aggView = AggView(viewName, selectAttr, selectAttrAlias, fromTable, groupBy, transSelfCompList)
    else:
        aggView = AggView(viewName, selectAttr, selectAttrAlias, fromTable, groupBy)
    
    # Step3: aggJoin
    ## a. name, fromTable
    viewName = 'aggJoin' + str(randint(0, maxsize))
    if parentNode.relationType != RelationType.AuxiliaryRelation or parentNode.JoinResView:
        if parentNode.JoinResView:
            fromTable = parentNode.JoinResView.viewName
        elif parentNode.relationType == RelationType.TableScanRelation:
            fromTable = parentNode.source + ' as ' + parentNode.alias
        else:
            fromTable = parentNode.alias
    else:
        fromTable = ''
    
    ## b. joinTable
    joinTable = aggView.viewName
    
    ## c. select attributes: original + annot + aggregation from childNode(aggPass2Join)
    selectAttr, selectAttrAlias = [], []
    if parentNode.JoinResView:
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

    elif parentNode.relationType != RelationType.TableScanRelation:
        selectAttrAlias = parentNode.cols.copy()
        for agg in aggPass2Join:
            if agg not in selectAttrAlias: selectAttrAlias.append(agg)
        if not pkFlag: 
            if globalVar.get_value('DDL_NAME') != 'job.ddl':
                selectAttrAlias.append('annot')
    else:
        selectAttr = parentNode.col2vars[1].copy()
        selectAttrAlias = parentNode.cols.copy()
        for agg in aggPass2Join:
            if agg not in selectAttrAlias: 
                selectAttr.append('')
                selectAttrAlias.append(agg)
        if not pkFlag:
            if globalVar.get_value('DDL_NAME') != 'job.ddl':
                selectAttr.append('')
                selectAttrAlias.append('annot')
        for comp in parentExtract:
            if comp.result in Agg.groupByVars:
                pattern = re.compile('v[0-9]+')
                inVars = pattern.findall(comp.expr)
                for var in inVars:
                    originVar = parentNode.col2vars[1][parentNode.cols.index(var)]
                    comp.expr.replace(var, originVar)
                selectAttr.append(comp.expr)
                selectAttrAlias.append(comp.result)
    
    ## d.joinCond
    joinCondList, usingJoinKey = [], []
    for key in joinKey:
        cond = ''
        if parentNode.JoinResView is None and parentNode.relationType == RelationType.TableScanRelation:
            originalName = parentNode.col2vars[1][parentNode.col2vars[0].index(key)]
            cond = parentNode.alias + '.' + originalName + '=' + aggView.viewName + '.' + key
            joinCondList.append(cond)
        else:
            usingJoinKey.append(key)
            
    ## e. Add parent node selfComp
    addiSelfComp = []
    if parentNode.JoinResView is None and (parentNode.relationType == RelationType.TableScanRelation or parentNode.relationType == RelationType.AuxiliaryRelation) and len(parentSelfComp):
        if parentNode.relationType == RelationType.TableScanRelation:
            addiSelfComp = makeSelfComp(parentSelfComp, parentNode)
        else:
            for comp in parentSelfComp:
                addiSelfComp.append(comp.left + comp.op + comp.right)
    
    ## f. Add incident comparison
    if len(incidentComp) > 1:
        raise NotImplementedError("Aggregation has more than 2 incident comparisons! ")
    
    def addComp(node: TreeNode):
        if not node.JoinResView and node.relationType == RelationType.TableScanRelation:
            if childNode.id == incidentComp[0].getBeginNodeId: # parse right
                rightVar, opR = splitLR(incidentComp[0].right)
                for i in range(len(rightVar)):
                    if not 'v' in rightVar[i]: continue
                    index = node.cols.index(rightVar[i])
                    rightVar[i] = node.col2vars[1][index]
                return incidentComp[0].left + incidentComp[0].op + opR.join(rightVar)
            else: # parse left
                leftVar, opL = splitLR(incidentComp[0].left)
                for i in range(len(leftVar)):
                    if not 'v' in leftVar[i]: continue
                    index = node.cols.index(leftVar[i])
                    leftVar[i] = node.col2vars[1][index]
                return opL.join(leftVar) + incidentComp[0].op + incidentComp[0].right
        else:
            return incidentComp[0].cond
    condComp = []
    if len(incidentComp) and ((childNode.id == incidentComp[0].getBeginNodeId and parentNode.id == incidentComp[0].getEndNodeId) or (childNode.id == incidentComp[0].getEndNodeId and parentNode.id == incidentComp[0].getBeginNodeId)):
        condComp.append(addComp(parentNode))
        
    ## g. addExtraEqualCond process:
    extraEqualWhere = []
    if len(extraEqualCond) == 1:
        extraSet = set(extraEqualCond[0])
        if extraSet.issubset(selectAttrAlias):
            if not parentNode.JoinResView and parentNode.relationType == RelationType.TableScanRelation:
                if extraEqualCond[0][0] in parentNode.cols:
                    oriVar = parentNode.col2vars[1][parentNode.cols.index(extraEqualCond[0][0])]
                    extraEqualWhere.append(oriVar + '=' + extraEqualCond[0][1])
                else:
                    oriVar = parentNode.col2vars[1][parentNode.cols.index(extraEqualCond[0][1])]
                    extraEqualWhere.append(extraEqualCond[0][0] + '=' + oriVar)
            else:
                extraEqualWhere.append(extraEqualCond[0][0] + '=' + extraEqualCond[0][1])
    elif len(extraEqualCond) != 0:
        raise NotImplementedError("Multiple extraEqualCond! ")
    if len(selectAttr) and len(selectAttr) != len(selectAttrAlias):
        print(selectAttr)
        print(selectAttrAlias)
        raise RuntimeError("Error aggJOin! ")
    aggJoin = AggJoin(viewName, selectAttr, selectAttrAlias, fromTable, joinTable, joinKey, usingJoinKey, joinCondList + addiSelfComp + condComp + extraEqualWhere)
    if fromTable == '' and len(aggJoin.whereCondList) == 0:
        aggJoin.viewName = aggView.viewName
    aggReduce = AggReducePhase(prepareView, aggView, aggJoin, reduceRel.dst.id)
    return aggReduce


def generateAggIR(JT: JoinTree, COMP: dict[int, Comparison], outputVariables: list[str], computations: CompList, Agg: Aggregation) -> [list[AggReducePhase], list[ReducePhase], list[EnumeratePhase]]:
    jointree = copy.deepcopy(JT)
    allRelations = list(jointree.getRelations().values())
    comparisons = list(COMP.values())
    selfComparisons = [comp for comp in comparisons if comp.getPredType == predType.Self]
    
    aggReduceList: list[AggReducePhase] = []
    reduceList: list[ReducePhase] = []
    enumerateList: list[EnumeratePhase] = []
    
    def getExtraCond(node: TreeNode) -> list[str]:
        res = []
        if not len(JT.extraEqualConditions): return []
        if node.JoinResView:
            satisKeys = set(node.JoinResView.selectAttrAlias)
        else:
            satisKeys = set(node.cols)
        if len(set(satisKeys) & JT.extraEqualSet) != 0:
            for each in JT.extraEqualConditions:
                if len(set(each) & satisKeys):
                    res.append(each)
            return res
        else:
            return []
    
    def getAggRelation(node: TreeNode) -> list[AggFunc]:
        aggs = []
        if node.parent:
            joinKeys = set(node.cols) & set(node.parent.cols)
            if node.JoinResView:
                satisKeys = [alias for alias in node.JoinResView.selectAttrAlias if alias not in joinKeys]
            else:
                satisKeys = [alias for alias in node.cols if alias not in joinKeys]
        else:
            if node.JoinResView:
                satisKeys = node.JoinResView.selectAttrAlias
            else:
                satisKeys = node.cols
        for aggF in Agg.aggFunc:
            if aggF.doneFlag:
                continue
            if len(aggF.inVars) != 0 and set(aggF.inVars).issubset(satisKeys): # no input vars case
                aggs.append(aggF)
            elif len(aggF.inVars) > 1 and len(set(aggF.inVars) & set(satisKeys)) != 0:
                aggs.append(aggF)
        
        aggs.sort(key=lambda agg: agg.funcName.value)
        return aggs
    
    
    def getLeafRelation(relations: list[Edge]) -> list[list[Edge, list[AggFunc]]]:
        # leafRelation = [rel for rel in relations if rel.dst.isLeaf and not rel.dst.isRoot]
        leafRelation = []
        for rel in relations:
            if rel.dst.isLeaf and not rel.dst.isRoot:
                leafRelation.append([rel, getAggRelation(jointree.getNode(rel.dst.id))])
        return leafRelation
    
    def getSupportRelation(relations: list[list[Edge, list[AggFunc]]]) -> list[list[Edge, list[AggFunc]]]:
        supportRelation = []
        
        # case1
        for rel, aggs in relations :
            childNode = rel.dst
            parentNode = rel.src
            if parentNode.relationType == RelationType.AuxiliaryRelation and childNode.id == parentNode.supRelationId:
                supportRelation.append([rel, aggs])
        # case2
        for rel, aggs in relations:
            childNode = rel.dst
            while childNode.id != jointree.root.id:
                if childNode.id in jointree.supId:
                    supportRelation.append([rel, aggs])
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
    
    def updateComprison(compList: list[Comparison], updateDirection: list[Direction]):
        '''Update comparisons'''
        if len(compList) == 0: return
        else:
            for index, update in enumerate(updateDirection):
                if update == Direction.Left:
                    compList[index].fullDeletePath(Direction.Left) # compList reference to comparisons
                elif update == Direction.Right:
                    compList[index].fullDeletePath(Direction.Right)
    
    def updateSelfComparison(compList: list[Comparison]):
        if len(compList) == 0: return
        else:
            for comp in compList:
                comp.deletePath(Direction.Left)
    
    def aggCmp(rel1: list[Edge, list[AggFunc]], rel2: list[Edge, list[AggFunc]]):
        if len(rel1[1]) and len(rel2[1]):
            if rel1[1][0].funcName == AggFuncType.MIN or rel1[1][0].funcName == AggFuncType.MAX:
                return -1
            else: return 1
        elif len(rel1[1]): return -1
        elif len(rel2[1]): return 1
        else: return -1
    
    '''Step1: aggReduce'''
    subsetRel = [rel for rel in allRelations if rel.dst.id in JT.subset and rel.src.id in JT.subset]
    outSetRel = [rel for rel in allRelations if rel not in subsetRel] 
    
    while len(outSetRel) > 0:
        leafRelation = getLeafRelation(outSetRel)
        leafRelation.sort(key=cmp_to_key(aggCmp))
        supportRelation = getSupportRelation(leafRelation)
        # no need to sort supportRelation, done in leafRelation already
        if len(supportRelation):
            rel, aggChild = supportRelation[0]
        else:
            rel, aggChild = leafRelation[0]
        incidentComp = getCompRelation(rel)
        selfComp = getSelfComp(rel)
        compExtract = getCompExtract(rel)
        extraEqual = getExtraCond(jointree.getNode(rel.dst.id))
        updateDirection = []
        aggReduce = None
        if len(incidentComp) == 0:
            aggReduce = buildAggReducePhase(rel, jointree, Agg, aggChild, selfComp, compExtract=compExtract, extraEqualCond=extraEqual, childIsOriLeaf=JT.getNode(rel.dst.id).isLeaf)
        elif len(incidentComp) == 1:
            onlyComp = incidentComp[0]
            corIndex = comparisons.index(onlyComp)
            if rel.dst.id == onlyComp.getBeginNodeId:
                updateDirection.append(Direction.Left)
            elif rel.dst.id == onlyComp.getEndNodeId:
                updateDirection.append(Direction.Right)
            else:
                raise RuntimeError("Should not happen! ")
            aggReduce = buildAggReducePhase(rel, jointree, Agg, aggChild, selfComp, incidentComp=incidentComp, compExtract=compExtract, updateDirection=updateDirection, extraEqualCond=extraEqual, childIsOriLeaf=JT.getNode(rel.dst.id).isLeaf)
            updateComprison(incidentComp, updateDirection)
            comparisons[corIndex] = incidentComp[0]
        else:
            raise NotImplementedError("Not implement case with more than one comparison! ")
        jointree.removeEdge(rel)
        outSetRel.remove(rel)
        # TODO: updateComparison
        updateSelfComparison(selfComp)
        # attach to node
        jointree.getNode(rel.dst.id).reducePhase = aggReduce
        if not 'Join' in aggReduce.aggJoin.viewName:
            jointree.getNode(rel.src.id).JoinResView = aggReduce.aggView
        else:
            jointree.getNode(rel.src.id).JoinResView = aggReduce.aggJoin
        # append
        aggReduceList.append(aggReduce)
    
    '''Step2,3: normal cqc reduce/enumerate'''
    # Special case: one node only, not considering recursive build -> no join, ont use for testing
    if len(JT.edge) == 0:
        selectName = []
        prepareView = []
        
        def getChildSelfComp(childNode: TreeNode) -> list[Comparison]:
            selfComp = [comp for comp in selfComparisons if len(comp.path) and childNode.id == comp.path[0][0]]
            return selfComp
        
        for out in outputVariables:
            if out in Agg.allAggAlias:
                func = Agg.alias2AggFunc[out]
                if len(func.formular) == 0:
                    selectName.append('COUNT(*)')
                    continue
                if JT.root.relationType != RelationType.TableScanRelation:
                    selectName.append(func.funcName.name + '(' + func.formular + ')')
                else:
                    pattern = re.compile('v[0-9]+')
                    inVars = pattern.findall(func.formular)
                    for var in inVars:
                        index = JT.root.cols.index(var)
                        oriname = JT.root.col2vars[1][index]
                        func.formular = func.formular.replace(var, oriname, 1)
                    selectName.append(func.funcName.name + '(' + func.formular + ')') 
            else:
                raise NotImplementedError("compKeys/Other output variables exists! ")
                
        if JT.root.relationType != RelationType.TableScanRelation:
            ret = buildPrepareView(JT, JT.root, getChildSelfComp(JT.root))
            if ret != 0: prepareView.extend(ret)
        
        buildSent = ''
        BEGIN = 'create or replace view '
        for prepare in prepareView:
            if prepare.reduceType == ReduceType.CreateBagView:
                line = BEGIN + prepare.viewName + ' as select ' + transSelectData(prepare.selectAttrs, prepare.selectAttrAlias) + ' from ' + ', '.join(prepare.joinTableList) + ((' where ' + ' and '.join(prepare.whereCondList)) if len(prepare.whereCondList) else '') + ';\n'
            else:   # TableAgg
                line = BEGIN + prepare.viewName + ' as select ' + transSelectData(prepare.selectAttrs, prepare.selectAttrAlias) + ' from ' + prepare.fromTable + ', ' + ', '.join(prepare.joinTableList) + ' where ' + ' and '.join(prepare.whereCondList) + ';\n'
            
            buildSent += line
        if globalVar.get_value('GEN_TYPE') == 'Mysql':
            finalResult = buildSent + 'select sum(' + '+'.join(selectName) + ') from '
        else:
            finalResult = buildSent + 'select ' + ', '.join(selectName) + ' from '
        ## fromTable, whereCond
        if JT.root.relationType == RelationType.TableScanRelation:
            finalResult += JT.root.source
            selfComp = getChildSelfComp(JT.root)
            selfCompSent = []
            if len(selfComp):
                selfCompSent = makeSelfComp(selfComp, JT.root)
                finalResult += ' where ' + ' and '.join(selfCompSent)
        else:
            finalResult += JT.root.alias
        
        finalResult += ';\n'
        return [], [], [], finalResult
    
    # Final select attrs
    # 1. pass the final view alias whether in outpuvars; 
    # 2. pass output not in current select, scan computation
    compKeys = list(computations.allAlias)
    selectName = Agg.groupByVars.copy()
    unDoneOut = [out for out in outputVariables if out not in selectName]
    
    ## a. normal case
    COMP = dict(zip(COMP.keys(), comparisons))
    reduceList, enumerateList = [], []

    finalAnnotFlag = False
    if len(jointree.subset) <= 1:
        lastView = aggReduceList[-1].aggJoin if aggReduceList[-1].aggJoin else aggReduceList[-1].aggView
        finalAnnotFlag = True if 'annot' in lastView.selectAttrAlias else False
    else:
        reduceList, enumerateList, _ = generateIR(jointree, COMP, outputVariables, computations, isAgg=True, Agg=Agg)
        lastView = enumerateList[-1].stageEnd if enumerateList[-1].stageEnd else enumerateList[-1].semiEnumerate
        if len(reduceList) and 'annot' in lastView.selectAttrAlias:
            finalAnnotFlag = True
        elif not len(reduceList) and 'annot' in aggReduceList[-1].aggJoin.selectAttrAlias:
            finalAnnotFlag = True
    
    # FIXME: Recheck the final process part
    selectName = []
    for out in outputVariables:
        if out in Agg.groupByVars:
            selectName.append(out)
        else:
            if out in Agg.allAggAlias:
                func = Agg.alias2AggFunc[out]
                if JT.isFreeConnex and len(jointree.subset): # select a, b, c-done, d*annot-undone from A; group by = a, b
                    if func.doneFlag: # not use annot
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
        finalResult = 'create or replace view res as select ' + ', '.join(selectName) + ' from '
    else:
        finalResult = 'select ' + ','.join(selectName) + ' from '
    
    ## b. subset <= 1 special case
    if len(jointree.subset) <= 1:
        aggReduceList, _, _ = columnPrune(JT, aggReduceList, [], [], finalResult, set(outputVariables), Agg, list(COMP.values()))
        finalResult += aggReduceList[-1].aggJoin.viewName
        if not JT.isFreeConnex:
            finalResult += ' group by ' + ', '.join(Agg.groupByVars)
        finalResult += ';\n'
        if globalVar.get_value('GEN_TYPE') == 'Mysql':
            for id, alias in enumerate(selectName):
                if 'as' in alias:
                    selectName[id] = alias.split(' as ')[1]
            finalResult += 'select sum(' + '+'.join(selectName) + ') from res;' 
        return aggReduceList, [], [], finalResult
        
    # The left undone aggregation is done: 1. [subset > 1] -> final enumeration * annot 2. [subset = 1], done in root
    if len(reduceList):
        fromTable = enumerateList[-1].stageEnd.viewName if enumerateList[-1].stageEnd else enumerateList[-1].semiEnumerate.viewName
    elif not len(reduceList):
        fromTable = aggReduceList[-1].aggJoin.viewName
    # oreder by & limit used for checking answer
    if not JT.isFreeConnex:
        finalResult += fromTable + ' group by ' + ', '.join(Agg.groupByVars) + ';\n'
    else:
        finalResult += fromTable + ';\n'
    if globalVar.get_value('GEN_TYPE') == 'Mysql':
        for id, alias in enumerate(selectName):
            if 'as' in alias:
                selectName[id] = alias.split(' as ')[1]
        finalResult += 'select sum(' + '+'.join(selectName) + ') from res;\n'
    aggReduceList, _, _ = columnPrune(JT, aggReduceList, [], [], finalResult, set(outputVariables), Agg, list(COMP.values()))
    return aggReduceList, reduceList, enumerateList, finalResult
