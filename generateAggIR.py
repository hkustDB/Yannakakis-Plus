from jointree import *
from comparison import *
from enumsType import *

from aggregation import *
from reduce import *
from enumerate import *
from generateIR import *

from random import choice, randint
from functools import cmp_to_key
from sys import maxsize


def buildAggReducePhase(reduceRel: Edge, JT: JoinTree, Agg: Aggregation, aggFuncList: list[AggFunc] = []) -> AggReducePhase:
    childNode = JT.getNode(reduceRel.dst.id)
    parentNode = JT.getNode(reduceRel.src.id)
    prepareView = []
    aggView = aggJoin = None
    
    childFlag = childNode.JoinResView is None and childNode.relationType == RelationType.TableScanRelation
    
    # TODO: Add non-free connex auxiliary bag relation
    
    if childNode.isLeaf and childNode.relationType != RelationType.TableScanRelation:
        ret = buildPrepareView(JT, childNode)
        if ret != []: prepareView.extend(ret)
    
    # Step1: create additional view: SPECIAL: not build auxiliary relation for aux, derive from aggView
    if parentNode.relationType != RelationType.TableScanRelation:
        if parentNode.relationType != RelationType.AuxiliaryRelation:
            ret = buildPrepareView(JT, parentNode)
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
    if childFlag:
        for key in joinKey:
            selectAttrAlias.append(key)
            index = childNode.cols.index(key)
            selectAttr.append(childNode.col2vars[1][index])
            groupBy.append(childNode.col2vars[1][index])
        for agg in aggFuncList:
            if not len(agg.inVars):
                raise RuntimeError("Should not happen! ")
            elif len(agg.inVars) == 1:
                # can only be inVar name
                aggVar = agg.inVars[0]
                if aggVar in childNode.cols and aggVar not in joinKey:
                    selectAttrAlias.append(agg.alias)
                    index = childNode.cols.index(aggVar)
                    sourceName = childNode.col2vars[1][index]
                    if agg.funcName != AggFuncType.AVG:
                        selectAttr.append(agg.funcName.name + '(' + sourceName + ')')
                    else:
                        selectAttr.append('sum(' + sourceName + ')')
            else:
                raise NotImplementedError("Not implement multiple vars in aggregation function case! ")
            ## add passing aggregation function name
            aggPass2Join.append(agg.alias)
            ## mark this aggregaiton is done
            Agg.allAggDoneFlag[Agg.allAggFuncId.index(agg.aggFuncId)] = True
    else:
        ## -1. joinKey
        for key in joinKey:
            selectAttr.append('')
            selectAttrAlias.append(key)
            groupBy.append(key)
        
        ## -2. previousAgg
        if childNode.JoinResView:
            for var in childNode.JoinResView.selectAttrAlias:
                if var in Agg.allAggVars:
                    if Agg.alias2AggFunc[var].funcName != AggFuncType.AVG:
                        selectAttr.append(Agg.alias2AggFunc[var].funcName.name + '(' + var + ')')
                    else:
                        selectAttr.append('sum(' + var + ')')
                    selectAttrAlias.append(var)
                    aggPass2Join.append(var)
        
        ## -3. newAgg
        for agg in aggFuncList:
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
            
                if agg.inVars[0] in findInVars:
                    if childNode.JoinResView and 'annot' in findInVars:
                        if agg.funcName == AggFuncType.SUM:
                            selectAttr.append(agg.funcName.name + '(' + agg.inVars[0] + ' * annot' + ')')
                        elif agg.funcName == AggFuncType.AVG:
                            selectAttr.append('sum(' + agg.inVars[0] + ' * annot' + ')')
                        elif agg.funcName == AggFuncType.COUNT:
                            selectAttr.append(agg.funcName.name + '(' + agg.inVars[0] + ')' + ' * annot')
                        else:
                            # MIN/MAX
                            selectAttr.append(agg.funcName.name + '(' + agg.inVars[0] + ')')
                    else:
                        selectAttr.append(agg.funcName.name + '(' + agg.inVars[0] + ')')
                    selectAttrAlias.append(agg.alias)
                elif agg.alias in findInVars:
                    if childNode.JoinResView and 'annot' in findInVars:
                        if agg.funcName == AggFuncType.SUM:
                            selectAttr.append(agg.funcName.name + '(' + agg.alias + ' * annot' + ')')
                        elif agg.funcName == AggFuncType.AVG:
                            selectAttr.append('sum(' + agg.alias + ' * annot' + ')')
                        elif agg.funcName == AggFuncType.COUNT:
                            selectAttr.append(agg.funcName.name + '(' + agg.alias + ')' + ' * annot')
                        else:
                            # MIN/MAX
                            selectAttr.append(agg.funcName.name + '(' + agg.alias + ')')
                    else:
                        selectAttr.append(agg.funcName.name + '(' + agg.alias + ')')
                    selectAttrAlias.append(agg.alias)
                else:
                    raise RuntimeError("Must be one name in inVars/aggFunciton alias! ")
            else:
                raise NotImplementedError("Not implement multiple vars in aggregation function case! ")
            
            ## add passing aggregation function name
            aggPass2Join.append(agg.alias)
            ## mark this aggregaiton is done
            Agg.allAggDoneFlag[Agg.allAggFuncId.index(agg.aggFuncId)] = True
    
    ## d. append annot
    if childFlag:
        selectAttr.append('count(*)')
        selectAttrAlias.append('annot')
    elif childNode.JoinResView:
        if not 'annot' in childNode.JoinResView.selectAttrAlias:
            selectAttr.append('count(*)')
            selectAttrAlias.append('annot')
        else:
            selectAttr.append('sum(annot)')
            selectAttrAlias.append('annot')
    elif childNode.relationType != RelationType.TableScanRelation:
        selectAttr.append('count(*)')
        selectAttrAlias.append('annot')
    else:
        raise RuntimeError("Error Case! ")
        
        
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
        if 'annot' in selectAttrAlias:
            # update annotation
            selectAttr.extend(['' for _ in range(len(selectAttrAlias))])
            index = selectAttrAlias.index('annot')
            mulAnnot = parentNode.JoinResView.viewName + '.annot * ' + joinTable + '.annot'
            selectAttr[index] = mulAnnot
            selectAttrAlias[index] = 'annot'
            # original aggregation
            for index, val in enumerate(selectAttrAlias):
                if val in Agg.allAggVars:
                    selectAttr[index] = val + '*' + aggView.viewName + '.annot'
                    selectAttrAlias[index] = val
            # new aggregation
            selectAttr.extend([agg + ' * ' + parentNode.JoinResView.viewName + '.annot' for agg in aggPass2Join])
            selectAttrAlias.extend([agg for agg in aggPass2Join])
        else:
            selectAttrAlias.append('annot')
    elif parentNode.relationType != RelationType.TableScanRelation:
        selectAttrAlias = parentNode.cols.copy()
        selectAttrAlias.extend(aggPass2Join)
        selectAttrAlias.append('annot')
    else:
        selectAttr = parentNode.col2vars[1].copy()
        selectAttrAlias = parentNode.cols.copy()
        # selectAttr.append('')
        selectAttr.extend(['' for _ in range(len(aggPass2Join) + 1)])
        selectAttrAlias.extend(aggPass2Join)
        selectAttrAlias.append('annot')
    
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
    
    aggJoin = AggJoin(viewName, selectAttr, selectAttrAlias, fromTable, joinTable, joinKey, usingJoinKey, joinCondList)
    aggReduce = AggReducePhase(prepareView, aggView, aggJoin)
    return aggReduce

