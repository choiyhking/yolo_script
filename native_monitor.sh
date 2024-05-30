#!/bin/bash
#
# CPU usage monitoring script for NATIVE 
# Usage: ./native_monitor.sh <yolo task>
#

# sleep for yolo pre-processing
sleep 15 

TIME_SLICE=10
ITER=3
temp=0

for i in $(seq ${ITER})
do
	pid_result=$(pidstat -p $(pgrep yolo) ${TIME_SLICE} 1 &)
    	mpstat -P ALL ${TIME_SLICE} 1 >> ./pid_cpu_results/"native_mp_$1" 
	echo "${pid_result}" >> ./pid_cpu_results/"native_pid_$1"
	temp=$(echo "${temp} + $(echo "${pid_result}" | grep Average | awk '{print $8}')" | bc)
	sleep 3
done

# show average of CPU usage
echo "<CPU usage average>"
echo "scale=3; ${temp} / ${ITER}" | bc
echo ""
