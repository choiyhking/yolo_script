#!/bin/bash
#
# Usage: ./kvm_run.sh
#

mkdir cpu_results 2>/dev/null
rm cpu_results/kvm* 2>/dev/null

tasks=("classify" "detect" "pose" "segment" "obb")

sshpass -p '1' ssh -o 'StrictHostKeyChecking=no' test@192.168.122.239 "cd ~/yolo_script/; mkdir inference_results 2>/dev/null; rm inference_results/kvm* 2>/dev/null"

for task in "${tasks[@]}"; do
    echo "Start [[${task}]]"
    ./monitor.sh kvm ${task} &
    sshpass -p '1' ssh -o 'StrictHostKeyChecking=no' test@192.168.122.239 "export PATH=/home/test/.local/bin:$PATH; cd ~/yolo_script; ./smallrun.sh kvm ${task}"
    
    sleep 10   
done

echo "All tasks finished successfully!!"
