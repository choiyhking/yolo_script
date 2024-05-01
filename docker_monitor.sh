#!/bin/bash
#
# CPU usage monitoring script for yolov8 
# Usage: ./monitor.sh <yolo task>
#


output_file="docker_cpu_$1"
count=0

while true; do
    let count+=1
     
    if ! sudo docker exec $container_name ps aux | grep -q yolo; then
	    break;
    fi
   
    usage=$(sudo docker stats --no-stream $container_name | awk '{if(NR>1) {gsub(/%/, "", $3); print $3}}')
    echo "$count $usage" >> ./cpu_results/"$output_file"
done

echo "<CPU statistics>"
cpu_stats=$(python3 cal_cpu.py ./cpu_results/${output_file})
echo "$cpu_stats" >> ./cpu_results/"$output_file"
echo "$cpu_stats"
echo ""
