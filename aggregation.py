'''
Aggregation information recording & outside subset view build
'''

from action import *
from reduce import Join2tables
from enumsType import AggFuncType
from random import randint
from sys import maxsize

# informaiton about aggregation
class AggFunc():
    def __init__(self, funcName: str, inVars: list[str], alias: str, formular: str, srcNodeId: list[int] = []) -> None:
        self.funcName = AggFuncType[funcName]    # aggregation type: SUM, COUNT, AVG, MIN/MAX
        self.inVars = inVars        # input var alias -> [v1, v2]
        self.alias = alias          # use as alias, sum(source_name) as alias -> sum(alias) as alias
        self.formular = formular    # change to its alias
        self.originForm = formular  # v1 * v2 / v1
        self.isChild: bool = True   # mark aggregation relate to child or parent node
        self.doneFlag = False

class Aggregation:
    def __init__(self, groupByVars: list[str], aggFunc: list[AggFunc]) -> None:
        self.groupByVars = groupByVars
        self.aggFunc = aggFunc
        self.aggFuncCnt = len(aggFunc)
        self.alias2AggFunc = self.getAllAggVars()
        self.allAggAlias = list(self.alias2AggFunc.keys())
        
    def getAllAggVars(self) -> dict[str, AggFunc]:
        # FIXME: Change for complex formular
        ret = {}
        for agg in self.aggFunc:
            if agg.alias not in ret:
                ret[agg.alias] = agg
        return ret
    
    def initDoneFlag(self):
        for agg in self.aggFunc:
            agg.doneFlag = False

# aggregation additional reduce view (outside subset)   
## aggFunc[AggFunc]; aggFunc[i].funcName + '(' + aggFunc[i].inVars +')'
class AggView(Action):
    def __init__(self, viewName: str, selectAttrs: list[str], selectAttrAlias: list[str], fromTable: str, groupBy: list[str], selfComp: list[str] = []) -> None:
        super().__init__(viewName, selectAttrs, selectAttrAlias, fromTable)
        self.groupBy = groupBy
        self.selfComp = selfComp
        # self.aggFunc = aggFunc
        
    def __repr__(self) -> str:
        return 'select ' + self.selectAttrs + ' as ' + self.selectAttrAlias + ' from ' + self.fromTable + ' group by ' + self.groupBy


'''
joinKey: all join key
alterJoinKey: using() join key
whereCond: joinCond
annotFrom = [] -> one child node, select annot directly; [g1, g2] -> select g1.annot * g2.annot as annot
'''
class AggJoin(Join2tables):
    def __init__(self, viewName: str, selectAttrs: list[str], selectAttrAlias: list[str], fromTable: str, joinTable: str, joinKey: list[str], alterJoinKey: list[str], whereCondList: list[str] = []) -> None:
        super().__init__(viewName, selectAttrs, selectAttrAlias, fromTable, joinTable, joinKey, alterJoinKey, '', whereCondList)
        # self.annotFrom = annotFrom
        
    def __repr__(self) -> str:
        return 'select ' + self.selectAttrs + ' as ' + self.selectAttrAlias + ' from ' + self.fromTable + ' join ' + self.joinTable +' using(' + ','.join(self.joinKey) + ')'

class AggReducePhase:
    _aggReducePhaseId = 0
    def __init__(self, prepareView: list[Action], aggView: AggView, aggJoin: AggJoin, corresId: int) -> None:
        self.prepareView = prepareView
        self.aggView = aggView
        self.aggJoin = aggJoin
        self.corresId = corresId
        self.aggReducePhaseId = AggReducePhase._aggReducePhaseId
        self._addAggReducePhaseId
        
    @property    
    def _addAggReducePhaseId(self):
        AggReducePhase._aggReducePhaseId += 1
    
