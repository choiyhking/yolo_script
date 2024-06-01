#!/bin/bash
#
# CPU usage monitoring script
# Usage: ./monitor.sh <environment> <yolo task>
#

# sleep for yolo pre-processing
sleep 20 

declare -A pname_map
pname_map["native"]="yolo"
pname_map["docker"]="yolo"
pname_map["kvm"]="qemu-system-aar"
pname_map["fc"]="firecracker"
pname_map["kata"]="qemu-system-aar"

declare -A setting_map
setting_map["classify"]="TIME_SLICE=10; INTERVAL=0"
setting_map["detect"]="TIME_SLICE=30; INTERVAL=30"
setting_map["pose"]="TIME_SLICE=30; INTERVAL=30"
setting_map["segment"]="TIME_SLICE=40; INTERVAL=30"
setting_map["obb"]="TIME_SLICE=40; INTERVAL=30"

PNAME=${pname_map[$1]}
eval ${setting_map[$2]}
ITER=3	
sum=0

echo "Start CPU monitoring..."
for i in $(seq ${ITER})
do
	pid_result=$(pidstat -p $(pgrep ${PNAME}) ${TIME_SLICE} 1 &)
    	mpstat -P ALL ${TIME_SLICE} 1 >> ./cpu_results/"$1_mp_$2" 
	echo "${pid_result}" >> ./cpu_results/"$1_pid_$2"
	sum=$(echo "${sum} + $(echo "${pid_result}" | grep Average | awk '{print $8}')" | bc)
        sleep ${INTERVAL} 
done

# show average of CPU usage
echo "<CPU usage average>"
echo "scale=3; ${sum} / ${ITER}" | bc
echo ""
