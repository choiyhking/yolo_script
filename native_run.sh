#!/bin/bash
#
# Usage: ./native_run.sh 
#

mkdir inference_results cpu_results 2>/dev/null
rm inference_results/native* cpu_results/native* 2>/dev/null

for task in "${!model_map[@]}"; do
    echo "Start [[$task]]"
    ./monitor.sh native ${task} &
    ./smallrun.sh native ${task}

    sleep 10 
done

echo "All tasks finished successfully!!"
