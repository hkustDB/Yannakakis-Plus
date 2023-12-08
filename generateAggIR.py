from jointree import *
from comparison import *
from enumsType import *
from aggregation import *

def generateAggIR(JT: JoinTree, COMP: dict[int, Comparison], outputVariables: list[str], Agg: Aggregation) -> [list[AggReducePhase], list[ReducePhase], list[EnumeratePhase]]:
    pass