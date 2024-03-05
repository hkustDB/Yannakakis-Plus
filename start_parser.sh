#!/bin/bash

nohup java -jar sparksql-plus-web-jar-with-dependencies.jar > parser.out 2>&1 &

sleep 1s
curl -X POST "http://localhost:8848/api/v1/parse?orderBy=fanout&desc=false&limit=1" -H "Content-Type: application/json" -d "@dummy_query.json" > /dev/null 2>&1
ret=$?

while [ $ret -ne 0 ]; do
    sleep 1s
    curl -X POST "http://localhost:8848/api/v1/parse?orderBy=fanout&desc=false&limit=1" -H "Content-Type: application/json" -d "@dummy_query.json" > /dev/null 2>&1
    ret=$?
done

echo "Parser started."