#!/usr/bin/env bash

# Start the perf profiler
file ./build/template
perf record -o perf.data -e cycles:u -g -- ./build/template ./data/input.txt 2
perf annotate -i perf.data --stdio > build/perf-annotate.txt
perf report > build/perf-report.txt