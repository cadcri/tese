#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <perf-folded-file> <pattern>"
    exit 1
fi

# Assign arguments to variables
perf_folded_file=$1
pattern=$2

# Calculate total samples
total=$(awk '{print $NF}' "$perf_folded_file" | awk '{sum += $1} END {printf "%.0f\n", sum}')

# Calculate samples for the given pattern
lists=$(grep "$pattern" "$perf_folded_file" | awk '{print $NF}' | awk '{sum += $1} END {printf "%.0f\n", sum}')

# Calculate percentage
percentage=$(awk "BEGIN {printf \"%.2f\", ($lists / $total) * 100}")

# Output the result
echo "$lists is $percentage% of $total"
