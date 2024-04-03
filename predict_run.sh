#!/bin/bash

declare -A command_model_map
command_model_map["detect"]="yolov8n.pt"
command_model_map["segment"]="yolov8n-seg.pt"
command_model_map["classify"]="yolov8n-cls.pt"
command_model_map["pose"]="yolov8n-pose.pt"

for cmd in "${!command_model_map[@]}"; do
    model=${command_model_map[$cmd]}
    pre_log_file="predict_$cmd.log"
    for ((i=1; i <= 10; i++)); do
        yolo $cmd predict model=$model source='/home/junhyuk/images/images/' | awk '/inference/{print $4}' >> $pre_log_file
        echo "$i is completed for $model!"
    done
done
#test
