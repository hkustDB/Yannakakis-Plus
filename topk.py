from enumsType import GenType

class TopK:
    def __init__(self, orderBy: str, DESC: bool, limit: int, mode: int = 0, base: int = 32, genType: GenType = GenType.DuckDB) -> None:
        self.orderBy = orderBy
        self.DESC = DESC
        self.limit=  limit
        self.mode = mode
        self.base = base
        self.genType = genType
        
class Comp:
    def __init__(self, result: str, expr: str) -> None:
        self.result = result
        self.expr = expr
        
class CompList:
    def __init__(self, compList: list[Comp]) -> None:
        self.allAlias: set[str] = set()
        self.alias2Comp: dict[str, str] = dict()
        for comp in compList:
            self.allAlias.add(comp.result)
            self.alias2Comp[comp.result] = comp.expr