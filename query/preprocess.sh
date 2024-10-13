#!/bin/bash

# Define the directory where DuckDB is located
duckdb="/PATH_TO_DUCKDB"

DATABASE=$1

# Define the output file
SUMMARY_FILE="summary.csv"
rm -f $SUMMARY_FILE

# Array of TPC-H table names
TABLES=("lineitem" "orders" "customer" "nation" "region" "part" "supplier" "partsupp")

# Function to extract specific columns from a table summary and append to the summary file
extract_columns() {
  local table=$1
  local temp_file=$(mktemp)
  $duckdb -c ".open ${DATABASE}_db" -c ".mode csv" -c ".print" -c "SUMMARIZE ${table};" > $temp_file
  
  # Skip the first row (header) of each table summary, extract required fields and append to summary file
  awk -F, -v table_name="${table}" 'BEGIN {
    OFS = "|"
  }
  NR > 2 {
    print table_name, $1, $5, $8, $9, $10, $11, $11
  }' $temp_file >> $SUMMARY_FILE

  # Remove the temporary file
  rm $temp_file
}

# Loop over each table to summarize and extract columns
for table in "${TABLES[@]}"; do
  extract_columns $table
done

echo "Extracted columns have been written to ${SUMMARY_FILE}"

./gen_cost.sh
