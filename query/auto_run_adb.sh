#!/bin/bash


SCRIPT=$(readlink -f $0)
SCRIPT_PATH=$(dirname "${SCRIPT}")

OPT=$1
export MYSQL_PWD="Cbn123456"
mysql="/opt/homebrew/bin/mysql"
mysql1_config="-ham-bp1rz4j2kfzh2ly2i90650o.ads.aliyuncs.com -P3306 -uadbtest -Dchampion -Acc -vvv"
mysql4_config="-hamv-bp1112t3l1u3l4zv100001847o.ads.aliyuncs.com -P3306 -uadbtest -Dchampion -Acc -vvv"

INPUT_DIR=$2
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

                echo "Start DuckDB Task at ${QUERY}"
                current_task=1
                while [[ ${current_task} -le 1 ]]
                do
                    echo "Current Task: ${current_task}"
                    OUT_FILE="${CUR_PATH}/output.txt"
                    rm -f $OUT_FILE
                    touch $OUT_FILE
                    if [ $OPT -eq 1 ]
                    then
                        timeout -s SIGKILL 8h ${mysql} ${mysql1_config} < "${QUERY}" | grep "row in set" | tail -n 1 >> $OUT_FILE
                    else
                        timeout -s SIGKILL 8h ${mysql} ${mysql4_config} < "${QUERY}" | grep "row in set" | tail -n 1 >> $OUT_FILE
                    fi
                    status_code=$?
                    if [[ ${status_code} -eq 137 ]]; then
                        echo "mysql task timed out." >> $LOG_FILE
                        break
                    elif [[ ${status_code} -ne 0 ]]; then
                        echo "mysql task failed." >> $LOG_FILE
                        break
                    else
                        cat $OUT_FILE >> $LOG_FILE
                    fi
                    current_task=$(($current_task+1))
                done
                echo "======================" >> $LOG_FILE
                echo "End MySQL Task..."
                rm -f $OUT_FILE
            fi
        done
    fi
done