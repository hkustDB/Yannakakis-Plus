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

INPUT_DIR=$1
PARALLEL=${2:-2}
HALF_PARALLEL=$(((PARALLEL + 1) / 2))
INPUT_DIR_PATH="${SCRIPT_PATH}/${INPUT_DIR}"

PG="/PATH_TO_PG/bin/psql"
DB="DATABASE"
port="PORT"

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
    if [ $dir != ${INPUT_DIR} ]; then
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
                    # extra settings for parallelism
                    echo "SET max_parallel_workers_per_gather=${PARALLEL};" >> ${SUBMIT_QUERY}
                    echo "SET max_parallel_workers=${HALF_PARALLEL};" >> ${SUBMIT_QUERY}
                    echo "SET work_mem = '${MEMOERY_SIZE}';" >> ${SUBMIT_QUERY}
                    echo "SET enable_nestloop=off;" >> ${SUBMIT_QUERY}

                    echo "COPY (" >> ${SUBMIT_QUERY}
                    cat ${QUERY} >> ${SUBMIT_QUERY}
                    echo ") TO '/dev/null' DELIMITER ',' CSV;" >> ${SUBMIT_QUERY}
                    echo "Start PG Task at ${QUERY}"
                    current_task=1
                    while [[ ${current_task} -le 10 ]]
                    do
                        echo "Current Task: ${current_task}"
                        OUT_FILE="${CUR_PATH}/output.txt"
                        rm -f $OUT_FILE
                        touch $OUT_FILE
                        timeout -s SIGKILL 30m $PG "-d" "${DB}" "-p" "${port}" "-c" "\timing" "-f" "${SUBMIT_QUERY}" | grep "Time: " >> $OUT_FILE
                        status_code=$?
                        if [[ ${status_code} -eq 137 ]]; then
                            echo "PG task timed out." >> $LOG_FILE
                            break
                        elif [[ ${status_code} -ne 0 ]]; then
                            echo "PG task failed." >> $LOG_FILE
                            break
                        else
                            awk 'BEGIN{sum=0;}{sum+=$2;} END{printf "Exec time(s): %f\n", sum;}' $OUT_FILE >> $LOG_FILE
                            cat $OUT_FILE >> $LOG_FILE
                        fi
                        current_task=$(($current_task+1))
                    done
                    echo "======================" >> $LOG_FILE
                    echo "End PG Task..."
                    rm -f $OUT_FILE
                    rm -f ${SUBMIT_QUERY}
                    rm -f ${SET_QUERY}
                else
                    SUBMIT_QUERY_1="${CUR_PATH}/${filename}_${RAN}_1.sql"
                    rm -f "${SUBMIT_QUERY_1}"
                    touch "${SUBMIT_QUERY_1}"
                    SUBMIT_QUERY_2="${CUR_PATH}/${filename}_${RAN}_2.sql"
                    rm -f "${SUBMIT_QUERY_2}"
                    touch "${SUBMIT_QUERY_2}"
                    # extra settings for parallelism
                    echo "SET max_parallel_workers_per_gather=${PARALLEL};" >> ${SUBMIT_QUERY_1}
                    echo "SET max_parallel_workers=${HALF_PARALLEL};" >> ${SUBMIT_QUERY_1}
                    echo "SET work_mem = '${MEMOERY_SIZE}';" >> ${SUBMIT_QUERY_1}
                    echo "SET enable_nestloop=off;" >> ${SUBMIT_QUERY_1}

                    echo "SET max_parallel_workers_per_gather=${PARALLEL};" >> ${SUBMIT_QUERY_2}
                    echo "SET max_parallel_workers=${HALF_PARALLEL};" >> ${SUBMIT_QUERY_2}
                    echo "SET work_mem = '${MEMOERY_SIZE}';" >> ${SUBMIT_QUERY_2}
                    echo "SET enable_nestloop = off;" >> ${SUBMIT_QUERY_2}

                    ${COMMAND} -n -1 ${QUERY} >> ${SUBMIT_QUERY_1}
                    echo "COPY (" >> ${SUBMIT_QUERY_2}
                    tail -n 1 ${QUERY} | sed 's/;//g' >> ${SUBMIT_QUERY_2}
                    echo ") TO '/dev/null' DELIMITER ',' CSV;" >> ${SUBMIT_QUERY_2}
                    echo "Start PG Task at ${QUERY}"
                    current_task=1
                    while [[ ${current_task} -le 10 ]]
                    do
                        echo "Current Task: ${current_task}"
                        OUT_FILE="${CUR_PATH}/output.txt"
                        rm -f $OUT_FILE
                        touch $OUT_FILE
                        timeout -s SIGKILL 30m $PG "-d" "${DB}" "-p" "${port}" "-c" "\timing" "-f" "${SUBMIT_QUERY_1}" "-f" "${SUBMIT_QUERY_2}" | grep "Time: " >> $OUT_FILE
                        status_code=$?
                        if [[ ${status_code} -eq 137 ]]; then
                           echo "PG task timed out." >> $LOG_FILE
                           break
                        elif [[ ${status_code} -ne 0 ]]; then
                            echo "PG task failed." >> $LOG_FILE
                            break
                        else
                            awk 'BEGIN{sum=0;}{sum+=$2;} END{printf "Exec time(s): %f\n", sum;}' $OUT_FILE >> $LOG_FILE
                            cat $OUT_FILE >> $LOG_FILE
                        fi
                        current_task=$(($current_task+1))
                    done
                    echo "======================" >> $LOG_FILE
                    echo "End PG Task..."
                    rm -f $OUT_FILE
                    rm -f $SUBMIT_QUERY_1
                    rm -f $SUBMIT_QUERY_2
                    rm -f $SET_QUERY
                fi
            fi
        done
    fi
done