#!/bin/bash
#
# Usage: ./smallrun.sh <environment> <yolo task>
#

IMG_PATH=/yolo_script/images
INF_RESULT_PATH=/yolo_script/inference_results
INF_RESULT_FILENAME=${INF_RESULT_PATH}/$1_inf_$2

declare -A model_map
model_map["classify"]="yolov8n-cls.pt"
model_map["detect"]="yolov8n.pt"
model_map["segment"]="yolov8n-seg.pt"
model_map["pose"]="yolov8n-pose.pt"
model_map["obb"]="yolov8n-obb.pt"

model=${model_map[$2]}

yolo $2 predict model=${model} source=${IMG_PATH} device=cpu 2>/dev/null | awk '$1 == "image" {print $1, $2, $NF}' >> ${INF_RESULT_FILENAME}

echo "<Inference statistics>"
stats=$(python3 /yolo_script/cal_inf.py ${INF_RESULT_FILENAME})
echo "${stats}" >> "${INF_RESULT_FILENAME}"
echo "${stats}"
echo ""
