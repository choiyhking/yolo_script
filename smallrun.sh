#!/bin/bash
#
# Usage: ./smallrun.sh <yolo task>
#

IMG_PATH=/yolo_script/images
INF_RESULT_PATH=/yolo_script/inference_results
INF_RESULT_FILENAME=$INF_RESULT_PATH/docker_inf_$1

declare -A command_model_map
command_model_map["detect"]="yolov8n.pt"
command_model_map["segment"]="yolov8n-seg.pt"
command_model_map["classify"]="yolov8n-cls.pt"
command_model_map["pose"]="yolov8n-pose.pt"

model=${command_model_map[$1]}

yolo $1 predict model=$model source=$IMG_PATH device=cpu 2>/dev/null | awk '$1 == "image" {print $1, $2, $NF}' >> $INF_RESULT_FILENAME

echo "<Inference statistics>"
stats=$(python3 /yolo_script/cal_inf.py $INF_RESULT_FILENAME)
echo "$stats" >> "$INF_RESULT_FILENAME"
echo "$stats"
echo ""