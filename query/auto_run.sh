#!/bin/bash

SCRIPT=$(readlink -f $0)
SCRIPT_PATH=$(dirname "${SCRIPT}")

INPUT_DIR=$2
INPUT_DIR_PATH="${SCRIPT_PATH}/${INPUT_DIR}"

# graph, tpch, lsqb
DATABASE=$1

duckdb="/opt/homebrew/bin/duckdb"

for dir in $(find ${INPUT_DIR} -type d);
do
    if [ $dir != ${INPUT_DIR} ]
    then
        CUR_PATH="${SCRIPT_PATH}/${dir}"
        LOG_FILE="${CUR_PATH}/log.txt"
        touch $LOG_FILE
        QUERY="${CUR_PATH}/query.sql"
        REWRITE="${CUR_PATH}/rewrite0.txt"
        RAN=$RANDOM
        SUBMIT_QUERY="${CUR_PATH}/query_${RAN}.sql"
        rm -f "${SUBMIT_QUERY}"
        touch "${SUBMIT_QUERY}"
        SUBMIT_REWRITE="${CUR_PATH}/rewrite_${RAN}.sql"
        rm -f "${SUBMIT_REWRITE}"
        touch "${SUBMIT_REWRITE}"

        echo "COPY (" >> ${SUBMIT_QUERY}
        cat ${QUERY} >> ${SUBMIT_QUERY}
        echo ") TO '/dev/null' (DELIMITER ',');" >> ${SUBMIT_QUERY}
        echo "COPY (" >> ${SUBMIT_REWRITE}
        cat ${REWRITE} >> ${SUBMIT_REWRITE}
        echo ") TO '/dev/null' (DELIMITER ',');" >> ${SUBMIT_REWRITE}

        echo "Processing ${CUR_PATH}..."
        echo "Start DuckDB Task..."
        current_task=1
        while [[ ${current_task} -le 3 ]]
            do
                OUT_FILE="${CUR_PATH}/output.txt"
                rm -f $OUT_FILE
                touch $OUT_FILE
                $duckdb -c ".open ${DATABASE}_db" -c ".timer on" -c ".read ${SUBMIT_QUERY}" | grep "Run Time (s): real" >> $OUT_FILE
                awk 'BEGIN{sum=0;}{sum+=$5;} END{printf "Exec time(s): %f\n", sum;}' $OUT_FILE >> $LOG_FILE
                current_task=$(($current_task+1))
            done
        rm -f $OUT_FILE
        echo "======================" >> $LOG_FILE
        current_task=1
        while [[ ${current_task} -le 3 ]]
            do
                OUT_FILE="${CUR_PATH}/output.txt"
                rm -f $OUT_FILE
                touch $OUT_FILE
                $duckdb -c ".open ${DATABASE}_db" -c ".timer on" -c ".read ${SUBMIT_QUERY}" | grep "Run Time (s): real" >> $OUT_FILE
                awk 'BEGIN{sum=0;}{sum+=$5;} END{printf "Exec time(s): %f\n", sum;}' $OUT_FILE >> $LOG_FILE
                current_task=$(($current_task+1))
            done
        rm -f $OUT_FILE
        rm -f "${SUBMIT_QUERY}"
        rm -f "${SUBMIT_REWRITE}"
    fi
done