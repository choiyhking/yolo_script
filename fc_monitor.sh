#!/bin/bash
#
# CPU usage monitoring script for yolov8 
# Usage: ./fc_monitor.sh <yolo task>
#

output_file="fc_cpu_$1"
count=0

while true; do
    let count+=1
    
    usage=$(top -b -n 1 | grep firecracker | head -n 1 | awk '{print $9}')

    if ! ssh -i ubuntu-22.04.id_rsa root@172.16.0.2 'ps aux | grep [y]olo'; then
      break;
    fi

    echo "$count $usage" >> ./cpu_results/"$output_file"
done

echo "<CPU statistics>"
cpu_stats=$(python3 cal_cpu.py ./cpu_results/${output_file})
echo "$cpu_stats" >> ./cpu_results/"$output_file"
echo "$cpu_stats"
echo ""
