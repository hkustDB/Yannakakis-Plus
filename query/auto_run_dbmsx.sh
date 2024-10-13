#!/bin/bash

SCRIPT=$(readlink -f $0)
SCRIPT_PATH=$(dirname "${SCRIPT}")

export DBMSX_PWD="PASSWORD"
dbmsx="/PATH_TO_DBMSX/bin/mysql"
dbmsx_config="CONFIGS"

INPUT_DIR=$1
INPUT_DIR_PATH="${SCRIPT_PATH}/${INPUT_DIR}"

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

                echo "Start DBMS_X Task at ${QUERY}"
                current_task=1
                while [[ ${current_task} -le 10 ]]
                do
                    echo "Current Task: ${current_task}"
                    OUT_FILE="${CUR_PATH}/output.txt"
                    rm -f $OUT_FILE
                    touch $OUT_FILE
                    timeout -s SIGKILL 5m ${dbmsx} ${dbmsx_config} < "${QUERY}" | grep "row in set" >> $OUT_FILE
                    status_code=$?
                    if [[ ${status_code} -eq 137 ]]; then
                        echo "DBMS_X task timed out." >> $LOG_FILE
                        break
                    elif [[ ${status_code} -ne 0 ]]; then
                        echo "DBMS_X task failed." >> $LOG_FILE
                        break
                    else
                        cat $OUT_FILE >> $LOG_FILE
                    fi
                    current_task=$(($current_task+1))
                done
                echo "======================" >> $LOG_FILE
                echo "End DBMS_X Task..."
                rm -f $OUT_FILE
            fi
        done
    fi
done