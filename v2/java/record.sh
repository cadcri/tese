rm -rf results
mkdir -p results
javac -d results QuickSort.java

perf record -o results/perf.data -g -k mono java -cp results -XX:+PreserveFramePointer -agentpath:/home/basto/lib64/libperf-jvmti.so QuickSort ../numbers.txt
perf inject --jit -i results/perf.data > results/perf.data.jitted
perf annotate -i results/perf.data.jitted --stdio --source -n > results/perf_annotate.txt

awk '
/^[[:space:]]*:[[:space:]]+[0-9]+/ {
    # Save previous line
    if (line_text != "") {
        count[line_text] += sum
    }
    # Start new source line
    sum = 0
    sub(/^[[:space:]]*:[[:space:]]+[0-9]+[[:space:]]+/, "", $0)
    line_text = $0
    next
}

/^[[:space:]]*[0-9]+[[:space:]]*:/ {
    count_num = $1
    gsub(/[[:space:]]+/, "", count_num)
    sum += count_num
}

END {
    if (line_text != "") {
        count[line_text] += sum
    }
    for (code in count) {
        printf "%10d : %s\n", count[code], code
    }
}
' results/perf_annotate.txt > results/perf_total.txt

sort -k1,1nr results/perf_total.txt > results/perf_sorted.txt
