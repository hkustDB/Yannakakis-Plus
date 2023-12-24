from jointree import *
from enumsType import *

from sys import maxsize

def generateTopKIR(JT: JoinTree, outputVariables: list[str], IRmode: IRType, base: int = 2, k: int = 1024) -> [list[ReducePhase], list[EnumeratePhase], str]:
    
 