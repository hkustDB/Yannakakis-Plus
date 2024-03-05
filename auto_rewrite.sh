#!/bin/bash

python="/usr/bin/python3"

SCRIPT=$(readlink -f $0)
SCRIPT_PATH=$(dirname "${SCRIPT}")

INPUT_DIR="query/$2"
INPUT_DIR_PATH="${SCRIPT_PATH}/${INPUT_DIR}"
DDL_NAME=$1
g=${3:-D}
b=${4:-2}
m=${5:-0}

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
            result_file="${CUR_PATH}/rewrite_time.txt"
            rm -f $result_file
            touch $result_file
            filename="${file%.*}"
            IsSuffix ${file}
            ret=$?
            if [ $ret -eq 0 ] && [ ${filename} = "query" ]
            then
                $python main.py "${CUR_PATH}" "${DDL_NAME}" -b "$b" -m "$m" -g "$g" | grep "Rewrite time(s)" >> $result_file
            fi
        done
    fi
done