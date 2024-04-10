from treenode import *
from enumsType import *
from topk import *

class Edge:
    _id = 0
    def __init__(self, node1: TreeNode, node2: TreeNode, keyType: str) -> None:
        self.src = node1    # parent
        self.dst = node2    # chilren
        if keyType == 'child':
            self.keyType = EdgeType.Child
        elif keyType == 'parent':
            self.keyType = EdgeType.Parent
        elif keyType == 'both':
            self.keyType = EdgeType.Both
        else:
            self.keyType = EdgeType.No
        self.id = Edge._id
        self._addId
    
    @property
    def _addId(self): Edge._id += 1
    
    @property
    def getId(self): return self.id
    
    def __str__(self) -> str:
        return str(self.src.id) + str('->') + str(self.dst.id)
    
    def __repr__(self) -> str:
        return str(self.src.id) + str('->') + str(self.dst.id)
    
class JoinTree:
    def __init__(self, node: dict[int, TreeNode], isFull: bool, isFreeConnex: bool, supId: set[int], subset: list[int], extraCondList: ExtraCondList, fixRoot: bool, setSubset0: bool) -> None:
        self.node: dict[int, TreeNode] = node   # id -> TreeNode
        self.edge: dict[int, Edge] = dict()     # id -> (TreeNode1, TreeNode2)
        self.root: TreeNode = None
        self.isFull: bool = isFull
        self.isFreeConnex: bool = isFreeConnex
        self.supId = supId
        self.subset: list[int] = subset if not setSubset0 else []
        self.extraCondList = extraCondList
        self.fixRoot = fixRoot
    
    def __repr__(self) -> str:
        return "Relations:\n" + str(self.node.values()) + "\nEdges:\n" + str(self.edge.values()) + "\nRoot:\n" + str(self.root.id) + "\nisFull:\n" + str(self.isFull) + "\nisFreeConnex:\n" + str(self.isFreeConnex) + "\nsubset:\n" + str(self.subset) + "\nfixroot:\n" + str(self.fixRoot) + "\n"
    
    def __str__(self) -> str:
        return "Relations:\n" + str(self.node.values()) + "\nEdges:\n" + str(self.edge.values()) + "\nRoot:\n" + str(self.root.id) + "\nisFull:\n" + str(self.isFull) + "\nisFreeConnex:\n" + str(self.isFreeConnex) + "\nsubset:\n" + str(self.subset) + "\nfixroot:\n" + str(self.fixRoot) + "\n"
    
    @property
    def getRoot(self): return self.root
        
    def getCol2vars(self, id: int):
        node: TreeNode = self.node[id]
        return node.getcol2vars
    
    def getNodeAlias(self, id: int):
        node: TreeNode = self.node[id]
        return node.getNodeAlias
    
    def getNode(self, id: int) -> TreeNode:
        return self.node[id]
    
    def getRelations(self) -> dict[int, Edge]:
        return self.edge
    
    def findNode(self, id: int):            # test whether already added, nodeId set
        if self.node.get(id, False):
            return True
        else: return False
        
    def setRoot(self, root: TreeNode):
        self.root = root
        
    def setRootById(self, rootId: int):
        self.root = self.node[rootId]
        if self.fixRoot:
            self.subset = [self.root.id]
            self.isFreeConnex = False
        
    def addNode(self, node: TreeNode):
        self.node[node.id] = node
        
    def addSubset(self, nodeId: int):
        self.subset.append(nodeId)
    
    def addEdge(self, edge: Edge):
        edge.src.children.append(edge.dst)
        edge.dst.parent = edge.src
        self.edge[edge.getId] = edge   
        
    def removeEdge(self, edge: Edge):
        self.edge.pop(edge.getId)
        parent = edge.src
        child = edge.dst
        edge.dst.parent = None
        parent.removeChild(edge.dst)