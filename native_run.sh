#!/bin/bash
#
# Usage: ./native_run.sh
#

# create key-value map
declare -A command_model_map
command_model_map["classify"]="yolov8n-cls.pt"
command_model_map["detect"]="yolov8n.pt"
command_model_map["pose"]="yolov8n-pose.pt"
command_model_map["segment"]="yolov8n-seg.pt"
command_model_map["obb"]="yolov8n-obb.pt"

mkdir inference_results pid_cpu_results
rm inference_results/native* pid_cpu_results/native*

for cmd in "${!command_model_map[@]}"; do
    model=${command_model_map[${cmd}]}
    inf_result_file="native_inf_${cmd}"
    
    echo "Start monitoring..."
    ./native_monitor.sh ${cmd} &

    echo "Start [[${cmd}]]..."
    # "2>/dev/null" is to remove model download progress bar
    yolo ${cmd} predict model=${model} source='./images' device=cpu 2>/dev/null | awk '$1 == "image" {print $1, $2, $NF}' >> ./inference_results/${inf_result_file}
   
    
    sleep 3 # sleep for monitoring script 

    echo "<Inference statistics>"
    inf_stats=$(python3 cal_inf.py ./inference_results/${inf_result_file})
    echo "${inf_stats}" >> ./inference_results/${inf_result_file}
    echo "${inf_stats}"
    echo ""

    sleep 10 
done

echo "All tasks finished successfully!!"
