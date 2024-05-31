#!/bin/bash
#
# Usage: ./kvm_run.sh
#

mkdir cpu_results
rm cpu_results/kvm*

tasks=("classify" "detect" "pose" "segment" "obb")

ssh pi@192.168.122.45 "cd ~/yolo_script/; mkdir inference_results; rm inference_results/kvm*"

for task in "${tasks[@]}"; do
    echo "Start [[${task}]]..."
    ssh pi@192.168.122.45 "~/yolo_script/smallrun.sh ${task}" &
    ./monitor.sh kvm ${task}
    echo "completed!"

    sleep 10   
done

echo "All tasks finished successfully!!"
