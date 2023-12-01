from treenode import *
from enumsType import *

class Edge:
    _id = 0
    def __init__(self, node1: TreeNode, node2: TreeNode) -> None:
        self.src = node1    # parent
        self.dst = node2    # chilren
        self.id = Edge._id
        self._addId
    
    @property
    def _addId(self): Edge._id += 1
    
    @property
    def getId(self): return self.id
    
    def __str__(self) -> str:
        return self.src.getNodeAlias + str('->') + self.dst.getNodeAlias
    
    def __repr__(self) -> str:
        return "Relation: " + self.src.getNodeAlias + str('->') + self.dst.getNodeAlias
        
class JoinTree:
    def __init__(self, node: dict[int, TreeNode], isFull: bool) -> None:
        self.node: dict[int, TreeNode] = node # id -> TreeNode
        self.edge: dict[int, Edge] = dict()     # id -> (TreeNode1, TreeNode2)
        self.root: TreeNode = None
        self.isFull: bool = isFull
        self.subset: list[TreeNode] = []
        
    def __repr__(self) -> str:
        return str(self.node) + '\n' + str(self.edge) + '\n' + str(self.root) + '\n' + str(self.isFull) + '\n' + str(self.subset)
        
    def __str__(self) -> str:
        ret = str(self.root) + '\n' + str(self.isFull)
        return ret
    
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
        
    def addNode(self, node: TreeNode):
        self.node[node.id] = node
        
    def addSubset(self, nodeId: int):
        self.subset.append(self.node[nodeId])

    
    def addEdge(self, edge: Edge):
        edge.src.children.append(edge.dst)
        edge.dst.parent = edge.src
        self.edge[edge.getId] = edge   
        
    def removeEdge(self, edge: Edge):
        self.edge.pop(edge.getId)
        parent = edge.src
        child = edge.dst
        parent.removeChild(child)