#!/bin/bash

SIZE=$1
dbgen="./dbgen"
export DSS_PATH="/home/bchenba/TPC-H/500G/orders"

echo "Start generate orders..."
i=0
while [ $i -ne $SIZE ]
do
        i=$(($i+1))
        ${dbgen} -s $SIZE -S $i -C $SIZE -T O -v
done
echo "Finish orders"

echo "Start generate lineitem..."
export DSS_PATH="/home/bchenba/TPC-H/500G/lineitem"
i=0
while [ $i -ne $SIZE ]
do
        i=$(($i+1))
        ${dbgen} -s $SIZE -S $i -C $SIZE -T L -v
done
echo "Finish lineitem"