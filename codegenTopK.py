from codegen import transSelectData
from levelK import *
from productK import *

BEGIN = 'create or replace view '
DROP = 'drop table if exists '
BEGIN_TABLE = 'create table '
AS = ' as (\n'
MID = '), \n'
WITH = 'with '
WITHEND = ')\n'
VIEWEND = ');\n'

# BEGIN + ${name} + AS + WITH + ${name} + AS + ${select...} + WITHEND + ${select...} + MID + .. + VIEWEND
def genWithView(inView: WithView) -> str:
    line = 'select ' + transSelectData(inView.selectAttrs, inView.selectAttrAlias) + ' from ' + inView.fromTable
    if inView.joinTable:
        if len(inView.usingJoinKey):
            line += ' join ' + inView.joinTable + ' using(' + ','.join(inView.usingJoinKey) + ')'
        else:
            line += ', ' + inView.joinTable
    line += ' where ' if len(inView.whereCondList) else ''
    line += ' and '.join(inView.whereCondList)
    line += (' group by ' + ','.join(inView.groupBy)) if len(inView.groupBy) else ''
    line += (' order by ' + ','.join(inView.orderBy)) if len(inView.orderBy) else ''
    line += ' DESC' if inView.DESC else ''
    line += (' limit ' + str(inView.limit)) if inView.limit else ''
    
    return line


def genJoinUnionView(inView: EnumJoinUnion) -> str:
    line = 'select ' + transSelectData(inView.selectAttrs, inView.selectAttrAlias) + ' from ' + inView.fromTable
    if len(inView.usingJoinKey):
        line += ' join ' + inView.joinTable + ' using(' + ','.join(inView.usingJoinKey) + ')'
    else:
        line += ', ' + inView.joinTable
    line += ' where ' if len(inView.whereCondList) else ''
    line += ' and '.join(inView.whereCondList)
    line += (' group by ' + ','.join(inView.groupBy)) if len(inView.groupBy) else ''
    if inView.unionTable:
        line += ' union all ' + 'select * from ' + inView.unionTable
    line += (' order by ' + ','.join(inView.orderBy)) if len(inView.orderBy) else ''
    line += ' DESC' if inView.DESC else ''
    line += (' limit ' + str(inView.limit)) if inView.limit else ''
    
    return line

def genActionView(inView: Action):
    line = 'select ' + transSelectData(inView.selectAttrs, inView.selectAttrAlias) + ' from ' + inView.fromTable
    return line


def genRNView(inView: RNView):
    line = 'select ' + transSelectData(inView.selectAttrs, inView.selectAttrAlias) + ' from ' + inView.fromTable
    return line


def genSelectRNView(inView: EnumSelectRN):
    line = 'select ' + transSelectData(inView.selectAttrs, inView.selectAttrAlias) + ' from ' + inView.fromTable
    line += (' where ' + ' and '.join(inView.rnCond)) if len(inView.rnCond) else ''
    return line


