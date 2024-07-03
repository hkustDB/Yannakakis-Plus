#!/bin/bash

SCRIPT=$(readlink -f $0)
SCRIPT_PATH=$(dirname "${SCRIPT}")

source "${SCRIPT_PATH}/common.sh"
config_files=("${SCRIPT_PATH}/config.properties")

sparkJar="${SCRIPT_PATH}/target/spark-sql-test-1.0-SNAPSHOT-jar-with-dependencies.jar"
# graph path: /home/bchenba/graph_csv
# lsqb path: /home/data/lsqb/data/social-network-sf10-merged-fk
# TPC-H path: /home/data/TPC-H/100G
# job path: /home/bchenba/job_csv
dataPath="/home/bchenba/graph_csv"
park_home=$(prop ${config_files} "spark.home")
spark_submit="${spark_home}/bin/spark-submit"
repeat_count=$(prop ${config_files} "common.experiment.repeat")

# graph, tpch, lsqb
DATABASE=$1
INPUT_DIR=$2
INPUT_DIR_PATH="${SCRIPT_PATH}/${INPUT_DIR}"
PARALLEL=$3

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
                SCHEMA="${CUR_PATH}/${DATABASE}Schema.sql"

                echo "Start SparkSQL Task at ${QUERY}"
                current_task=1
                while [[ ${current_task} -le ${repeat_count} ]]
                do
                    echo "Current Task: ${current_task}"
                    OUT_FILE="${CUR_PATH}/output.txt"
                    rm -f $OUT_FILE
                    touch $OUT_FILE
                    timeout -s SIGKILL 8h ${spark_submit} --class SparkSQLRunner --master "local[${PARALLEL}]" --driver-memory 4G --executor-memory 4G --conf "spark.shuffle.service.removeShuffle=true" ${sparkJar} ${dataPath} "${QUERY}" "${SCHEMA}" ${PARALLEL} >> $OUT_FILE
                    status_code=$?
                    if [[ ${status_code} -eq 137 ]]; then
                        echo "SparkSQL task timed out." >> $LOG_FILE
                        break
                    elif [[ ${status_code} -ne 0 ]]; then
                        echo "SparkSQL task failed." >> $LOG_FILE
                        break
                    else
                        cat $OUT_FILE >> $LOG_FILE
                    fi
                    current_task=$(($current_task+1))
                done
                echo "======================" >> $LOG_FILE
                echo "End SparkSQL Task..."
                rm -f $OUT_FILE
            fi
        done
    fi
done