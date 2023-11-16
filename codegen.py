from enumerate import *
from reduce import *
from enumsType import *


def codeGen(reduceList: list[ReducePhase], enumerateList: list[EnumeratePhase], outPath: str):
    outFile = open(outPath, 'w')
    # 1. reduceList rewrite
    for reduce in reduceList:
        outFile.write('# Reduce' + str(reduce.reducePhaseId))
        if reduce.prepareView != None:
            pass
    
    # 2. enumerateList rewrite