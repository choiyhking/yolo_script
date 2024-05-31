#!/bin/bash
#
# Usage: ./fc_run.sh <environment>
#

mkdir cpu_results
rm cpu_results/fc*

tasks=("classify" "detect" "pose" "segment" "obb")

ssh -i ubuntu-22.04.id_rsa root@172.16.0.2 "cd /yolo_script/; mkdir inference_results; rm inference_results/*"

for mode in "${tasks[@]}"; do
    echo "Start [[${task}]]..."
    ssh -i ubuntu-22.04.id_rsa root@172.16.0.2 "/yolo_script/smallrun.sh fc ${task}" &
    ./monitor.sh fc ${task}
    echo "completed!"

    sleep 10   
done

echo "All tasks finished successfully!!"
