#!/bin/bash
#
# Usage: ./native_run.sh 
#

mkdir inference_results cpu_results 2>/dev/null
rm inference_results/native* cpu_results/native* 2>/dev/null

tasks=("classify" "detect" "pose" "segment" "obb")

for task in "${tasks[@]}"; do
    echo "Start [[$task]]"
    ./monitor.sh native ${task} &
    ./smallrun.sh native ${task}

    sleep 10 
done

echo "All tasks finished successfully!!"
