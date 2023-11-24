from action import Action
from enumsType import *


class CreateSample(Action):
    def __init__(self, viewName: str, selectAttrs: list[str], selectAttrAlias: list[str], fromTable: str) -> None:
        super().__init__(viewName, selectAttrs, selectAttrAlias, fromTable)
        self.enumerateType = EnumerateType.CreateSample
        self.whereCond = "rn" + " % " + str(self._sampleRate) + " = 1"
        
    def __repr__(self) -> str:
        return self.viewName + ' AS SELECT ' + str(self.selectAttrAlias) + ' FROM ' + self.fromTable + ' WHERE ' + self.whereCond
        
        
class SelectMaxRn(Action):
    def __init__(self, viewName: str, selectAttrs: list[str], selectAttrAlias: list[str], fromTable: str, joinTable: str, joinKey: list[str], joinCond: str, whereCond: str, groupCond: list[str]) -> None:
        super().__init__(viewName, selectAttrs, selectAttrAlias, fromTable)
        self.joinTable = joinTable
        self.joinKey = joinKey
        self.joinCond = joinCond
        self.whereCond = whereCond
        self.groupCond = groupCond
        self.enumerateType = EnumerateType.SelectMaxRn

    def __repr__(self) -> str:
        return self.viewName + ' AS SELECT ' + str(self.selectAttrAlias) + ', max(rn) as mrn FROM ' + self.fromTable + ' JOIN ' + self.joinTable + 'using(' + self.joinKey + ') WHERE ' + self.whereCond + ' GROUP BY ' + self.joinKey


class SelectTargetSource(Action):
    def __init__(self, viewName: str, selectAttrs: list[str], selectAttrAlias: list[str], fromTable: str, joinTable: str, joinKey: list[str], joinCond: str = '') -> None:
        super().__init__(viewName, selectAttrs, selectAttrAlias, fromTable)
        self.joinTable = joinTable
        self.joinKey = joinKey
        self.joinCond = joinCond
        self.whereCond = "rn < " + "mrn + " + str(self._sampleRate)
        self.enumerateType = EnumerateType.SelectTargetSource
        
    def __repr__(self) -> str:
        return self.viewName + ' AS SELECT ' + str(self.selectAttrAlias) + ' FROM ' + self.fromTable + ' JOIN ' + self.joinTable + ' using(' + ', '.join(self.joinKey) + ') WHERE ' + self.whereCond
        
        
class StageEnd(Action):
    def __init__(self, viewName: str, selectAttrs: list[str], selectAttrAlias: list[str], fromTable: str, joinTable: str, joinKey: list[str], joinCond: str = '', whereCond: str = '') -> None:
        super().__init__(viewName, selectAttrs, selectAttrAlias, fromTable)
        self.joinTable = joinTable
        self.joinKey = joinKey
        self.joinCond = joinCond
        self.whereCond = whereCond
        self.enumerateType = EnumerateType.StageEnd
    
    # TODO:
    def __repr__(self) -> str:
        return 
    
class SemiEnumerate(Action):
    def __init__(self, viewName: str, selectAttrs: list[str], selectAttrAlias: list[str], fromTable: str, joinTable: str, joinKey: list[str], joinCond: str) -> None:
        super().__init__(viewName, selectAttrs, selectAttrAlias, fromTable)
        self.joinTable = joinTable
        self.joinKey = joinKey
        self.joinCond = joinCond
        self.enumerateType = EnumerateType.SemiEnumerate

class EnumeratePhase:
    _enumeratePhaseId = 0
    def __init__(self, createSample: CreateSample, selectMax: SelectMaxRn, selectTarget: SelectTargetSource, stageEnd: StageEnd, semiEnumerate: SemiEnumerate, corresNodeId: int, enumerateDirection: Direction, phaseType: PhaseType) -> None:
        self.createSample = createSample
        self.selectMax = selectMax
        self.selectTarget = selectTarget
        self.stageEnd = stageEnd
        self.semiEnumerate = semiEnumerate
        self.enumeratePhaseId = EnumeratePhase._enumeratePhaseId
        self._addEnumeratePhaseId
        self.corresNodeId = corresNodeId       # corresponds to nodeId in JoinTree
        self.enumerateDirection = enumerateDirection
        self.phaseType = phaseType

    @property
    def _addEnumeratePhaseId(self):
        EnumeratePhase._enumeratePhaseId += 1

    def setCorresNodeId(self, id: int):
        self.corresNodeId = id
