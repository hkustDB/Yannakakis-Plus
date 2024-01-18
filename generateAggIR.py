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

from random import choice, randint
from functools import cmp_to_key
from sys import maxsize


def buildAggReducePhase(reduceRel: Edge, JT: JoinTree, Agg: Aggregation, aggFuncList: list[AggFunc] = [], selfComp: list[Comparison] = [], incidentComp: list[Comparison] = [], compExtract: list[Comp] = [], updateDirection: list[Direction] = [], childIsOriLeaf: bool = False) -> AggReducePhase:
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
    if childFlag: # xjoinview & tablescan
        for key in joinKey:
            selectAttrAlias.append(key)
            index = childNode.cols.index(key)
            selectAttr.append(childNode.col2vars[1][index])
            groupBy.append(childNode.col2vars[1][index])
        # NOTE: here extract all in groupBy
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
                    if agg.funcName != AggFuncType.AVG:
                        selectAttr.append(agg.funcName.name + '(' + agg.formular + ')')
                    else:
                        selectAttr.append('sum(' + agg.formular + ')')
                    agg.doneFlag = True
            else:
                allInOne = True
                for invar in agg.inVars:
                    if invar not in childNode.cols:
                        allInOne = False
                # complex formular in original same node
                if allInOne:    # can do aggregatiom
                    agg.doneFlag = True
                    selectAttrAlias.append(agg.alias)
                    for invar in agg.inVars:
                        index = childNode.cols.index(invar)
                        sourceName = childNode.col2vars[1][index]
                        agg.formular = agg.formular.replace(invar, sourceName)
                    if agg.funcName != AggFuncType.AVG:
                        selectAttr.append(agg.funcName.name + agg.formular)
                    else:
                        selectAttr.append('sum'+ agg.formular)
                else:   # need to pass variables
                    passAggAlias = False
                    for invar in agg.inVars:
                        # pass agg vars may have duplicates
                        if invar in childNode.cols and invar not in selectAttrAlias:
                            index = childNode.cols.index(invar)
                            sourceName = childNode.col2vars[1][index]
                            selectAttr.append(sourceName)
                            selectAttrAlias.append(invar)
                            aggPass2Join.append(invar)
            
            if passAggAlias:
                ## add passing aggregation function name
                aggPass2Join.append(agg.alias)
                ## mark this aggregaiton is done
                agg.doneFlag = True
                # Agg.allAggDoneFlag[Agg.allAggFuncId.index(agg.aggFuncId)] = True
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
                    if Agg.alias2AggFunc[var].funcName != AggFuncType.AVG:
                        selectAttr.append(Agg.alias2AggFunc[var].funcName.name + '(' + var + ')')
                    else:
                        selectAttr.append('sum(' + var + ')')
                    selectAttrAlias.append(var)
                    aggPass2Join.append(var)
        else:   # x joinresview & x tablescan
            for comp in childExtract:
                if comp.result in Agg.groupByVars:
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
                    if childNode.JoinResView and 'annot' in findInVars:
                        # FIXME: why replace
                        if agg.funcName == AggFuncType.SUM:
                            selectAttr.append(agg.funcName.name + '(' + agg.formular + ' * annot' + ')')
                        elif agg.funcName == AggFuncType.AVG:
                            selectAttr.append('sum(' + agg.formular + ' * annot' + ')')
                        elif agg.funcName == AggFuncType.COUNT:
                            selectAttr.append(agg.funcName.name + '(' + agg.formular+ ' * annot' + ')' )
                        else:
                            # MIN/MAX
                            selectAttr.append(agg.funcName.name + '(' + agg.formular + ')')
                    else:
                        selectAttr.append(agg.funcName.name + '(' + agg.formular + ')')
                    selectAttrAlias.append(agg.alias)
                else:
                    raise RuntimeError("Must be one name in inVars/aggFunciton alias! ")
                agg.doneFlag = True
            else:
                if childNode.JoinResView:
                    findInVars = childNode.JoinResView.selectAttrAlias
                elif childNode.relationType != RelationType.TableScanRelation:
                    findInVars = childNode.cols
                allInOne = True
                for invar in agg.inVars:
                    if invar not in findInVars:
                        allInOne = False
                if allInOne:
                    agg.doneFlag = True
                    selectAttrAlias.append(agg.alias)
                    if childNode.JoinResView and 'annot' in findInVars:
                        if agg.funcName == AggFuncType.SUM:
                            selectAttr.append(agg.funcName.name + '(' + agg.formular + ' * annot' + ')')
                        elif agg.funcName == AggFuncType.AVG:
                            selectAttr.append('sum' + '(' + agg.formular + ' * annot' + ')')
                        elif agg.funcName == AggFuncType.COUNT:
                            selectAttr.append(agg.funcName.name + '(' + agg.formular + ' * annot' + ')')
                        else:
                            # MIN/MAX
                            selectAttr.append(agg.funcName.name + agg.formular)
                    else:
                        selectAttr.append(agg.funcName.name + agg.formular)
                else:   # need to pass variables
                    passAggAlias = False
                    for invar in agg.inVars:
                        # pass agg vars may have duplicates
                        if invar in findInVars and invar not in selectAttrAlias:
                            selectAttrAlias.append(invar)
                            aggPass2Join.append(invar)
            
            if passAggAlias:
                ## add passing aggregation function name
                aggPass2Join.append(agg.alias)
                ## mark this aggregaiton is done
                agg.doneFlag = True
                # Agg.allAggDoneFlag[Agg.allAggFuncId.index(agg.aggFuncId)] = True
    
    ## d. append annot
    if childFlag:
        selectAttr.append('COUNT(*)')
        selectAttrAlias.append('annot')
    elif childNode.JoinResView:
        if not 'annot' in childNode.JoinResView.selectAttrAlias:
            selectAttr.append('COUNT(*)')
            selectAttrAlias.append('annot')
        else:
            selectAttr.append('SUM(annot)')
            selectAttrAlias.append('annot')
    elif childNode.relationType != RelationType.TableScanRelation:
        selectAttr.append('COUNT(*)')
        selectAttrAlias.append('annot')
    else:
        raise RuntimeError("Error Case! ")
    
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
        if 'annot' in selectAttrAlias:
            # update annotation
            selectAttr.extend(['' for _ in range(len(selectAttrAlias))])
            index = selectAttrAlias.index('annot')
            mulAnnot = parentNode.JoinResView.viewName + '.annot * ' + joinTable + '.annot'
            selectAttr[index] = mulAnnot
            selectAttrAlias[index] = 'annot'
            # original aggregation
            for index, val in enumerate(selectAttrAlias):
                if val in Agg.allAggAlias:
                    selectAttr[index] = val + '*' + aggView.viewName + '.annot'
                    selectAttrAlias[index] = val
            # new aggregation & pass on aggregation variables
            for agg in aggPass2Join:
                if agg in Agg.allAggAlias:
                    # aggregation function
                    selectAttr.append(agg + ' * ' + parentNode.JoinResView.viewName + '.annot')
                    selectAttrAlias.append(agg)
                else:
                    # just pass on alias for later aggregation
                    selectAttr.append('')
                    selectAttrAlias.append(agg)
                    
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
                leftVar, opL = splitLR(incidentComp[0].right)
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
    
    aggJoin = AggJoin(viewName, selectAttr, selectAttrAlias, fromTable, joinTable, joinKey, usingJoinKey, joinCondList + addiSelfComp + condComp)
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
    
    # FIXME: match with generateIR
    def getAggRelation(relation: Edge) -> list[AggFunc]:
        aggs = []
        joinKey = set(relation.dst.cols) & set(relation.src.cols)
        childNode = jointree.getNode(relation.dst.id)
        # In case some attributes is not in the original same node
        if childNode.JoinResView:
            satisKey = [col for col in childNode.JoinResView.selectAttrAlias if col not in joinKey]
        else:
            satisKey = [col for col in childNode.cols if col not in joinKey]
        
        for index, aggF in enumerate(Agg.aggFunc):
            if aggF.doneFlag:
                continue
            if len(aggF.inVars) == 0 and aggF.alias in satisKey: # no input vars case
                # aggF.doneFlag = True
                aggs.append(aggF)
            elif len(aggF.inVars) == 1 and aggF.inVars[0] in satisKey:
                # aggF.doneFlag = True
                aggs.append(aggF)
            elif len(aggF.inVars) > 1:  # mark true during the process, cauase here is hard to determine 
                for invar in aggF.inVars:
                    if invar in satisKey: # aggregation related, need to more judgement to pass or aggregate
                        aggs.append(aggF)
                        break
        
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
    
    def getCompExtract(relation: Edge) -> list[Comp]:
        parentCols = set(relation.src.cols)
        childCols = set(relation.dst.cols)
        ret: list[Comp] = []
        for alias, vars in computations.alias2Var.items():
            if vars in parentCols or vars in childCols:
                if computations.alias2Comp[alias].isExtract:
                    computations.alias2Comp[alias].isChild = vars in childCols
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
            rel, aggs = supportRelation[0]
        else:
            rel, aggs = leafRelation[0]
        incidentComp = getCompRelation(rel)
        selfComp = getSelfComp(rel)
        compExtract = getCompExtract(rel)
        updateDirection = []
        aggReduce = None
        if len(incidentComp) == 0:
            aggReduce = buildAggReducePhase(rel, jointree, Agg, aggs, selfComp, compExtract=compExtract, childIsOriLeaf=JT.getNode(rel.dst.id).isLeaf)
        elif len(incidentComp) == 1:
            onlyComp = incidentComp[0]
            corIndex = comparisons.index(onlyComp)
            if rel.dst.id == onlyComp.getBeginNodeId:
                updateDirection.append(Direction.Left)
            elif rel.dst.id == onlyComp.getEndNodeId:
                updateDirection.append(Direction.Right)
            else:
                raise RuntimeError("Should not happen! ")
            aggReduce = buildAggReducePhase(rel, jointree, Agg, aggs, selfComp, incidentComp=incidentComp, compExtract=compExtract, updateDirection=updateDirection, childIsOriLeaf=JT.getNode(rel.dst.id).isLeaf)
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
        
        for func in Agg.aggFunc:
            if JT.root.relationType != RelationType.TableScanRelation:
                selectName.append(func.funcName.name + func.formular)
            else:
                pattern = re.compile('v[0-9]+')
                inVars = pattern.findall(func.formular)
                for var in inVars:
                    index = JT.root.cols.index(var)
                    oriname = JT.root.col2vars[1][index]
                    func.formular = func.formular.replace(var, oriname, 1)
                selectName.append(func.funcName.name + func.formular)
                
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
        if buildSent != '':
            buildSent = '# 0. Prepare\n' + buildSent
        finalResult = buildSent + 'select ' + '+'.join(selectName) + ' from '
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
    
    for out in unDoneOut:
        if out in Agg.allAggAlias:
            func = Agg.alias2AggFunc[out]
            if func.funcName != AggFuncType.AVG:
                selectName.extend([out for _ in range(outputVariables.count(out))])
            else:
                selectName.extend([out + '/annot as ' + out for _ in range(outputVariables.count(out))])
        elif out in compKeys:
            newForm = computations.alias2Comp[out]
            pattern = re.compile('v[0-9]+')
            inVars = pattern.findall(newForm)
            for var in inVars:
                if var in Agg.allAggAlias:
                    func = Agg.alias2AggFunc[var]
                    if func.funcName != AggFuncType.AVG:
                        newForm = newForm.replace(var, func.alias )
                    else:
                        newForm = newForm.replace(var, func.alias + '/annot')
            
            selectName.append(newForm + ' as ' + out)
        else:
            raise NotImplementedError("Other output variables exists! ")
    
    finalResult = 'select ' + ','.join(selectName) + ' from '
    
    ## a. subset = 1 special case
    if len(jointree.subset) == 1:
        aggReduceList, _, _ = columnPrune(JT, aggReduceList, [], [], finalResult, set(outputVariables), Agg, list(COMP.values()))
        finalResult += aggReduceList[-1].aggJoin.viewName + ';\n'
        return aggReduceList, [], [], finalResult
    
    ## b. normal case
    COMP = dict(zip(COMP.keys(), comparisons))
    reduceList, enumerateList, _ = generateIR(jointree, COMP, outputVariables, computations, isAgg=True, Agg=Agg)
    
    # The left undone aggregation is done: 1. [subset > 1] -> final enumeration * annot 2. [subset = 1], done in root
    if len(reduceList):
        fromTable = enumerateList[-1].stageEnd.viewName if enumerateList[-1].stageEnd else enumerateList[-1].semiEnumerate.viewName
    elif not len(reduceList):
        fromTable = aggReduceList[-1].aggJoin.viewName
    # oreder by & limit used for checking answer
    finalResult += fromTable + ';\n'
    aggReduceList, _, _ = columnPrune(JT, aggReduceList, [], [], finalResult, set(outputVariables), Agg, list(COMP.values()))
    return aggReduceList, reduceList, enumerateList, finalResult
