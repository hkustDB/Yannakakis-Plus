#!/bin/bash

BOUND_FILE="bounds.txt"
SUMMARY_FILE="summary.csv"
OUTPUT_FILE="cost.csv"

rm -f ${OUTPUT_FILE}

if [[ ! -f "$BOUND_FILE" ]]; then
  echo "Error: Bound file $BOUND_FILE does not exist."
  exit 1
fi

if [[ ! -r "$BOUND_FILE" ]]; then
  echo "Error: Bound file $BOUND_FILE is not readable."
  exit 1
fi


calculate_cdf() {
  value=$1
  q0=$2
  q1=$3
  q2=$4
  total_count=$5

  if (( $(echo "$value <= $q0" | bc -l) )); then
    local cdf=$(echo "scale=6; 0.25 * ($value) / ($q0)" | bc -l)
    echo $cdf
  elif (( $(echo "$value <= $q1" | bc -l) )); then
    local cdf=$(echo "scale=6; 0.25 + 0.25 * ($value - $q0) / ($q1 - $q0)" | bc -l)
    echo $cdf
  elif (( $(echo "$value <= $q2" | bc -l) )); then
    local cdf=$(echo "scale=6; 0.5 + 0.25 * ($value - $q1) / ($q2 - $q1)" | bc -l)
    echo $cdf
  elif (( $(echo "$value <= $total_count" | bc -l) )); then
    local cdf=$(echo "scale=6; 0.75 + 0.25 * ($value - $q2) / ($total_count - $q2)" | bc -l)
    echo $cdf
  fi
}


declare -A bounds
while IFS=',' read -r table column lower_bound upper_bound extra; do
  if [[ -n "$table" && -n "$column" ]]; then
    bounds["$table,$column"]="$lower_bound,$upper_bound"
  fi
done < "$BOUND_FILE"


declare -A new_statistics
declare -A table_selectivity  
while IFS='|' read -r table column approx_unique q0 q1 q2 count extra; do
  key="$table,$column"

  if [[ -n "${bounds[$key]}" ]]; then
    IFS=',' read -r lower_bound upper_bound <<< "${bounds[$key]}"

    echo "Processing $table.$column with bounds $lower_bound and $upper_bound"

    if [[ -z "$lower_bound" || "$lower_bound" == "-" || -z "$upper_bound" || "$upper_bound" == "-" ]]; then
      selectivity=1
    else
      cdf_lower=$(calculate_cdf "$lower_bound" "$q0" "$q1" "$q2" "$count")
      cdf_upper=$(calculate_cdf "$upper_bound" "$q0" "$q1" "$q2" "$count")

      echo "CDF Lower: $cdf_lower, CDF Upper: $cdf_upper"

      selectivity=$(echo "$cdf_upper - $cdf_lower" | bc -l)
    fi

    table_selectivity["$table"]=$selectivity
  fi

  if [[ -n "${table_selectivity[$table]}" ]]; then
    selectivity=${table_selectivity[$table]}
  else
    selectivity=1
  fi

  new_count=$(printf "%.0f" $(echo "$count * $selectivity" | bc -l))
  new_unique=$(printf "%.0f" $(echo "$approx_unique * $selectivity" | bc -l))

  column_statistics="${new_count};${new_unique}"

  if [[ -n "${new_statistics[$table]}" ]]; then
    new_statistics[$table]+=",${column_statistics}"
  else
    new_statistics[$table]="${table},${column_statistics}"
  fi

done < "$SUMMARY_FILE"

for table in "${!new_statistics[@]}"; do
  echo "${new_statistics[$table]}" >> "$OUTPUT_FILE"
done

echo "New statistics have been written to ${OUTPUT_FILE}"
