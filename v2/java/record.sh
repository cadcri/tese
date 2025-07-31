rm -rf results
mkdir -p results
javac -d results QuickSort.java

perf record -o results/perf.data -g -k mono java -cp results -XX:+PreserveFramePointer -agentpath:/home/basto/lib64/libperf-jvmti.so QuickSort ../numbers.txt
perf inject --jit -i results/perf.data > results/perf.data.jitted
perf annotate -i results/perf.data.jitted --stdio --source -n > results/perf_annotate.txt

awk '
# Match lines like: ": 80  java/lang/StringCoding.java:57"
/^ *: *[0-9]+[ \t]+[^:]+:[0-9]+/ {
    if (line_file != "") {
        # Save the previous line
        key = line_file ":" line_num
        if (line_text != "") {
            key = key " : " line_text
        }
        count[key] += sum
    }
    sum = 0

    # Extract filename and line number
    match($0, /[^:]+:([0-9]+)/, m)
    line_num = m[1]
    match($0, /[0-9]+[ \t]+([^:]+):[0-9]+/, f)
    line_file = f[1]

    # Extract line text (if any)
    sub(/^ *: *[0-9]+[ \t]+[^:]+:[0-9]+/, "", $0)
    gsub(/^ +/, "", $0)
    line_text = $0
    next
}

# Match lines with instruction counts
/^[ \t]*[0-9]+[ \t]*:/ {
    count_num = $1
    gsub(/[ \t]+/, "", count_num)
    sum += count_num
}

END {
    if (line_file != "") {
        key = line_file ":" line_num
        if (line_text != "") {
            key = key " : " line_text
        }
        count[key] += sum
    }

    for (code in count) {
        printf "%10d : %s\n", count[code], code
    }
}
' results/perf_annotate.txt > results/perf_total.txt

sort -k1,1nr results/perf_total.txt > results/perf_sorted.txt
