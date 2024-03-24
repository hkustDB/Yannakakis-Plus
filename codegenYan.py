from enumerate import *
from reduce import *
from aggregation import *
from enumsType import *
from treenode import *
import globalVar

def codeGenYa(semiUp: list[SemiJoin], semiDown: list[SemiJoin], lastUp: Union[list[AggReducePhase], list[Join2tables]], finalResult: str, outPath: str, genType: GenType = GenType.DuckDB):
    pass