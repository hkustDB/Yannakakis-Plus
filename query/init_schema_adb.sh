#!/bin/bash

SCRIPT=$(readlink -f $0)
SCRIPT_PATH=$(dirname "${SCRIPT}")

OPT=$1
mysql="/opt/homebrew/bin/mysql"
mysql1_config="-ham-bp18dp9cz08a6d32s90650o.ads.aliyuncs.com -P3306 -uadbtest -pAdbtest321123 -Dchampion -Acc -vvv"
mysql4_config="-hamv-bp1112t3l1u3l4zv100001847o.ads.aliyuncs.com -P3306 -uadbtest -pAdbtest321123 -Dchampion -Acc -vvv"

if [ $OPT -eq 1 ]
then
    ${mysql} ${mysql1_config} < "${SCRIPT_PATH}/load_tpch_adb.sql"
else
    ${mysql} ${mysql4_config} < "${SCRIPT_PATH}/load_tpch_adb.sql"
fi
