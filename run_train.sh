#!/bin/bash

declare -A command_model_map
command_model_map["detect"]="yolov8n.pt"
command_model_map["segment"]="yolov8n-seg.pt"
command_model_map["classify"]="yolov8n-cls.pt"
command_model_map["pose"]="yolov8n-pose.pt"

declare -A data_file_map
data_file_map["detect"]="coco128.yaml"
data_file_map["segment"]="coco128-seg.yaml"
data_file_map["classify"]="mnist160"
data_file_map["pose"]="coco8-pose.yaml"

epochs=5
batch=8

for cmd in "${!command_model_map[@]}"; do
    model=${command_model_map[$cmd]}
    data_file=${data_file_map[$cmd]}
    train_log_file="train_$cmd.log"
    for ((i=1; i <= 10; i++)); do
        yolo $cmd train data=$data_file model=$model epochs=$epochs batch=$batch | awk '/hours/{print $5; next} /inference/{print $4}' >> $train_log_file
        echo "$i is completed for $model!"
    done
done
