from enumsType import *
from treenode import *
import copy
import re

class Comparison:
    # map from (col, MfType)(e.g. (v1, MIN/MAX)) -> mfId, own by all comparisons
    # helperAttr: dict[tuple[str, MfType], int] = dict()    
    
    def __init__(self) -> None:
        self.id = -1
        self.op = None          # <, >, <=, >=
        self.left = None        # formular on the op left
        self.right = None       # formular on the op right
        self.path = None        # [[1, 2], [2, 4], [4, 3]]
        self.cond = None
        self.predType = None    # Short/Long
        self.beginNodeId = None     # update for each delete path, -1 means no comparison edge undone anymore
        self.endNodeId = None       
        self.originBeginNodeId = None                     # no changing begin
        self.originEndNodeId = None                       # no changing end
        self.originPath = None                            # no deleting path
        self.helperAttr: list[list[str]] = None           # path record of mf name
        self.LCA: int = None
    
    def setAttr(self, id: int, op: str, left: str, right: str, path: list[str], cond: str, fullOp: str):
        # path = ['4<->1', '1<->2', '2<->3', '3<->5']
        self.id = id
        self.op = self.parseOP(op)
        self.left = left # crude left
        self.right = right
        self.cond = cond[1:-1] if cond[0] == '(' and cond[-1] == ')' else cond
        self.fullOp = fullOp
        if left == right:
            if '=' in self.cond:
                self.right = self.cond.split('=')[1]
            elif 'IN' in self.cond:
                self.right = self.cond.split('IN')[1]
            elif '<>' in self.cond:
                self.right = self.cond.split('<>')[1]
        
        if 'true' in fullOp:
            if self.op == ' LIKE ' or self.op == ' IN ':
                self.op = ' NOT' + self.op
            elif self.op == '=':
                self.op = '<>'
        
        if self.op == ' IN ' or self.op == ' LIKE ':
            self.right = self.cond.split(' ', 2)[2]
        elif self.op == ' NOT IN ' or self.op == ' NOT LIKE ':
            self.right = self.cond.split(' ', 3)[3]
        
        path = [[int(i['src']), int(i['dst'])] for i in path]
        
        allNodes = set()
        
        for i in range(len(path)):
            first, second = path[i][0], path[i][1]
            if first in allNodes:
                allNodes.remove(first)
            else:
                allNodes.add(first)
                
            if second in allNodes:
                allNodes.remove(second)
            else:
                allNodes.add(second)
        
        errorFlag = 0
        if len(allNodes) != 2:
            errorFlag = 1
        
        if len(allNodes) != 0:
            begin = allNodes.pop()
            end = allNodes.pop()
        
            newPath = []
            enumNode = begin
        
            while enumNode != end and len(path) > 0:
                beginEdge = [edge for edge in path if enumNode in edge][0]
                path.remove(beginEdge)
                beginEdge = [beginEdge[0], beginEdge[1]] if enumNode == beginEdge[0] else [beginEdge[1], beginEdge[0]]
                newPath.append(beginEdge)
                enumNode = beginEdge[1]
                
        else:
            newPath = path
        
        self.path = newPath
        self.originPath = copy.deepcopy(newPath)
        self.predType = predType.Long if len(newPath) != 1 else predType.Short
        self.predType = predType.Self if self.predType == predType.Short and newPath[0][0] == newPath[0][1] else self.predType
        self.beginNodeId = self.originBeginNodeId = newPath[0][0]
        self.endNodeId = self.originEndNodeId = newPath[len(newPath)-1][1]
        self.helperAttr = [[''] * 2] * len(self.path)
        
        if errorFlag and self.predType != predType.Self:
            raise RuntimeError("Error comparison begin/end node! ")
        
    def parseOP(self, OP: str):
        if 'LessThanOrEqualTo' in OP:
            return '<='
        elif 'LessThan' in OP:
            return '<'
        elif 'GreaterThanOrEqualTo' in OP:
            return '>='
        elif 'GreaterThan' in OP:
            return '>'
        elif 'match' in OP:
            return ' LIKE '
        elif 'stringEqualTo' in OP:
            return '='
        elif 'intEqualTo' in OP:
            return '='
        elif 'stringInLiterals' in OP:
            return ' IN '
        elif 'intInLiterals' in OP:
            return ' IN '
        
        else:
            raise NotImplementedError("Not proper relation! ")

            
    def __str__(self) -> str:
        return str(self.id) + '\n' + str(self.op) + '\n' + str(self.left) + '\n' + str(self.right) + '\n' + str(self.path)
    
    def __repr__(self) -> str:
        return str(self.id) + ', ' + str(self.left) + str(self.op) + str(self.right) + ', Comparison path: ' + str(self.path)
    
    @property
    def getComparisonLength(self):
        return len(self.path)
    
    @property
    def getComparisonId(self):
        return self.id
    
    @property
    def getPredType(self):
        return self.predType
    
    @property
    def getBeginNodeId(self):
        self.beginNodeId = self.path[0][0]
        return self.beginNodeId
    
    @property
    def getEndNodeId(self):
        self.endNodeId = self.path[len(self.path)-1][1]
        return self.endNodeId
    
    def deletePath(self, direction: Direction):
        if len(self.path) < 1:
            raise RuntimeError("Can't delete path! ")
        if direction == Direction.Left:
            self.path.pop(0)
        else: self.path.pop(-1)
        self.predType = predType.Short if len(self.path) == 1 else predType.Long
        self.beginNodeId = self.path[0][0] if len(self.path) != 0 else -1
        self.endNodeId = self.path[len(self.path)-1][1] if len(self.path) != 0 else -1
        
    # NOTE: Only support for aggregation purpose
    def fullDeletePath(self, direction: Direction):
        if len(self.path) < 1:
            raise RuntimeError("Can't update path! ")
        if direction == Direction.Left:
            self.path.pop(0)
            self.originPath.pop(0)
        else:
            self.path.pop(-1)
            self.originPath.pop(-1)
        self.predType = predType.Short if len(self.path) == 1 else predType.Long
        self.beginNodeId = self.path[0][0] if len(self.path) != 0 else -1
        self.endNodeId = self.path[len(self.path)-1][1] if len(self.path) != 0 else -1
        self.originBeginNodeId = self.originPath[0][0] if len(self.originPath) != 0 else -1
        self.originEndNodeId = self.originPath[len(self.originPath)-1][1] if len(self.originPath) != 0 else -1
        self.helperAttr = [[''] * 2] * len(self.path)
        
    def reversePath(self):
        self.path = [[i[1], i[0]] for i in self.path]
        self.path.reverse()
        
        self.originPath = copy.deepcopy(self.path)
        self.beginNodeId = self.originBeginNodeId = self.path[0][0]
        self.endNodeId = self.originEndNodeId = self.path[len(self.path)-1][1]