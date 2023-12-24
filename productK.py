from action import Action
from levelK import WithView

# Reduce Part
class ComSufMax:
    def __init__(self, leafExtra: Action, aggMax: Action, joinRes: WithView, groupBy: list[str]) -> None:
        self.leafExtra = leafExtra
        self.aggMax = aggMax
        self.joinRes = joinRes
        self.groupBy = groupBy
        
# Enumerate Part
class EnumJoin:
    def __init__(self, aggMax: Action, pruneJoin: WithView, joinRes: WithView) -> None:
        self.aggMax = aggMax
        self.pruneJoin = pruneJoin
        self.joinRes = joinRes