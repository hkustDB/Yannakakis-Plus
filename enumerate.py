from action import Action
from enumsType import *


class CreateSample(Action):
    def __init__(self, viewName: str, selectAttrs: list[str], selectAttrAlias: list[str], fromTable: int) -> None:
        super().__init__(viewName, selectAttrs, selectAttrAlias, fromTable)
        self.enumerateType = EnumerateType.CreateSample
        self.whereCond = "rn" + " % " + str(self._sampleRate) + " = 1"
        
class SelectMaxRn(Action):
    def __init__(self, viewName: str, selectAttrs: list[str], selectAttrAlias: list[str], fromTable: int, joinTable: str, joinKey: list[str], whereCond: str) -> None:
        super().__init__(viewName, selectAttrs, selectAttrAlias, fromTable)
        self.joinTable = joinTable
        self.joinKey = joinKey
        self.whereCond = whereCond
        self.enumerateType = EnumerateType.SelectMaxRn
        
class SelectTargetSource(Action):
    def __init__(self, viewName: str, selectAttrs: list[str], selectAttrAlias: list[str], fromTable: int, joinTable: str, joinKey: list[str]) -> None:
        super().__init__(viewName, selectAttrs, selectAttrAlias, fromTable)
        self.joinTable = joinTable
        self.joinKey = joinKey
        self.whereCond = joinTable + ".rn < " + "mrn + " + str(self._sampleRate)
        self.enumerateType = EnumerateType.SelectTargetSource
        
class EnumeratePhase:
    _enumeratePhaseId = 0
    def __init__(self, createSample: CreateSample, selectMax: SelectMaxRn, selectTarget: SelectTargetSource) -> None:
        self.createSample = createSample
        self.selectMax = selectMax
        self.selectTarget = selectTarget
        self.enumeratePhaseId = EnumeratePhase._enumeratePhaseId
        self._addEnumeratePhaseId
        self.corresNodeId = -1       # corresponds to nodeId in JoinTree
        
    @property
    def _addEnumeratePhaseId(self):
        EnumeratePhase._enumeratePhaseId += 1
        
    def setCorresNodeId(self, id: int):
        self.corresNodeId = id
        
        
        