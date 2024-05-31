#!/bin/bash
#
# Usage: ./kata_run.sh
#

mkdir cpu_results
rm cpu_results/kata*

ssh root@172.16.0.2 "cd /yolo_script/; mkdir inference_results; rm inference_results/*"

tasks=("classify" "detect" "pose" "segment" "obb")

for task in "${tasks[@]}"; do
    echo "Start [[${task}]]..."
    ssh root@127.16.0.2 "/yolo_script/smallrun.sh ${task}" &
    ./kata_monitor.sh ${task}
    echo "completed!"

    sleep 10   
done

echo "All tasks finished successfully!!"
