from codegen import transSelectData
from levelK import *
from productK import *

BEGIN = 'create or replace view '
DROP = 'drop table if exists '
BEGIN_TABLE = 'create table '
AS = ' as ('
WITH = 'with '
WITHEND = ')\n'
MID = '), \n'
VIEWEND = ');\n'

# BEGIN + ${name} + AS + WITH + ${name} + AS + ${select...} + WITHEND + ${select...} + MID + .. + VIEWEND
def genWithView(inView: WithView) -> str:
    line = 'select ' + transSelectData(inView.selectAttrs, inView.selectAttrAlias) + ' from ' + inView.fromTable
    if len(inView.usingJoinKey):
        line += ' join ' + inView.joinTable + ' using(' + ','.join(inView.usingJoinKey) + ')'
    else:
        line += ', ' + inView.joinTable
    line += ' where ' if len(inView.whereCondList) else ''
    line += ' and '.join(inView.whereCondList)
    line += ' group by ' if len(inView.groupBy) else ''
    line += ' order by ' if len(inView.orderBy) else ''
    line += ' DESC ' if inView.DESC else ''
    line += ' limit ' if inView.limit else ''
    
    return line


def genJoinUnionView(inView: EnumJoinUnion) -> str:
    line = 'select ' + transSelectData(inView.selectAttrs, inView.selectAttrAlias) + ' from ' + inView.fromTable
    if len(inView.usingJoinKey):
        line += ' join ' + inView.joinTable + ' using(' + ','.join(inView.usingJoinKey) + ')'
    else:
        line += ', ' + inView.joinTable
    line += ' where ' if len(inView.whereCondList) else ''
    line += ' and '.join(inView.whereCondList)
    line += ' group by ' if len(inView.groupBy) else ''
    line += ' union all ' + 'select * from ' + inView.unionTable
    line += ' order by ' if len(inView.orderBy) else ''
    line += ' DESC ' if inView.DESC else ''
    line += ' limit ' if inView.limit else ''
    
    return line


def genRNView(inView: EnumSelectRN):
    line = 'select ' + transSelectData(inView.selectAttrs, inView.selectAttrAlias) + ' from ' + inView.fromTable
    line += ' where ' + ' and '.join(inView.rnCond)
    return line


def codeGenTopKL(reduceList: list[LevelKReducePhase], enumerateList: list[LevelKEnumPhase], finalResult: str, outPath: str):
    outFile = open(outPath, 'w+')
    dropView = []
    
    # 1. reduceList rewrite
    if len(reduceList):
        outFile.write('\n##Reduce Phase: \n')
    for reduce in reduceList:
        outFile.write('\n# Reduce' + str(reduce.reducePhaseId) + '\n')
        outFile.write('# 0. aggView\n')
        line = BEGIN + reduce.orderView.viewName + AS + WITH + reduce.aggView.viewName + AS + genWithView(reduce.aggView) + WITHEND
        outFile.write('# 1. orderView\n')
        line += genWithView(reduce.orderView) + VIEWEND
        dropView.append(reduce.orderView.viewName)
        outFile.write(line)
    
    if len(enumerateList):
        outFile.write('\n## Enumerate Phase: \n')
    for enum in enumerateList:
        outFile.write('\n# Enumerate' + str(enum.enumeratePhaseId) + '\n')
        outFile.write('# 0. rankView\n')
        line = BEGIN_TABLE + enum.rankView.finalView.viewName + AS + WITH + enum.rankView.maxView.viewName + AS + genWithView(enum.rankView.maxView) + MID
        line += enum.rankView.truncateView.viewName + AS + genWithView(enum.rankView.truncateView) + WITHEND
        line += genWithView(enum.rankView.finalView) + VIEWEND
        outFile.write(line)
        
        outFile.write('# 1. logkLoop\n')
        line = BEGIN + enum.finalView.viewName + AS + WITH
        for index, loop in enumerate(enum.logkLoop):
            if loop.levelk_left:
                line += loop.levelk_left.viewName + AS + genRNView(loop.levelk_left) + MID
            line += loop.levelk_right.viewName + AS + genRNView(loop.levelk_right) + MID
            line += loop.levelk_join.viewName + AS + genJoinUnionView(loop.levelk_join)
            if index != len(enum.logkLoop) - 1: 
                line += MID
            else:
                line += WITHEND
        line += 'select ' + transSelectData(enum.finalView.selectAttrs, enum.finalView.selectAttrAlias) + ' from ' + enum.finalView.fromTable + VIEWEND
        outFile.write(line)
        
    outFile.write(finalResult)


def codeGenTopKP(reduceList: [ProductKReducePhase], enumerateList: list[ProductKEnumPhase], finalResult: str, outPath: str):
    pass