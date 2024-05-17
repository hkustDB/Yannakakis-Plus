from enumerate import *
from reduce import *
from aggregation import *
from enumsType import *
from treenode import *
from codegen import transSelectData

import globalVar

BEGIN = 'create or replace view '
END = ';\n'

def codeGenYa(semiUp: list[SemiUpPhase], semiDown: list[SemiJoin], lastUp: Union[list[AggReducePhase], list[Join2tables]], finalResult: str, outPath: str, genType: GenType = GenType.DuckDB, isAgg: bool = False):
    outFile = open(outPath, 'w')

    for semi in semiUp:
        for prepare in semi.prepareView:
            if prepare.reduceType == ReduceType.CreateBagView:
                line = BEGIN + prepare.viewName + ' as select ' + transSelectData(prepare.selectAttrs, prepare.selectAttrAlias) + ' from ' + ', '.join(prepare.joinTableList) + ((' where ' + ' and '.join(prepare.whereCondList)) if len(prepare.whereCondList) else '') + END
            elif prepare.reduceType == ReduceType.CreateAuxView:
                line = BEGIN + prepare.viewName + ' as select ' + transSelectData(prepare.selectAttrs, prepare.selectAttrAlias) + ' from ' + prepare.fromTable
                line += ' where ' if len(prepare.whereCondList) else ''
                line += ' and '.join(prepare.whereCondList) + END
            else:   # TableAgg
                line = BEGIN + prepare.viewName + ' as select ' + transSelectData(prepare.selectAttrs, prepare.selectAttrAlias) + ' from ' + prepare.fromTable + ', ' + ', '.join(prepare.joinTableList) + ' where ' + ' and '.join(prepare.whereCondList) + END
            outFile.write(line)

        if semi.semiView is not None and not 'Aux' in semi.semiView.viewName:
            # outFile.write('# +. SemiJoin\n')
            # TODO: Add change for auxNode creation
            line = BEGIN + semi.semiView.viewName + ' as select ' + transSelectData(semi.semiView.selectAttrs, semi.semiView.selectAttrAlias) + ' from ' + semi.semiView.fromTable
            if len(semi.semiView.inLeft):
                line += ' where (' + ', '.join(semi.semiView.inLeft) + ') in (select ' + '(' * (True if globalVar.get_value('GEN_TYPE') == 'DuckDB' else False) + ', '.join(semi.semiView.inRight) + ')' * (True if globalVar.get_value('GEN_TYPE') == 'DuckDB' else False) + ' from ' + semi.semiView.joinTable
            
            if len(semi.semiView.inLeft):
                line += ' where ' if len(semi.semiView.whereCondList) else ''
                line += ' and '.join(semi.semiView.whereCondList) + ')'
            
            if len(semi.semiView.outerWhereCondList):
                if not len(semi.semiView.inLeft):
                    line += ' where '
                else:
                    line += ' and '
            line += ' and '.join(semi.semiView.outerWhereCondList) + END
            outFile.write(line)

    for semi in semiDown:
        # outFile.write('# +. SemiJoin\n')
        # TODO: Add change for auxNode creation
        line = BEGIN + semi.viewName + ' as select ' + transSelectData(semi.selectAttrs, semi.selectAttrAlias) + ' from ' + semi.fromTable
        if len(semi.inLeft):
            line += ' where (' + ', '.join(semi.inLeft) + ') in (select ' + '(' * (True if globalVar.get_value('GEN_TYPE') == 'DuckDB' else False) + ', '.join(semi.inRight) + ')' * (True if globalVar.get_value('GEN_TYPE') == 'DuckDB' else False) + ' from ' + semi.joinTable
        
        if len(semi.inLeft):
            line += ' where ' if len(semi.whereCondList) else ''
            line += ' and '.join(semi.whereCondList) + ')'

        if len(semi.outerWhereCondList):
            if not len(semi.inLeft):
                line += ' where '
            else:
                line += ' and '
        line += ' and '.join(semi.outerWhereCondList) + END

        outFile.write(line)

    for last in lastUp:
        if isAgg:
            line = BEGIN + last.aggView.viewName + ' as select ' + transSelectData(last.aggView.selectAttrs, last.aggView.selectAttrAlias) + ' from ' + last.aggView.fromTable
            line += (' where ' + ' and '.join(last.aggView.selfComp)) if len(last.aggView.selfComp) else ''
            if len(last.aggView.groupBy):
                line += ' group by ' + ','.join(last.aggView.groupBy)
            line += END
            outFile.write(line)
            if 'Join' in last.aggJoin.viewName:
                line = BEGIN + last.aggJoin.viewName + ' as select ' + transSelectData(last.aggJoin.selectAttrs, last.aggJoin.selectAttrAlias) + ' from '
                if last.aggJoin.fromTable != '':
                    joinSentence = last.aggJoin.fromTable
                    if last.aggJoin._joinFlag == ' JOIN ':
                        joinSentence += ' join ' + last.aggJoin.joinTable + ' using(' + ','.join(last.aggJoin.alterJoinKey) + ')'
                    else:
                        joinSentence += ', ' + last.aggJoin.joinTable
                    line += joinSentence
                else:
                    line += last.aggJoin.joinTable
                line += ' where ' if len(last.aggJoin.whereCondList) else ''
                line += ' and '.join(last.aggJoin.whereCondList) + END
                outFile.write(line)
        else:
            line = BEGIN + last.viewName + ' as select ' + transSelectData(last.selectAttrs, last.selectAttrAlias) + ' from '
            joinSentence = last.fromTable
            if last._joinFlag == ' JOIN ':
                joinSentence +=' join ' + last.joinTable + ' using(' + ', '.join(last.alterJoinKey) + ')'
            else:
                joinSentence += ', ' + last.joinTable
            whereSentence = last.joinCond + (' and ' if last.joinCond != '' and len(last.whereCondList) else '') + ' and '.join(last.whereCondList)
            line += joinSentence + ((' where ' + whereSentence) if whereSentence != '' else '') + END
            outFile.write(line)

    outFile.write(finalResult)
    outFile.close()