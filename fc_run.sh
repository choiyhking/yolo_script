#!/bin/bash
#
# Usage: ./fc_run.sh
#

mkdir cpu_results
rm cpu_results/fc*

modes=("classify" "detect" "pose" "segment")

ssh -i ubuntu-22.04.id_rsa root@127.16.0.2 'cd /yolo_script/; mkdir inference_results; rm inference_results/fc*'

for mode in "${modes[@]}"; do
    echo "Start [[${mode}]]..."
    ssh -i ubuntu-22.04.id_rsa root@127.16.0.2 '/yolo_script/smallrun.sh $1' &
    ./fc_monitor.sh $mode
    echo "completed!"

    sleep 10   
done

echo "All tasks finished successfully!!"

