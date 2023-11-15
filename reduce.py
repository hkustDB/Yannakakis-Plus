from action import Action
from enumsType import *


class CreateBagView(Action):    # use joinTableList only
    def __init__(self, viewName: str, selectAttrs: list[str], selectAttrAlias: list[str], fromTable: int, joinTableList: list[str]) -> None:
        super().__init__(viewName, selectAttrs, selectAttrAlias, fromTable)
        self.joinTableList = joinTableList
        self.reduceType = ReduceType.CreateBagView
        
        
class CreateAuxView(Action):
    def __init__(self, viewName: str, selectAttrs: list[str], selectAttrAlias: list[str], fromTable: int) -> None:
        super().__init__(viewName, selectAttrs, selectAttrAlias, fromTable)
        self.reduceType = ReduceType.CreateAuxView
        
        
class CreateTableAggView(Action):
    def __init__(self, viewName: str, selectAttrs: list[str], selectAttrAlias: list[str], fromTable: int, joinTable: int) -> None:
        super().__init__(viewName, selectAttrs, selectAttrAlias, fromTable)
        self.reduceType = ReduceType.CreateTableAggView

    
class CreateOrderView(Action):
    def __init__(self, viewName: str, selectAttrs: list[str], selectAttrAlias: list[str], fromTable: int, joinKey: list[str], comparisonKey: str, primaryKey: list[str], AESC: bool) -> None:
        super().__init__(viewName, selectAttrs, selectAttrAlias, fromTable)
        self.joinKey = joinKey
        self.comparisonKey = comparisonKey
        self.primaryKey = primaryKey
        self.AESC = AESC
        self.reduceType = ReduceType.CreateOrderView

    
class SelectMinAttr(Action):
    def __init__(self, viewName: str, selectAttrs: list[str], selectAttrAlias: list[str], fromTable: int, whereCond = "rn = 1") -> None:
        super().__init__(viewName, selectAttrs, selectAttrAlias, fromTable)
        self.whereCond = whereCond
        self.reduceType = ReduceType.SelectMinAttr
        
    
class Join2tables(Action):
    def __init__(self, viewName: str, selectAttrs: list[str], selectAttrAlias: list[str], fromTable: int, joinTable: int, joinKey: list[str], whereCond: str) -> None:
        super().__init__(viewName, selectAttrs, selectAttrAlias, fromTable)
        self.joinTable = joinTable
        self.joinKey = joinKey
        self.whereCond = whereCond
        self.reduceType = ReduceType.Join2tables


class ReducePhase:
    _reducePhaseId = 0
    def __init__(self, prepareView: Action, orderView: CreateOrderView, minView: SelectMinAttr, joinView: Join2tables) -> None:
        self.prepareView = prepareView
        self.orderView = orderView
        self.minView = minView
        self.joinView = joinView
        self.reducePhaseId = ReducePhase._reducePhaseId
        self._addPhaseId
        self.corresNodeId: int = -1       # corresponds to nodeId in JoinTree
        self.reduceDirection: Direction = None
        
    @property
    def _addReducePhaseId(self):
        ReducePhase._reducePhaseId += 1
        
    def setCorresNodeId(self, id: int):
        self.corresNodeId = id
        
    def getHelperAttr(self) -> str:
        pass