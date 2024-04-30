#
# Usage: ./smallrun.sh <yolo task>
#

#!/bin/bash

SCRIPT_PATH=$(PWD)/yolo_script
INF_RESULT_PATH=$SCRIPT_PATH/inference_results
INF_RESULT_FILENAME=$INF_RESULT_PATH/predict_$1_cpu.log
IMG_PATH=$SCRIPT_PATH/images

rm -rf $INF_RESULT_PATH
mkdir $INF_RESULT_PATH

declare -A command_model_map
command_model_map["detect"]="yolov8n.pt"
command_model_map["segment"]="yolov8n-seg.pt"
command_model_map["classify"]="yolov8n-cls.pt"
command_model_map["pose"]="yolov8n-pose.pt"

model=${command_model_map[$1]}


yolo $1 predict model=$model source=$IMG_PATH device=cpu 2>/dev/null | awk '$1 == "image" {print $1, $2, $NF}' >> $INF_RESULT_FILENAME

echo "<Inference statistics>"
stats=$(python3 $SCRIPT_PATH/cal.py $INF_RESULT_FILENAME)