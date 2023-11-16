from action import Action
from enumsType import *
from comparison import *

class CreateBagView(Action):    # use joinTableList only
    def __init__(self, viewName: str, selectAttrs: list[str], selectAttrAlias: list[str], fromTable: str, joinTableList: list[str]) -> None:
        super().__init__(viewName, selectAttrs, selectAttrAlias, fromTable)
        self.joinTableList = joinTableList
        self.reduceType = ReduceType.CreateBagView


class CreateAuxView(Action):
    def __init__(self, viewName: str, selectAttrs: list[str], selectAttrAlias: list[str], fromTable: str) -> None:
        super().__init__(viewName, selectAttrs, selectAttrAlias, fromTable)
        self.reduceType = ReduceType.CreateAuxView

'''fromTable: tableScan, joinTableList: internal PK join aggNodes'''
class CreateTableAggView(Action):
    def __init__(self, viewName: str, selectAttrs: list[str], selectAttrAlias: list[str], fromTable: str, joinTableList: list[str]) -> None:
        super().__init__(viewName, selectAttrs, selectAttrAlias, fromTable)
        self.joinTableList = joinTableList
        self.reduceType = ReduceType.CreateTableAggView


class CreateOrderView(Action):
    def __init__(self, viewName: str, selectAttrs: list[str], selectAttrAlias: list[str], fromTable: str, joinKey: list[str], orderKey: list[str], AESC: bool) -> None:
        super().__init__(viewName, selectAttrs, selectAttrAlias, fromTable)
        self.joinKey = joinKey
        self.orderKey = orderKey
        self.AESC = AESC
        self.reduceType = ReduceType.CreateOrderView


class SelectMinAttr(Action):
    def __init__(self, viewName: str, selectAttrs: list[str], selectAttrAlias: list[str], fromTable: str, whereCond = "rn = 1") -> None:
        super().__init__(viewName, selectAttrs, selectAttrAlias, fromTable)
        self.whereCond = whereCond
        self.reduceType = ReduceType.SelectMinAttr

'''
joinKey(using): used for same alias
joinCond(on): Some attributes don't have the same alias yet
'''
class Join2tables(Action):
    def __init__(self, viewName: str, selectAttrs: list[str], selectAttrAlias: list[str], fromTable: str, joinTable: str, joinKey: list[str], joinCond: str = '', whereCond: str = '') -> None:
        super().__init__(viewName, selectAttrs, selectAttrAlias, fromTable)
        self.joinTable = joinTable
        self.joinKey = joinKey
        self.joinCond = joinCond
        self.whereCond = whereCond
        self.reduceType = ReduceType.Join2tables

# TODO: Add semijoin action
class SemiJoin(Action):
    def __init__(self, viewName: str, selectAttrs: list[str], selectAttrAlias: list[str], fromTable: str) -> None:
        super().__init__(viewName, selectAttrs, selectAttrAlias, fromTable)



class ReducePhase:
    _reducePhaseId = 0
    def __init__(self, prepareView: Action, orderView: CreateOrderView, minView: SelectMinAttr, joinView: Join2tables, semiView: SemiJoin, corresNodeId: int, reduceDirection: Direction, phaseType: PhaseType, reduceOp: str, incidentComp: list[Comparison]) -> None:
        self.prepareView = prepareView
        self.orderView = orderView
        self.minView = minView
        self.joinView = joinView
        self.semiView = semiView
        self.reducePhaseId = ReducePhase._reducePhaseId
        self._addPhaseId
        self.corresNodeId: int = corresNodeId       # corresponds to nodeId in JoinTree
        self.reduceDirection: Direction = reduceDirection
        self.PhaseType = phaseType
        self.reduceOp = reduceOp
        self.incidentComp = incidentComp            # attach incident comparison

    @property
    def _addReducePhaseId(self):
        ReducePhase._reducePhaseId += 1

    def setPhaseType(self, type: PhaseType):
        self.PhaseType = type