def buildAggCompReducePhase(reducerel: Edge, JT: JoinTree, aggFuncList: list[AggFunc] = [], incidentComp: list[Comparison] = [], selfComp: list[Comparison] = [], direction: Direction = Direction.SemiJoin, helperLeft: list[str, str] = ['', ''], helperRight: list[str, str] = ['', ''], lastRel: bool = False) -> AggReducePhase:
    pass    


def generateAggIR(JT: JoinTree, COMP: dict[int, Comparison], outputVariables: list[str], Agg: Aggregation) -> [list[AggReducePhase], list[ReducePhase], list[EnumeratePhase]]:
    jointree = copy.deepcopy(JT)
    allRelations = jointree.getRelations().values()
    comparisons = list(COMP.values())
    selfComparisons = [comp for comp in comparisons if comp.getPredType == predType.Self]
    
    aggReduceList: list[AggReducePhase] = []
    reduceList: list[ReducePhase] = []
    enumerateList: list[EnumeratePhase] = []
    
    '''Get incident aggregation (x joinkey related)'''
    def getAggRelation(relation: Edge) -> list[AggFunc]:
        aggs = []
        joinKey = set(relation.dst.cols) & set(relation.src.cols)
        satisKey = [col for col in relation.dst.cols if col not in joinKey]
        for aggF in Agg.aggFunc:
            # FIXME: Way to find intersection is not applied for complex form, may use sepAlias
            if set(satisKey) & (set(aggF.inVars) | set(aggF.alias)):
                aggs.append(aggF)
        
        aggs.sort(key=lambda agg: agg.funcName.value)
        
        return aggs
    
    def getLeafRelation(relations: list[Edge]) -> list[list[Edge, list[AggFunc]]]:
        # leafRelation = [rel for rel in relations if rel.dst.isLeaf and not rel.dst.isRoot]
        leafRelation = []
        for rel in relations:
            if rel.dst.isLeaf and not rel.dst.isRoot:
                leafRelation.append([rel, getAggRelation(rel)])
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
            rel, aggs = supportRelation[0]
        else:
            rel, aggs = leafRelation[0]
        incidentComp = getCompRelation(rel)
        selfComp = getSelfComp(rel)
        updateDirection = []
        aggReduce = None
        if len(incidentComp) == 0:
            aggReduce = buildAggReducePhase(rel, jointree, Agg, aggs)
        else:
            raise NotImplementedError("Not implement case with comparisons! ")
        jointree.removeEdge(rel)
        outSetRel.remove(rel)
        # TODO: updateComparison
        jointree.getNode(rel.dst.id).reducePhase = aggReduce
        jointree.getNode(rel.src.id).JoinResView = aggReduce.aggJoin
        # append
        aggReduceList.append(aggReduce)
    
    '''Step2,3: normal cqc reduce/enumerate'''
    ## Subset Internal aggregaiton alias casting form
    allAggDoneflag = True
    for flag in Agg.allAggDoneFlag:
        allAggDoneflag = allAggDoneflag and flag 
    if not allAggDoneflag:
        selectName = Agg.groupByVars.copy()
        for index, func in enumerate(Agg.aggFunc):
            if Agg.allAggDoneFlag[index]:
                if func.funcName != AggFuncType.AVG:
                    selectName.extend([func.alias for _ in range(outputVariables.count(func.alias))])
                else:
                    selectName.extend([func.alias + '/annot as ' + func.alias for _ in range(outputVariables.count(func.alias))])
            else:
                # FIXME: Need to change for complex formular
                ## The form of count(*) 
                if func.formular == '' and not len(func.inVars):
                    selectName.extend(['annot as ' + func.alias for _ in range(outputVariables.count(func.alias))])
                elif func.funcName != AggFuncType.AVG:
                    selectName.extend([func.formular + '*annot as ' + func.alias for _ in range(outputVariables.count(func.alias))])
                else:
                    selectName.extend([func.formular + ' as ' + func.alias for _ in range(outputVariables.count(func.alias))])
    else:
        selectName = [var for var in outputVariables if var in Agg.groupByVars]
        for var in outputVariables:
            if var not in selectName:
                if Agg.alias2AggFunc[var].funcName != AggFuncType.AVG:
                    selectName.append(var)
                else:
                    selectName.append(var + '/annot as ' + var)
    finalResult = 'select ' + ', '.join(selectName) + ' from '
    
    ## a. subset = 1 special case
    if len(jointree.subset) == 1:
        finalResult += aggReduceList[-1].aggJoin.viewName + ' order by ' + ', '.join(Agg.groupByVars) + ' limit 10 ' + ';\n'
        return aggReduceList, [], [], finalResult
    
    ## b. normal case
    reduceList, enumerateList, _ = generateIR(jointree, COMP, outputVariables, isAgg=True, allAggVars=Agg.allAggVars)
    
    # The left undone aggregation is done: 1. [subset > 1] -> final enumeration * annot 2. [subset = 1], done in root
    
    if len(reduceList):
        fromTable = enumerateList[-1].stageEnd.viewName if enumerateList[-1].stageEnd else enumerateList[-1].semiEnumerate.viewName
    elif not len(reduceList):
        fromTable = aggReduceList[-1].aggJoin.viewName
    # oreder by & limit used for checking answer
    finalResult += fromTable + ' order by ' + ', '.join(Agg.groupByVars) + ' limit 10 ' + ';\n'
        
    return aggReduceList, reduceList, enumerateList, finalResult
