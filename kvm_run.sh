#!/bin/bash
#
# Usage: ./kvm_run.sh
#

mkdir cpu_results
rm cpu_results/kvm*

tasks=("classify" "detect" "pose" "segment" "obb")

sshpass -p '1' ssh -o 'StrictHostKeyChecking=no' test@192.168.122.239 "cd ~/yolo_script/; mkdir inference_results; rm inference_results/kvm*"

for task in "${tasks[@]}"; do
    echo "Start [[${task}]]..."
    sshpass -p '1' ssh -o 'StrictHostKeyChecking=no' test@192.168.122.239 "export PATH=/home/test/.local/bin:$PATH; cd ~/yolo_script; ./smallrun.sh kvm ${task}" &
    ./monitor.sh kvm ${task}
    echo "completed!"

    sleep 10   
done

echo "All tasks finished successfully!!"
