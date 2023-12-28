from action import Action


# Reduce Part
class WithView(Action):
    def __init__(self, viewName: str, selectAttrs: list[str], selectAttrAlias: list[str], fromTable: str, joinTable: str = None, joinKey: list[str] = [], usingJoinKey: list[str] = [], whereCondList: list[str] = [], groupBy: list[str] = [], orderBy: list[str] = [], DESC: bool = False, limit: int = 0) -> None:
        super().__init__(viewName, selectAttrs, selectAttrAlias, fromTable)
        self.joinTable = joinTable
        self.joinKey = joinKey
        self.usingJoinKey = usingJoinKey
        self.whereCondList = whereCondList
        self.groupBy = groupBy
        self.orderBy = orderBy
        self.DESC = DESC
        self.limit = limit

# Enumerate Part
## View with row_number()
class RNView(Action):
    def __init__(self, viewName: str, selectAttrs: list[str], selectAttrAlias: list[str], fromTable: str, partitionBy: list[str], orderBy: list[str], DESC: bool = True) -> None:
        super().__init__(viewName, selectAttrs, selectAttrAlias, fromTable)
        self.partitionBy = partitionBy
        self.orderBy = orderBy
        self.DESC = DESC
        self.selectAttrs += [''] * len(selectAttrAlias) + ['row_number() over (partition by ' + self.partitionBy[0] + ' order by ' + self.orderBy[0] + (' ' + 'DESC' if self.DESC else '') + ')']
        self.selectAttrAlias += ['rnk']

# Rank summary
class EnumRankView:
    def __init__(self, maxView: WithView, truncateView: WithView, finalView: RNView) -> None:
        self.maxView = maxView
        self.truncateView = truncateView
        self.finalView = finalView

## left/right select 
class EnumSelectRN(Action):
    def __init__(self, viewName: str, selectAttrs: list[str], selectAttrAlias: list[str], fromTable: str, rnCond: list[str]) -> None:
        super().__init__(viewName, selectAttrs, selectAttrAlias, fromTable)
        self.rnCond = rnCond

## union
class EnumJoinUnion(WithView):
    def __init__(self, viewName: str, selectAttrs: list[str], selectAttrAlias: list[str], fromTable: str, joinTable: str = None, unionTable: str = None, joinKey: list[str] = [], usingJoinKey: list[str] = [], whereCondList: list[str] = [], groupBy: list[str] = [], orderBy: list[str] = [], DESC: bool = True, limit: int = 1024) -> None:
        super().__init__(viewName, selectAttrs, selectAttrAlias, fromTable, joinTable, joinKey, usingJoinKey, whereCondList, groupBy, orderBy, DESC, limit)
        self.unionTable = unionTable
        
# logK each part summary
class EnumLogLoopView:
    def __init__(self, id: int, levelk_left: EnumSelectRN, levelk_right: EnumSelectRN, levelk_join: EnumJoinUnion) -> None:
        self.id = id
        self.levelk_left = levelk_left
        self.levelk_right = levelk_right
        self.levelk_join = levelk_join
        

# Summary of Reduce & Enum
class LevelKReducePhase:
    _levelKReducePhaseId = 0
    def __init__(self, withView: WithView, afterWithView: WithView, reduceRel) -> None:
        self.aggView = withView
        self.orderView = afterWithView
        self.levelKReducePhaseId = LevelKReducePhase._levelKReducePhaseId
        self._addLevelKReducePhaseId
        self.reduceRel = reduceRel
        
    @property
    def _addLevelKReducePhaseId(self):
        LevelKReducePhase._levelKReducePhaseId += 1


class LevelKEnumPhase:
    _levelKEnumPhaseId = 0
    def __init__(self, rankView: EnumRankView, logkLoop: list[EnumLogLoopView], finalView: Action) -> None:
        self.rankView = rankView
        self.logkLoop = logkLoop
        self.finalView = finalView
        self.levelKEnumPhaseId = LevelKEnumPhase._levelKEnumPhaseId
    
    @property
    def _addLevelKEnumPhaseId(self):
        LevelKEnumPhase._levelKEnumPhaseId += 1
        