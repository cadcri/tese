rm -rf results
mkdir -p results
gcc main.c -o results/main
perf record -o results/perf.data results/main ../numbers.txt
perf annotate -i results/perf.data --show-total-period > results/perf_annotate.txt
grep -E '^\s*[0-9]+' results/perf_annotate.txt | sort -k1,1nr > results/perf_sorted.txt