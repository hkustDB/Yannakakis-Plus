'''
Common part for each action in reduce & enumerate phase
'''

class Action:
    '''
    fromTable: it could be view which has no id corresponds to TreeNode, so use table alias
    If it has alias, parse it into list([source] as [alias])
    '''
    _viewId = 0
    _sampleRate = 5
    def __init__(self, viewName: str, selectAttrs: list[str], selectAttrAlias: list[str], fromTable: str) -> None:
        self.viewName = viewName
        self.selectAttrs = selectAttrs
        self.selectAttrAlias = selectAttrAlias
        self.fromTable = fromTable
        self.reduceType = None                  # set in each type
        self.viewId = Action._viewId
        self._addViewId
        self.semiFlag = 0
    
    @property
    def _addViewId(self):
        Action._viewId += 1
        
    @property
    def getViewId(self):
        return Action._viewId
        
    def setSampleRate(self, sampleRate: int):
        self._sampleRate = sampleRate
    