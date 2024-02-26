#!/bin/bash

DATABASE=$1

duckdb="/home/bchenba/duckdb"

echo "DuckDB init ${DATABASE} database..."
$duckdb -c ".open ${DATABASE}_db" -c ".read load_${DATABASE}.sql"
echo "Finish."