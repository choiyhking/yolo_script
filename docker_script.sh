#
# Run yolov8 in contaienr and monitor CPU usage
# Usage: ./docker_script.sh
#

#!/bin/bash

# array
modes=("classify" "detect" "pose" "segment")
container_name="yolo-kata-test"

run_yolo_script() {
  sudo docker exec $container_name /bin/bash -c "/usr/src/ultralytics/yolo_script/smallrun.sh $1" &
  sleep 1
  ./monitor.sh $1 # this script will finish when yolo process finished
  echo "Stop container..."
  sudo docker stop $container_name
}

for mode in "${modes[@]}"; do
  echo "Start container..."
  sudo docker start $container_name
  echo $mode
  run_yolo_script "$mode"
  sleep 5
done