def codeGenTopKL(reduceList: list[LevelKReducePhase], enumerateList: list[LevelKEnumPhase], finalResult: str, outPath: str):
    outFile = open(outPath, 'w+')
    dropView, dropTable = [], []
    
    # 1. reduceList rewrite
    if len(reduceList):
        outFile.write('\n-- Reduce Phase: \n')
    for reduce in reduceList:
        outFile.write('\n-- Reduce' + str(reduce.levelKReducePhaseId) + '\n')
        line = BEGIN + reduce.orderView.viewName + AS + WITH + reduce.aggView.viewName + AS + genWithView(reduce.aggView) + WITHEND
        outFile.write(line)
        line = genWithView(reduce.orderView) + VIEWEND
        dropView.append(reduce.orderView.viewName)
        outFile.write(line)
    
    # 2. enumerateList rewrite
    if len(enumerateList):
        outFile.write('\n-- Enumerate Phase: \n')
    for enum in enumerateList:
        outFile.write('\n-- Enumerate' + str(enum.levelKEnumPhaseId) + '\n')
        outFile.write('-- 0. rankView\n')
        line = BEGIN_TABLE + enum.rankView.finalView.viewName + AS + WITH + enum.rankView.maxView.viewName + AS + genWithView(enum.rankView.maxView) + MID
        outFile.write(line)
        line = enum.rankView.truncateView.viewName + AS + genWithView(enum.rankView.truncateView) + WITHEND
        outFile.write(line)
        line = genRNView(enum.rankView.finalView) + VIEWEND
        dropTable.append(enum.rankView.finalView.viewName)
        outFile.write(line)
        
        outFile.write('-- 1. logkLoop\n')
        line = BEGIN + enum.finalView.viewName + AS + WITH
        outFile.write(line)
        line = ''
        for index, loop in enumerate(enum.logkLoop):
            if loop.levelk_left:
                line = loop.levelk_left.viewName + AS + genSelectRNView(loop.levelk_left) + MID
            line += loop.levelk_right.viewName + AS + genSelectRNView(loop.levelk_right) + MID
            line += loop.levelk_join.viewName + AS + genJoinUnionView(loop.levelk_join)
            if index != len(enum.logkLoop) - 1: 
                line += MID
            else:
                line += WITHEND
            outFile.write(line)
        line = 'select ' + transSelectData(enum.finalView.selectAttrs, enum.finalView.selectAttrAlias) + ' from ' + enum.finalView.fromTable + VIEWEND
        outFile.write(line)
        dropView.append(enum.finalView.viewName)
        
    outFile.write(finalResult)
    if len(dropView):
        outFile.write('\n-- ')
        for table in reversed(dropView):
            line = 'drop view ' + table + ';'
            outFile.write(line)
    if len(dropTable):
        outFile.write('\n-- ')
        for table in reversed(dropTable):
            line = 'drop table ' + table + ';'
            outFile.write(line)
    outFile.close()


def codeGenTopKP(reduceList: list[ProductKReducePhase], enumerateList: list[ProductKEnumPhase], finalResult: str, outPath: str):
    outFile = open(outPath, 'w+')
    dropView = []
    
    # 1. reduceList rewrite
    if len(reduceList):
        outFile.write('\n-- Reduce Phase: \nwith\n')
    for reduce in reduceList:
        outFile.write('\n-- Reduce' + str(reduce.productKReducePhaseId) + '\n')
        if reduce.leafExtra:
            outFile.write('-- 0. leafExtra\n')
            line = reduce.leafExtra.viewName + AS + genActionView(reduce.leafExtra) + MID
            outFile.write(line)
        outFile.write('-- 1. aggMax\n')
        line = reduce.aggMax.viewName + AS + genActionView(reduce.aggMax) + ' group by ' + ','.join(reduce.groupBy) + MID
        outFile.write(line)
        outFile.write('-- 2. joinRes\n')
        line = reduce.joinRes.viewName + AS + genWithView(reduce.joinRes) + MID
        outFile.writable(line)
    
    # 2. enumerateList rewrite
    if len(enumerateList):
        outFile.write('\n-- Enumerate Phase: \n')
    for index, enum in enumerate(enumerateList):
        outFile.write('\n-- Enumerate' + str(enum.productKEnumPhaseId) + '\n')
        outFile.write('-- 0. aggMax\n')
        line = enum.aggMax.viewName + AS + genActionView(enum.aggMax) + ' group by ' + enum.groupBy + MID
        outFile.write(line)
        outFile.write('-- 1. pruneJoin\n')
        line = enum.pruneJoin.viewName + AS + genWithView(enum.pruneJoin) + MID
        outFile.write(line)
        outFile.write('-- 2. joinRes\n')
        if index != len(enumerateList) - 1:
            line = enum.joinRes.viewName + AS + genWithView(enum.joinRes) + MID
        else:
            line = enum.joinRes.viewName + AS + genWithView(enum.joinRes) + WITHEND
        outFile.write(line)
    
    outFile.write(finalResult)
    if len(dropView):
        outFile.write('\n-- ')
        for table in reversed(dropView):
            line = 'drop view ' + table + ';'
            outFile.write(line)
    outFile.write(line)
    outFile.close()