#!/bin/bash

DATABASE=$1
duckdb="/opt/homebrew/bin/duckdb"

echo "DuckDB init ${DATABSE} database..."
$duckdb -c ".open ${DATABASE}_db" -c ".read load_${DATABASE}.sql"
echo "Finish."
