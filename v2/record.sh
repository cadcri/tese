#!/bin/bash

cd c
./record.sh
cd ..

cd java
./record.sh
cd ..


#!/bin/bash

file2="c/results/perf_sorted.txt"
file1="java/results/perf_sorted.txt"
output="result.txt"

> "$output"

awk -v f1="$file1" '
BEGIN {
	# Read counts from file1.txt (QuickSort.java lines only)
	while ((getline < f1) > 0) {
		if ($0 ~ /^[[:space:]]*[0-9]+[[:space:]]*:[[:space:]]*QuickSort\.java:[0-9]+/) {
			match($0, /^[[:space:]]*([0-9]+)[[:space:]]*:[[:space:]]*QuickSort\.java:([0-9]+)/, m)
			qs_counts[m[2]] += m[1]
		}
	}
	close(f1)
}

{
	# Match Java lines (format: count : line#   code)
	if ($0 ~ /^[[:space:]]*[0-9]+[[:space:]]*:[[:space:]]*[0-9]+[[:space:]]+/) {
		match($0, /^[[:space:]]*([0-9]+)[[:space:]]*:[[:space:]]*([0-9]+)/, m)
		original = m[1]
		line = m[2]
		added = qs_counts[line] + 0
		diff = original - added
		sub(/^[[:space:]]*[0-9]+[[:space:]]*:[[:space:]]*[0-9]+[[:space:]]+/, "")
		formatted = sprintf("%6d %6d %6d : %3d   %s", diff, original, added, line, $0)
		if (line in qs_counts)
			qs_lines[++n_qs] = formatted
		else
			other_java[++n_other] = formatted
	}
	# All other lines go to c_lines
	else {
		c_lines[++n_c] = $0
	}
}

END {
	# First: QuickSort.java lines
	for (i = 1; i <= n_qs; i++) print qs_lines[i]

	# Then: sorted non-QuickSort Java lines
	asort(other_java)
	for (i = 1; i <= n_other; i++) print other_java[i]

	# Finally: sorted C or unknown lines
	asort(c_lines)
	for (i = 1; i <= n_c; i++) print c_lines[i]
}
' "$file2" >> "$output"

grep -v 'QuickSort\.java' "$file1" >> "$output"