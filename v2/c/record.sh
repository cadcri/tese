rm -rf results
mkdir -p results
gcc -g -O0 main.c -o results/main

perf record -o results/perf.data results/main ../numbers.txt
perf annotate -i results/perf.data --stdio --source -n > results/perf_annotate.txt

gawk '
/^[[:space:]]*:[[:space:]]+[0-9]+/ {
    if (line != "") {
        printf "%10d : %s\n", sum, line
    }
    sum = 0
    match($0, /^[[:space:]]*:[[:space:]]+([0-9]+)[[:space:]]+(.*)$/, arr)
    lineno = arr[1]
    code = arr[2]
    line = lineno "   " code
    next
}

/^[[:space:]]*[0-9]+[[:space:]]*:/ {
    gsub(/[[:space:]]+/, "", $1)
    sum += $1
}

END {
    if (line != "") {
        printf "%10d : %s\n", sum, line
    }
}
' results/perf_annotate.txt > results/perf_total.txt

sort -k1,1nr results/perf_total.txt > results/perf_sorted.txt