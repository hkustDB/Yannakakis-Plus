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
    SingleVariableExpression = 7
    IntervalLiteralExpression = 9 # number, TimeStamp
    

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
    

class predType(Enum):
    Self = 0
    Short = 1
    Long = 2

"""
All relations: TableScanRelation, TableAggRelation, AggregatedRelation, AuxiliaryRelation, BagRelation
"""
class RelationType(Enum):
    TableScanRelation = 0
    TableAggRelation = 1
    AggregatedRelation = 2
    AuxiliaryRelation = 3
    BagRelation = 4


class EnumerateType(Enum):
    CreateSample = 0
    SelectMaxRn = 1
    SelectTargetSource = 2
    StageEnd = 3
    SemiEnumerate = 4
    

class ReduceType(Enum):
    CreateOrderView = 0
    SelectMinAttr = 1
    Join2tables = 2
    CreateBagView = 3
    CreateAuxView = 4
    CreateTableAggView = 5
    CreateSemiJoinView = 6
    CreateBagAuxView = 7
    
class PhaseType(Enum):
    SemiJoin = 0
    CQC = 1
    
'''
JT, COMP should not be changed
'''
class Direction(Enum):
    Left = 0
    Right = 1
    SemiJoin = 2
    
class MfType(Enum):
    MIN = 0
    MAX = 1
    
class AggFuncType(Enum):
    MIN = 0
    MAX = 1
    COUNT = 2
    SUM = 3
    AVG = 4
    
class IRType(Enum):
    Report = 0
    Aggregation = 1
    Level_K = 2
    Product_K = 3
    