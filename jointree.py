from treenode import *

class Edge:
    def __init__(self, node1: TreeNode, node2: TreeNode) -> None:
        self.src = node1
        self.dst = node2
        self._id = 0
        self._addId
    
    @property
    def _addId(self): self._id += 1
    
    @property
    def getId(self): return self._id
    
    def __str__(self) -> str:
        return self.src.getNodeAlias + str('->') + self.dst.getNodeAlias
        
class JoinTree:
    def __init__(self, isFull: bool) -> None:
        self.node: dict[int, TreeNode] = dict() # id -> TreeNode
        self.edge: dict[int, Edge] = dict()     # id -> (TreeNode1, TreeNode2)
        self.root: TreeNode = None
        self.isFull: bool = isFull
        self.subset: list[TreeNode] = []
        
    def __repr__(self) -> str:
        return str(self.node) + '\n' + str(self.edge) + '\n' + str(self.root) + '\n' + str(self.isFull) + '\n' + str(self.subset)
        
    def __str__(self) -> str:
        ret = str(self.node) + '\n' + str(self.edge) + '\n' + str(self.root) + '\n' + str(self.isFull) + '\n' + str(self.subset)
        return ret
    
    @property
    def getRoot(self): return self.root
        
    def getCol2vars(self, id: int):
        node: TreeNode = self.node[id]
        return node.getcol2vars
    
    def getNodeAlias(self, id: int):
        node: TreeNode = self.node[id]
        return node.getNodeAlias
    
    def getNode(self, id: int):
        return self.node[id]
    
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