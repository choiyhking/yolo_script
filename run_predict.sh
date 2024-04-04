# In one environment(e.g. native), execute yolo PREDICT for every tasks(detect, segment, ...).
# Usage: ./run_predict.sh

#!/bin/bash

# create key-value map
declare -A command_model_map
command_model_map["detect"]="yolov8n.pt"
command_model_map["segment"]="yolov8n-seg.pt"
command_model_map["classify"]="yolov8n-cls.pt"
command_model_map["pose"]="yolov8n-pose.pt"

# You have to check and modify this option!!
# "cpu" or "0"(GPU)
device_option=0

if [ "$device_option" == "cpu" ]; then
    echo "Current device option is CPU."
elif [ "$device_option" == 0 ]; then
    echo "Current device option is GPU."
else
    echo "Wrong device option."
    exit 1
fi

echo "Did you check device option? (yes/no)"
read answer

if [ "$answer" = "yes" ]; then
    echo "Continuing with the process..."
else
    echo "Exiting the script."
    exit 1
fi
echo ""

for cmd in "${!command_model_map[@]}"; do
    model=${command_model_map[$cmd]}
    
    if [ "$device_option" == "cpu" ]; then
        result_file="predict_${cmd}_cpu.log"
    else # GPU
	result_file="predict_${cmd}_gpu.log"
    fi
    
    echo "Start [[${cmd}]]..."
    # "2>/dev/null" is to remove model download progress bar
    yolo $cmd predict model=$model source='./images' device=$device_option 2>/dev/null | awk '$1 == "image" {print $1, $2, $NF}' >> $result_file
    echo "completed!"

    echo "<Statistics>"
    stats=$(python3 cal.py $result_file)
    echo "$stats" >> $result_file
    echo "$stats"
    echo ""
done

echo "All tasks finished successfully!!"
