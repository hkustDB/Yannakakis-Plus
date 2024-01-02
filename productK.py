from action import Action
from levelK import WithView

# Reduce Part
class ProductKReducePhase:
    _productKReducePhaseId = 0
    def __init__(self, leafExtra: Action, aggMax: Action, joinRes: WithView, groupBy: list[str], reduceRel) -> None:
        self.leafExtra = leafExtra
        self.aggMax = aggMax
        self.joinRes = joinRes
        self.groupBy = groupBy
        self.reduceRel = reduceRel
        self.productKReducePhaseId = ProductKReducePhase._productKReducePhaseId
        self._addProductKReducePhaseId
        
    @property
    def _addProductKReducePhaseId(self):
        ProductKReducePhase._productKReducePhaseId += 1
    

# Enumerate Part
class ProductKEnumPhase:
    _productKEnumPhaseId = 0
    def __init__(self, aggMax: Action, pruneJoin: WithView, joinRes: WithView, groupBy: list[str]) -> None:
        self.aggMax = aggMax
        self.pruneJoin = pruneJoin
        self.joinRes = joinRes
        self.groupBy = groupBy
        self.productKEnumPhaseId = ProductKEnumPhase._productKEnumPhaseId
        self._addProductKEnumPhase
        
    @property
    def _addProductKEnumPhase(self):
        ProductKEnumPhase._productKEnumPhaseId += 1
