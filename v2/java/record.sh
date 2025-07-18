rm -rf results
mkdir -p results
javac -d results SortNumbers.java

perf record -o results/perf.data java -cp results SortNumbers ../numbers.txt
perf annotate -i results/perf.data --show-total-period > results/perf_annotate.txt
grep -E '^\s*[0-9]+' results/perf_annotate.txt | sort -k1,1nr > results/perf_sorted.txt
