#
# CPU usage monitoring script for yolov8 
# Usage: ./monitor.sh <yolo task>
#

#!/bin/bash

# $1: yolo task (e.g. detect, segment, ...)
output_file="cpu_usage_$1"

count=0
#start_time=$(date +%s)

rm -rf cpu_results
mkdir cpu_results

container_name="yolo-kata-test"

while true; do
    #current_time=$(date +%s)
    #elapsed_time=$((current_time - start_time))
    let count+=1
    
    # NATIVE
    # usage=$(top -b -n 1 | grep yolo | head -n 1 | awk '{print $9}')
    
    # DOCKER
    if [[ ! sudo docker exec $container_name "ps aux | grep -q yolo" ]]; then
	    break;
    fi
   
    usage=$(sudo docker stats --no-stream $container_name | awk '{if(NR>1) {gsub(/%/, "", $3); print $3}}')

    # KVM
    # FIRECRACKER

    # output
    echo "$count $usage" >> ./cpu_results/"$output_file"
done

echo "<CPU statistics>"
cpu_stats=$(python3 cal_cpu.py ./cpu_results/"$output_file")
echo "$cpu_stats" >> ./cpu_results/"$output_file"
echo "$cpu_stats"
echo ""