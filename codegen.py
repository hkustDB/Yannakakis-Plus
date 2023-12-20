from enumerate import *
from reduce import *
from aggregation import *

from enumsType import *

BEGIN = 'create or replace view '
END = ';\n'

def transSelectData(selectAttrs: list[str], selectAttrAlias: list[str], row_numer: bool = False, max_rn: bool = False) -> str:
    extraAdd = (', row_number()' if row_numer else '') + (', max(rn) as mrn' if max_rn else '')
    if len(selectAttrs) == 0: return ', '.join(selectAttrAlias) + extraAdd
    if len(selectAttrs) != len(selectAttrAlias):
        print("First: " + str(selectAttrs))
        print("Second: " + str(selectAttrAlias))
        raise RuntimeError("Two sides are not equal! ") 

    selectData = []
    for index, alias in enumerate(selectAttrAlias):
        if selectAttrAlias[index] == '': continue
        if selectAttrs[index] != '':
            selectData.append(selectAttrs[index] + ' as ' + selectAttrAlias[index])
        else:
            selectData.append(selectAttrAlias[index])
    
    ret = ', '.join(selectData) + extraAdd
    return ret

def codeGen(reduceList: list[ReducePhase], enumerateList: list[EnumeratePhase], finalResult: str, outputVariables: list[str], outPath: str, aggGroupBy: list[str] = [], aggList: list[AggReducePhase] = [], isFull = True, isAgg = False):
    outFile = open(outPath, 'w+')
    dropView = []
    # 0. aggReduceList
    if len(aggList):
        outFile.write('## AggReduce Phase: \n')
    for agg in aggList:
        outFile.write('\n# AggReduce' + str(agg.aggReducePhaseId) + '\n')
        
        if len(agg.prepareView) != 0:
            outFile.write('# 0. Prepare\n')
            for prepare in agg.prepareView:
                if prepare.reduceType == ReduceType.CreateBagView:
                    line = BEGIN + prepare.viewName + ' as select ' + transSelectData(prepare.selectAttrs, prepare.selectAttrAlias) + ' from ' + ', '.join(prepare.joinTableList) + ((' where ' + ' and '.join(prepare.whereCondList)) if len(prepare.whereCondList) else '') + END
                elif prepare.reduceType == ReduceType.CreateAuxView:
                    line = BEGIN + prepare.viewName + ' as select ' + transSelectData(prepare.selectAttrs, prepare.selectAttrAlias) + ' from ' + prepare.fromTable
                    line += ' where ' if len(prepare.whereCondList) else ''
                    line += ' and '.join(prepare.whereCondList) + END
                else:   # TableAgg
                    line = BEGIN + prepare.viewName + ' as select ' + transSelectData(prepare.selectAttrs, prepare.selectAttrAlias) + ' from ' + prepare.fromTable + ', ' + ', '.join(prepare.joinTableList) + ' where ' + ' and '.join(prepare.whereCondList) + END
                
                dropView.append(prepare.viewName)
                outFile.write(line)
                
        outFile.write('# 1. aggView\n')
        line = BEGIN + agg.aggView.viewName + ' as select ' + transSelectData(agg.aggView.selectAttrs, agg.aggView.selectAttrAlias) + ' from ' + agg.aggView.fromTable
        line += (' where ' + ' and '.join(agg.aggView.selfComp)) if len(agg.aggView.selfComp) else ''
        line += ' group by ' + ','.join(agg.aggView.groupBy) + END
        dropView.append(agg.aggView.viewName)
        outFile.write(line)
        outFile.write('# 2. aggJoin\n')
        line = BEGIN + agg.aggJoin.viewName + ' as select ' + transSelectData(agg.aggJoin.selectAttrs, agg.aggJoin.selectAttrAlias) + ' from '
        if agg.aggJoin.fromTable != '':
            joinSentence = agg.aggJoin.fromTable
            if agg.aggJoin._joinFlag == ' JOIN ':
                joinSentence += ' join ' + agg.aggJoin.joinTable + ' using(' + ','.join(agg.aggJoin.alterJoinKey) + ')'
            else:
                joinSentence += ', ' + agg.aggJoin.joinTable
            line += joinSentence
            line += ' where ' if len(agg.aggJoin.whereCondList) else ''
            line += ' and '.join(agg.aggJoin.whereCondList) + END
        else:
            line += agg.aggJoin.joinTable + END
        dropView.append(agg.aggJoin.viewName)
        outFile.write(line)
    
    # 1. reduceList rewrite
    if len(reduceList):
        outFile.write('\n##Reduce Phase: \n')
    for reduce in reduceList:
        outFile.write('\n# Reduce' + str(reduce.reducePhaseId) + '\n')
        
        if len(reduce.prepareView) != 0:
            outFile.write('# 0. Prepare\n')
            for prepare in reduce.prepareView:
                if prepare.reduceType == ReduceType.CreateBagView:
                    line = BEGIN + prepare.viewName + ' as select ' + transSelectData(prepare.selectAttrs, prepare.selectAttrAlias) + ' from ' + ', '.join(prepare.joinTableList) + ((' where ' + ' and '.join(prepare.whereCondList)) if len(prepare.whereCondList) else '') + END
                elif prepare.reduceType == ReduceType.CreateAuxView:
                    line = BEGIN + prepare.viewName + ' as select ' + transSelectData(prepare.selectAttrs, prepare.selectAttrAlias) + ' from ' + prepare.fromTable
                    line += ' where ' if len(prepare.whereCondList) else ''
                    line += ' and '.join(prepare.whereCondList) + END
                else:   # TableAgg
                    line = BEGIN + prepare.viewName + ' as select ' + transSelectData(prepare.selectAttrs, prepare.selectAttrAlias) + ' from ' + prepare.fromTable + ', ' + ', '.join(prepare.joinTableList) + ' where ' + ' and '.join(prepare.whereCondList) + END
                
                dropView.append(prepare.viewName)
                outFile.write(line)
        
        if reduce.semiView is not None:
            outFile.write('# +. SemiJoin\n')
            # TODO: Add change for auxNode creation
            line = BEGIN + reduce.semiView.viewName + ' as select ' + transSelectData(reduce.semiView.selectAttrs, reduce.semiView.selectAttrAlias) + ' from ' + reduce.semiView.fromTable + ' where (' + ', '.join(reduce.semiView.inLeft) + ') in (select ' + ', '.join(reduce.semiView.inRight) + ' from ' + reduce.semiView.joinTable
            line += ' where ' if len(reduce.semiView.whereCondList) != 0 else ''
            line += ' and '.join(reduce.semiView.whereCondList) + ')' 
            line += ' and ' if len(reduce.semiView.outerWhereCondList) else ''
            line += ' and '.join(reduce.semiView.outerWhereCondList) + END
            outFile.write(line)
            dropView.append(reduce.semiView.viewName)
            continue
                
        # CQC part, if orderView is None, pass do nothing (for aux support relation output case)
        if reduce.orderView is not None:    
            
            outFile.write('# 1. orderView\n')
            line = BEGIN + reduce.orderView.viewName + ' as select ' + transSelectData(reduce.orderView.selectAttrs, reduce.orderView.selectAttrAlias, row_numer=True) + ' over (partition by ' + ', '.join(reduce.orderView.joinKey) + ' order by ' + ', '.join(reduce.orderView.orderKey) + (' DESC' if not reduce.orderView.AESC else '') + ') as rn ' + 'from ' + reduce.orderView.fromTable
            line += ' where ' if len(reduce.orderView.selfComp) != 0 else ''
            line += ' and '.join(reduce.orderView.selfComp) + END
            dropView.append(reduce.orderView.viewName)
            outFile.write(line)
            outFile.write('# 2. minView\n')
            line = BEGIN + reduce.minView.viewName + ' as select ' + transSelectData(reduce.minView.selectAttrs, reduce.minView.selectAttrAlias) + ' from ' + reduce.minView.fromTable + ' where ' + reduce.minView.whereCond + END
            dropView.append(reduce.minView.viewName)
            outFile.write(line)
            outFile.write('# 3. joinView\n')
            line = BEGIN + reduce.joinView.viewName + ' as select ' + transSelectData(reduce.joinView.selectAttrs, reduce.joinView.selectAttrAlias) + ' from '
            joinSentence = reduce.joinView.fromTable
            if reduce.joinView._joinFlag == ' JOIN ':
                joinSentence +=' join ' + reduce.joinView.joinTable + ' using(' + ', '.join(reduce.joinView.alterJoinKey) + ')'
            else:
                joinSentence += ', ' + reduce.joinView.joinTable
            whereSentence = reduce.joinView.joinCond + (' and ' if reduce.joinView.joinCond != '' and len(reduce.joinView.whereCondList) else '') + ' and '.join(reduce.joinView.whereCondList)
            line += joinSentence + ((' where ' + whereSentence) if whereSentence != '' else '') + END
            dropView.append(reduce.joinView.viewName)
            outFile.write(line)
        
        if reduce.bagAuxView:
            outFile.write('# 5. bagAuxView\n')
            line = BEGIN + reduce.bagAuxView.viewName + ' as select ' + transSelectData(reduce.bagAuxView.selectAttrs, reduce.bagAuxView.selectAttrAlias) + ' from ' + reduce.bagAuxView.joinTableList[0]
            for i in range(1, len(reduce.bagAuxView.joinTableList)):
                line += ' join ' + reduce.bagAuxView.joinTableList[i] + ' using(' + ','.join(reduce.bagAuxView.joinKey[i-1]) + ')'
            line += (' where ' + ' and '.join(reduce.bagAuxView.whereCondList)) if len(reduce.bagAuxView.whereCondList) else ''
            line += END
            dropView.append(reduce.bagAuxView.viewName)
            outFile.write(line)
    
    # 2. enumerateList rewrite
    if len(enumerateList):
        outFile.write('\n## Enumerate Phase: \n')
    for enum in enumerateList:
        outFile.write('\n# Enumerate' + str(enum.enumeratePhaseId) + '\n')
        if enum.semiEnumerate is not None:
            outFile.write('# +. SemiEnumerate\n')
            line = BEGIN + enum.semiEnumerate.viewName + ' as select ' + transSelectData(enum.semiEnumerate.selectAttrs, enum.semiEnumerate.selectAttrAlias) + ' from ' + enum.semiEnumerate.fromTable
            line += ' join ' if len(enum.semiEnumerate.joinKey) != 0 else ', '
            line += enum.semiEnumerate.joinTable
            line += ' using(' + ', '.join(enum.semiEnumerate.joinKey) + ')' if len(enum.semiEnumerate.joinKey) != 0 else ''
            
            if enum.semiEnumerate.joinCond and len(enum.semiEnumerate.whereCondList):
                line += ' where ' + enum.semiEnumerate.joinCond + ' and ' + ' and '.join(enum.semiEnumerate.whereCondList)
            elif enum.semiEnumerate.joinCond:
                line += ' where ' + enum.semiEnumerate.joinCond
            elif len(enum.semiEnumerate.whereCondList):
                line += ' where ' + ' and '.join(enum.semiEnumerate.whereCondList)
            
            line += END
            outFile.write(line)
            dropView.append(enum.semiEnumerate.viewName)
            continue
        
        outFile.write('# 1. createSample\n')
        line = BEGIN + enum.createSample.viewName + ' as select ' + enum.createSample.selectAttrAlias[0] + ' from ' + enum.createSample.fromTable + ' where ' + enum.createSample.whereCond + END
        dropView.append(enum.createSample.viewName)
        outFile.write(line)
        
        outFile.write('# 2. selectMax\n')
        line = BEGIN + enum.selectMax.viewName + ' as select ' + transSelectData(enum.selectMax.selectAttrs, enum.selectMax.selectAttrAlias, row_numer=False, max_rn=True) + ' from ' + enum.selectMax.fromTable + ' join ' + enum.selectMax.joinTable + ' using(' + ', '.join(enum.selectMax.joinKey) + ') where ' + enum.selectMax.whereCond + ' group by ' + ', '.join(enum.selectMax.groupCond) + END 
        dropView.append(enum.selectMax.viewName)
        outFile.write(line)
        
        outFile.write('# 3. selectTarget\n')
        line = BEGIN + enum.selectTarget.viewName + ' as select ' + ', '.join(enum.selectTarget.selectAttrAlias) + ' from ' + enum.selectTarget.fromTable + ' join ' + enum.selectTarget.joinTable + ' using(' + ', '.join(enum.selectTarget.joinKey) + ')' + ' where ' + enum.selectTarget.whereCond + END
        dropView.append(enum.selectTarget.viewName)
        outFile.write(line)
        
        outFile.write('# 4. stageEnd\n')
        line = BEGIN + enum.stageEnd.viewName + ' as select ' + ', '.join(enum.stageEnd.selectAttrAlias) + ' from ' + enum.stageEnd.fromTable + ' join ' + enum.stageEnd.joinTable + ' using(' + ', '.join(enum.stageEnd.joinKey) + ')' + ' where ' + enum.stageEnd.whereCond 
        line += ' and ' if len(enum.stageEnd.whereCondList) else ''
        line += ' and '.join(enum.stageEnd.whereCondList) + END
        dropView.append(enum.stageEnd.viewName)
        outFile.write(line)
    
    outFile.write('# Final result: \n')
    outFile.write(finalResult)
    
    if len(dropView):
        line = '\n# drop view ' + ', '.join(reversed(dropView)) + END
        outFile.write(line)
    
    outFile.close()
    