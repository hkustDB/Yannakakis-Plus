'''
Aggregation information recording & outside subset view build
'''

from action import *
from reduce import Join2tables

# informaiton about aggregation
class AggFunc():
    def __init__(self, funcName: str, inVars: list[str], alias: str) -> None:
        self.funcName = funcName    # aggregation type: SUM, COUNT, AVG, MIN/MAX
        self.inVars = inVars        # input var alias
        self.alias = alias      # use as alias

class Aggregation:
    def __init__(self, groupByVars: list[str], aggFunc: list[AggFunc]) -> None:
        self.groupByVars = groupByVars
        self.aggFunc = aggFunc
        self.aggFuncCnt = len(aggFunc)
        self.affFuncDoneFlag = [False * self.aggFuncCnt]    # mark whether have done i-th aggregation


# aggregation additional reduce view (outside subset)   
## aggFunc[AggFunc]; aggFunc[i].funcName + '(' + aggFunc[i].inVars +')'
class AggView(Action):
    def __init__(self, viewName: str, selectAttrs: list[str], selectAttrAlias: list[str], fromTable: str, aggFunc: list[AggFunc]) -> None:
        super().__init__(viewName, selectAttrs, selectAttrAlias, fromTable)
        self.aggFunc = aggFunc


'''
joinKey: all join key
alterJoinKey: using() join key
whereCond: joinCond
annotFrom = [] -> one child node, select annot directly; [g1, g2] -> select g1.annot * g2.annot as annot
'''
class AggJoin(Join2tables):
    def __init__(self, viewName: str, selectAttrs: list[str], selectAttrAlias: list[str], fromTable: str, joinTable: str, joinKey: list[str], alterJoinKey: list[str], whereCondList: list[str] = [], annotFrom: list[str] = []) -> None:
        super().__init__(viewName, selectAttrs, selectAttrAlias, fromTable, joinTable, joinKey, alterJoinKey, '', whereCondList)
        self.annotFrom = annotFrom


class AggReducePhase:
    _aggReducePhaseId = 0
    def __init__(self, aggView: AggView, aggJoin: AggJoin) -> None:
        self.aggView = aggView
        self.aggJoin = AggJoin
        self._aggReducePhaseId = AggReducePhase._aggReducePhaseId
        
    @property    
    def _addAggReducePhaseId(self):
        AggReducePhase._aggReducePhaseId += 1
    
