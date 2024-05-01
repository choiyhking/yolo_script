#!/bin/bash
#
# Usage: ./kvm_run.sh
#

mkdir cpu_results
rm cpu_results/kvm*

modes=("classify" "detect" "pose" "segment")

for mode in "${modes[@]}"; do
    echo "Start [[${mode}]]..."
    ssh yolo@192.168.122.225 '/yolo_script/smallrun.sh $mode' &
    ./kvm_monitor.sh $mode
    echo "completed!"

    sleep 10   
done

echo "All tasks finished successfully!!"

