from enumsType import GenType
import re


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
        self.isExtract: bool = False    # NOTE: Currently only aggregation has extract function
        self.isChild: bool = False      # corres to child node
        self.isDone: bool = False
        
class CompList:
    def __init__(self, compList: list[Comp]) -> None:
        self.allAlias: set[str] = set()
        self.alias2Comp: dict[str, Comp] = dict()
        self.alias2Var: dict[str, set[str]] = dict()
        pattern = re.compile('v[0-9]+')
        for comp in compList:
            self.allAlias.add(comp.result)
            new_comp = Comp(comp.result, comp.expr)
            self.alias2Comp[comp.result] = new_comp
            inVars = pattern.findall(comp.expr)
            self.alias2Var[comp.result] = set(inVars)
            if 'EXTRACT' in comp.expr:
                self.alias2Comp[comp.result].isExtract = True
                
    def reset(self):
        for alias in self.alias2Comp.keys():
            self.alias2Comp[alias].isDone = False
        return 