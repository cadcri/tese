#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <libperf-jvmti.so path> <classpath> <classinput>"
    exit 1
fi

# Assign arguments to variables
jvmtisopath=$1
classpath=$2
classinput=$3

# Extract the base name of the class input for file naming
basename=$(basename "$classinput")
filename=$(echo "$basename" | awk -F. '{print $NF}')

# Define output files based on the class input
results_dir="results"
perf_data="${results_dir}/${filename}.data.jitted"
perf_folded="${results_dir}/${filename}.perf-folded"
flamegraph_svg="${results_dir}/${filename}.flamegraph.svg"

# Ensure the results directory exists
if [ ! -d "$results_dir" ]; then
    mkdir -p "$results_dir"
fi

# Run perf record
perf record -g -k mono java -cp "$classpath" -XX:+PreserveFramePointer -agentpath:"$jvmtisopath":perf-map-agent/out/libperfmap.so "$classinput"

# Inject JIT symbols into the perf data
perf inject --jit -i perf.data > "$perf_data"
rm perf.data

# Generate folded stack traces
perf script -F+srcline -i "$perf_data" | flamegraph/stackcollapse-perf.pl > "$perf_folded"

# Generate flame graph
flamegraph/flamegraph.pl "$perf_folded" > "$flamegraph_svg"

# Output the names of the generated files
echo "Generated files:"
echo "$perf_data"
echo "$perf_folded"
echo "$flamegraph_svg"
