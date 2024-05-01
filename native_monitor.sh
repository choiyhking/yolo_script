#!/bin/bash
#
# CPU usage monitoring script for yolov8 
# Usage: ./native_monitor.sh <yolo task>
#

output_file="native_cpu_$1"
count=0

sleep 2 

while true; do
    let count+=1
    
    usage=$(top -b -n 1 | grep yolo | head -n 1 | awk '{print $9}')
    
    echo "$count $usage" >> ./cpu_results/"$output_file"
done
