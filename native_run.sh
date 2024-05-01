#!/bin/bash
#
# Usage: ./native_run.sh
#

# create key-value map
declare -A command_model_map
command_model_map["detect"]="yolov8n.pt"
command_model_map["segment"]="yolov8n-seg.pt"
command_model_map["classify"]="yolov8n-cls.pt"
command_model_map["pose"]="yolov8n-pose.pt"


rm inference_results/native* cpu_results/native*
mkdir inference_results cpu_results


for cmd in "${!command_model_map[@]}"; do
    model=${command_model_map[$cmd]}
    result_file="native_inf_${cmd}"
    
    echo "Monitoring start..."
    ./native_monitor.sh $cmd &
    PID=$!

    echo "Start [[${cmd}]]..."
    # "2>/dev/null" is to remove model download progress bar
    yolo $cmd predict model=$model source='./images' device=cpu 2>/dev/null | awk '$1 == "image" {print $1, $2, $NF}' >> ./inference_results/$result_file
    
    kill $PID
    echo "completed!"

    echo "<Inference statistics>"
    inf_stats=$(python3 cal_inf.py ./inference_results/$result_file)
    echo "$inf_stats" >> ./inference_results/$result_file
    echo "$inf_stats"
    echo ""

    echo "<CPU statistics>"
    cpu_stats=$(python3 cal_cpu.py ./cpu_results/native_cpu_$cmd)
    echo "$cpu_stats" >> ./cpu_results/native_cpu_$cmd
    echo "$cpu_stats"
    echo ""

    sleep 10   
done

echo "All tasks finished successfully!!"

