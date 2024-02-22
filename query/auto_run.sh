#!/bin/bash

uNames=`uname -s`
osName=${uNames: 0: 4}
if [ "$osName" == "Darw" ] # Darwin
then
	COMMAND="ghead"
elif [ "$osName" == "Linu" ] # Linux
then
	COMMAND="head"
fi

SCRIPT=$(readlink -f $0)
SCRIPT_PATH=$(dirname "${SCRIPT}")

INPUT_DIR=$2
INPUT_DIR_PATH="${SCRIPT_PATH}/${INPUT_DIR}"

# graph, tpch, lsqb
DATABASE=$1

duckdb="/opt/homebrew/bin/duckdb"

# Suffix function
function FileSuffix() {
    local filename="$1"
    if [ -n "$filename" ]; then
        echo "${filename##*.}"
    fi
}

function IsSuffix() {
    local filename="$1"
    if [ "$(FileSuffix ${filename})" = "sql" ]
    then
        return 0
    else 
        return 1
    fi
}

for dir in $(find ${INPUT_DIR} -type d);
do
    if [ $dir != ${INPUT_DIR} ]
    then
        CUR_PATH="${SCRIPT_PATH}/${dir}"
        for file in $(ls ${CUR_PATH})
        do
            IsSuffix ${file}
            ret=$?
            if [ $ret -eq 0 ]
            then
                filename="${file%.*}"
                LOG_FILE="${CUR_PATH}/log_${filename}.txt"
                rm -f $LOG_FILE
                touch $LOG_FILE
                QUERY="${CUR_PATH}/${file}"
                RAN=$RANDOM
                if [ ${filename} = "query" ]
                then 
                    SUBMIT_QUERY="${CUR_PATH}/query_${RAN}.sql"
                    rm -f "${SUBMIT_QUERY}"
                    touch "${SUBMIT_QUERY}"
                    echo "COPY (" >> ${SUBMIT_QUERY}
                    cat ${QUERY} >> ${SUBMIT_QUERY}
                    echo ") TO '/dev/null' (DELIMITER ',');" >> ${SUBMIT_QUERY}
                    echo "Start DuckDB Task at ${CUR_PATH}..."
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
                    echo "======================" >> $LOG_FILE
                    echo "End DuckDB Task..."
                    rm -f $OUT_FILE
                    rm -f ${SUBMIT_QUERY}
                else
                    SUBMIT_QUERY_1="${CUR_PATH}/${filename}_${RAN}_1.sql"
                    rm -f "${SUBMIT_QUERY_1}"
                    touch "${SUBMIT_QUERY_1}"
                    SUBMIT_QUERY_2="${CUR_PATH}/${filename}_${RAN}_2.sql"
                    rm -f "${SUBMIT_QUERY_2}"
                    touch "${SUBMIT_QUERY_2}"
                    ${COMMAND} -n -1 ${QUERY} >> ${SUBMIT_QUERY_1}
                    echo "COPY (" >> ${SUBMIT_QUERY_2}
                    TMP_QUERY=$(tail -n 1 ${QUERY})
                    echo ${TMP_QUERY/;/} >> ${SUBMIT_QUERY_2}
                    echo ") TO '/dev/null' (DELIMITER ',');" >> ${SUBMIT_QUERY_2}
                    echo "Processing ${CUR_PATH}..."
                    echo "Start DuckDB Task..."
                    current_task=1
                    while [[ ${current_task} -le 3 ]]
                        do
                            OUT_FILE="${CUR_PATH}/output.txt"
                            rm -f $OUT_FILE
                            touch $OUT_FILE
                            $duckdb -c ".open ${DATABASE}_db" -c ".timer on" -c ".read ${SUBMIT_QUERY_1}" -c ".read ${SUBMIT_QUERY_2}" | grep "Run Time (s): real" >> $OUT_FILE
                            awk 'BEGIN{sum=0;}{sum+=$5;} END{printf "Exec time(s): %f\n", sum;}' $OUT_FILE >> $LOG_FILE
                            current_task=$(($current_task+1))
                        done
                    echo "======================" >> $LOG_FILE
                    echo "End DuckDB Task..."
                    rm -f $OUT_FILE
                    rm -f $SUBMIT_QUERY_1
                    rm -f $SUBMIT_QUERY_2
                fi
            fi
        done
    fi
done