'''
Common part for each action in reduce & enumerate phase
'''

class Action:
    _viewId = 0
    _sampleRate = 100
    def __init__(self, viewName: str, selectAttrs: list[str], selectAttrAlias: list[str], fromTable: int) -> None:
        self.viewName = viewName
        self.selectAttrs = selectAttrs
        self.selectAttrAlias = selectAttrAlias
        self.fromTable = fromTable
        self.reduceType = None                  # set in each type
        self.viewId = Action._viewId
        self._addViewId
    
    @property
    def _addViewId(self):
        Action._viewId += 1
        
    @property
    def getViewId(self):
        return Action._viewId
        
    def setSampleRate(self, sampleRate: int):
        self._sampleRate = sampleRate
    