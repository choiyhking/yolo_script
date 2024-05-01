#!/bin/bash
#
# CPU usage monitoring script for yolov8 
# Usage: ./kata_monitor.sh <yolo task>
#

output_file="kata_cpu_$1"
count=0

while true; do
    let count+=1
    
    usage=$(top -b -n 1 | grep qemu-system-aar | head -n 1 | awk '{print $9}')

    if ! ssh root@172.16.0.2 'ps aux | grep -q [y]olo'; then
      break;
    fi

    echo "$count $usage" >> ./cpu_results/"$output_file"
done

echo "<CPU statistics>"
cpu_stats=$(python3 cal_cpu.py ./cpu_results/${output_file})
echo "$cpu_stats" >> ./cpu_results/"$output_file"
echo "$cpu_stats"
echo ""
