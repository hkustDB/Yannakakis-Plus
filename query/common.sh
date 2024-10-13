#!/bin/bash

function err {
    echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

function prop {
    config_files=$1
    for config_file in ${config_files[@]}; do
        # search the property key in config file if file exists
        if [[ -f ${config_file} ]]; then
            result=$(grep "^\s*$2=" $config_file | tail -n1 | cut -d '=' -f2)
            if [[ -n ${result} ]]; then
                break
            fi
        fi
    done

    if [[ -n ${result} ]]; then
        echo ${result}
    elif [[ $# -gt 2 ]]; then
        echo $3
    else
        err "ERROR: unable to load property $2 in ${config_files}"
        exit 1
    fi
}

function prop2 {
    config_files=$1
    for config_file in ${config_files[@]}; do
        # search the property key in config file if file exists
        if [[ -f ${config_file} ]]; then
            result=$(grep "^\s*$2=" $config_file | tail -n1 | cut -d '=' -f2)
            if [[ -n ${result} ]]; then
                break
            fi
        fi
    done

    if [[ -n ${result} ]]; then
        echo ${result}
    elif [[ $# -gt 2 ]]; then
        prop "$1" "$3"
    else
        err "ERROR: unable to load property $2 in ${config_files}"
        exit 1
    fi
}

function assert {
    if [[ $? -ne 0 ]]; then
        err "ERROR: ${1:-'assertion failed.'}"
        exit 1
    fi
}