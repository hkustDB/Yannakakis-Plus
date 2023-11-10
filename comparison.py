from enum import Enum

"""
All Comparison left type: SingleVariableExpression, IntPlusIntExpression, LongPlusLongExpression, TimestampPlusIntervalExpression, DoublePlusDoubleExpression, IntTimesIntExpression, LongTimesLongExpression, DoubleTimesDoubleExpression
"""

class LRType(Enum):
    IntPlusIntExpression = 0
    LongPlusLongExpression = 1
    TimestampPlusIntervalExpression = 2
    DoublePlusDoubleExpression = 3
    IntTimesIntExpression = 4
    LongTimesLongExpression = 5
    DoubleTimesDoubleExpression = 6
    
class opType(Enum):
    intLessThan = 0
    longLessThan = 1
    doubleLessThan = 2
    intLessThanOrEqualTo = 3
    longLessThanOrEqualTo = 4
    doubleLessThanOrEqualTo = 5
    intGreaterThan = 6
    longGreaterThan = 7
    doubleGreaterThan = 8
    intGreaterThanOrEqualTo = 9
    longGreaterThanOrEqualTo = 10
    doubleGreaterThanOrEqualTo = 11

class Comparison:
    def __init__(self) -> None:
        self.id = -1
        self.op = None
        self.left = None
        self.right = None
        self.path = None
        
    def setAttr(self, id: int, op: str, left: str, right: str, path: list[str]):
        # path = ['4<->1', '1<->2', '2<->3', '3<->5']
        self.id = id
        self.op = opType[op]
        self.left = left # crude left
        self.right = right
        
        path = [i.split('<->') for i in path]
        path = [[int(i[0]), int(i[1])] for i in path]
        for i in range(len(path)-1):
            first, second = path[i], path[i + 1]
            joint = list(set(first) & set(second))[0]
            firIdx = first.index(joint)
            secIdx = second.index(joint)
            if firIdx != 1: # make them connected with common column
                path[i][0], path[i][1] = path[i][1], path[i][0]
            if secIdx != 0:
                path[i + 1][0], path[i + 1][1] = path[i + 1][1], path[i + 1][0]
        
        self.path = path
        
    def __str__(self) -> str:
        return str(self.id) + '\n' + str(self.op) + '\n' + str(self.left) + '\n' + str(self.right) + '\n' + str(self.path)
        