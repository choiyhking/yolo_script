#!/bin/bash
#predict
declare -A command_model_map
command_model_map["detect"]="yolov8n.pt"
command_model_map["segment"]="yolov8n-seg.pt"
command_model_map["classify"]="yolov8n-cls.pt"
command_model_map["pose"]="yolov8n-pose.pt"

for cmd in "${!command_model_map[@]}"; do
    model=${command_model_map[$cmd]}
    pre_log_file="predict_$cmd.log"
        yolo $cmd predict model=$model source='/home/junhyuk/images/images/' | awk '/inference/{print $4}' >> $pre_log_file
        echo "$cmd is completed for $model!"
done
# 각 awk 구문 각 image마다 inference time 각각 뽑아내는 구문으로 고쳐야함.
# 각 pc 환경마다 data 경로 잘 파악하고 source 바꾸기.

