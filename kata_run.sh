#!/bin/bash
#
# Usage: ./kata_run.sh
#

mkdir cpu_results 2>/dev/null
rm cpu_results/kata* 2>/dev/null

ssh root@172.16.0.2 "cd /yolo_script/; mkdir inference_results 2>/dev/null; rm inference_results/* 2>/dev/null"

tasks=("classify" "detect" "pose" "segment" "obb")

for task in "${tasks[@]}"; do
    echo "Start [[${task}]]"
    ./monitor.sh ${task} &
    ssh root@127.16.0.2 "export PATH=/usr/local/bin:$PATH; cd /yolo_script; ./smallrun.sh kata ${task}"

    sleep 10   
done

echo "All tasks finished successfully!!"
