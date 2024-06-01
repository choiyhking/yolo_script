#!/bin/bash
#
# Usage: ./native_run.sh 
#

declare -A model_map
model_map["classify"]="yolov8n-cls.pt"
model_map["detect"]="yolov8n.pt"
model_map["pose"]="yolov8n-pose.pt"
model_map["segment"]="yolov8n-seg.pt"
model_map["obb"]="yolov8n-obb.pt"

mkdir inference_results cpu_results
rm inference_results/native* cpu_results/native*

for task in "${!model_map[@]}"; do
    model=${model_map[${task}]}
    inf_result_file="native_inf_${task}"
    
    ./monitor.sh native ${task} &

    echo "Start [[${task}]]"
    # "2>/dev/null" is to remove model download progress bar
    yolo ${task} predict model=${model} source='./images' device=cpu 2>/dev/null | awk '$1 == "image" {print $1, $2, $NF}' >> ./inference_results/${inf_result_file}
   
    
    sleep 3 # sleep for monitoring script 

    echo "<Inference statistics>"
    inf_stats=$(python3 cal_inf.py ./inference_results/${inf_result_file})
    echo "${inf_stats}" >> ./inference_results/${inf_result_file}
    echo "${inf_stats}"
    echo ""

    sleep 10 
done

echo "All tasks finished successfully!!"
