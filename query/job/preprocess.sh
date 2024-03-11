#!/bin/bash

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

function read_dir(){
    ddl_file="$1/job.ddl"
    for file in `ls $1`       
    do
        if [ -d $1"/"$file ]  
        then
            cp -rf $ddl_file "$1/$file/"
        else
            IsSuffix ${file}
            ret=$?
            if [ $ret -eq 0 ]
            then
                filename="${file%.*}"
                file_dir="$1/${filename}"
                mkdir $file_dir
                mv $file "$file_dir/query.sql"
                cp $ddl_file $file_dir
            fi
        fi
    done
}   

SCRIPT=$(readlink -f $0)
SCRIPT_PATH=$(dirname "${SCRIPT}")
read_dir $SCRIPT_PATH
