#!/bin/bash
#
# Usage: ./kata_run.sh
#

mkdir cpu_results
rm cpu_results/kata*

modes=("classify" "detect" "pose" "segment")

for mode in "${modes[@]}"; do
    echo "Start [[${mode}]]..."
    ssh root@127.16.0.2 '/yolo_script/smallrun.sh $1' &
    ./kata_monitor.sh $mode
    echo "completed!"

    sleep 10   
done

echo "All tasks finished successfully!!"

