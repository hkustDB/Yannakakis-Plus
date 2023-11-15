from enumerate import *
from reduce import *
from jointree import *
from comparison import *
from enumsType import *
from random import choice

'''helperAttr: [from, to]'''
# corresNodeId, 
def buildReducePhase(reduceRel: Edge, JT: JoinTree, incidentComp: list[Comparison], direction: Direction, helperAttr: list[str, str] = ['', '']) -> ReducePhase:
    childNode = reduceRel.dst
    parentNode = reduceRel.src
    # 1. Need extra node to create
    extraNode = None
    if childNode.relationType == RelationType.BagRelation:
        extraNode = CreateBagView(childNode.alias, '', childNode.cols, '', childNode.insideId)
        
    elif childNode.relationType == RelationType.AuxiliaryRelation:
        extraNode = CreateAuxView(childNode.alias, '', childNode.cols, childNode.supRelationId)
        
    elif childNode.relationType == RelationType.TableAggRelation:
        extraNode = CreateTableAggView(childNode.alias, childNode.col2vars[1], childNode.cols, childNode.id, childNode.aggRelation)
    
    # 2. 
    
def buildEnumeratePhase(enumerateRel:Edge, subset: list[TreeNode], incidentComp: list[Comparison], prePhase) -> EnumeratePhase:
    pass

def generateIR(JT: JoinTree, COMP: list[Comparison]) -> [list[ReducePhase], list[EnumeratePhase]]:
    jointree = JT
    remainRelations = jointree.getRelations().values()
    comparisons = COMP             
    reduceList: list[ReducePhase] = []
    enumerateList: list[EnumeratePhase] = []
    
    def getLeafRelation(relations: list[Edge]) -> list[Edge]:
        # TODO: Change needs for Complex comparison's two sides
        leafRelation = [rel for rel in relations if rel.dst.isLeaf and not rel.dst.isRoot]
        return leafRelation
        
    def getCompRelation(relation: Edge) -> list[Comparison]:
        corresComp = [comp for comp in comparisons if rel.dst in comp.left or rel.dst in comp.right]
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
        if len(incidentComp) <= 2:
            if len(incidentComp) == 0:  # semijoin only
                retReduce = buildReducePhase(rel, JT, incidentComp, Direction.SemiJoin)
            elif len(incidentComp) == 1:
                if (incidentComp[0].getPredType == predType.Long):
                    if rel.dst == incidentComp[0].getBeginNode:
                        retReduce = buildReducePhase(rel, JT, incidentComp, Direction.Left, [Comparison.helperAttr[rel.dst], ''])
                        updateDirection.append(Direction.Left)
                    elif rel.dst == incidentComp[0].getEndNode:
                        retReduce = buildReducePhase(rel, JT, incidentComp, Direction.Right, ['', Comparison.helperAttr[rel.dst]])
                        updateDirection.append(Direction.Right)
                    else:
                        raise RuntimeError("Should not happen! ")
                else:
                    # short comparison
                    raise NotImplementedError("Need to short comparison!")
            else :
                # use reverseOp to judge the case
                raise NotImplementedError("Need to two incident comparison!")
        else: 
            raise NotImplementedError("Incident more than two comparisons is not implemented! ")
        jointree.removeEdge(rel)
        remainRelations = jointree.getRelations().values()
        updateComprison(incidentComp, updateDirection)
        reduceList.append(retReduce)
            
    # remianRelations == 1
    rel = remainRelations[0]
    incidentComp = getCompRelation(rel)
    if len(incidentComp) <= 2:
        if len(incidentComp) == 0:  # semijoin only
            retReduce = buildReducePhase(rel, JT, incidentComp, Direction.SemiJoin)
        elif len(incidentComp) == 1:
            if (incidentComp[0].getPredType == predType.Short):
                if rel.dst == incidentComp[0].getBeginNode:
                    rightMf = reduceList[-1].getHelperAttr()
                    retReduce = buildReducePhase(rel, JT, incidentComp, Direction.Left, [Comparison.helperAttr[rel.dst], rightMf])
                elif rel.dst == incidentComp[0].getEndNode:
                    leftMf = reduceList[-1].getHelperAttr()
                    retReduce = buildReducePhase(rel, JT, incidentComp, Direction.Right, [leftMf, Comparison.helperAttr[rel.dst]])
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
    
    '''Step2: Enumerate'''
    
    
def codeGen(reduceList: list[ReducePhase], enumerateList: list[EnumeratePhase]):
    pass