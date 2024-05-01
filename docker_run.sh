#!/bin/bash
#
# Usage: ./docker_run.sh
#

container_name="yolo-docker"

run_yolo_script() {
  sudo docker exec $container_name /bin/bash -c "$SCRIPT_PATH/smallrun.sh $1" &
  ./docker_monitor.sh $1 # this script will finish when yolo process finished
  echo "Stop container..."
  sudo docker stop $container_name >/dev/null 2>&1
}

rm cpu_results/docker*

SCRIPT_PATH=/yolo_script
INF_RESULT_PATH=$SCRIPT_PATH/inference_results
INF_RESULT_FILENAME=$INF_RESULT_PATH/docker_inf_$1

sudo docker start $container_name >/dev/null 2>&1
sudo docker exec $container_name /bin/bash -c "mkdir $INF_RESULT_PATH; rm -rf $INF_RESULT_PATH/*"
sudo docker stop $container_name >/dev/null 2>&1

modes=("classify" "detect" "pose" "segment")

for mode in "${modes[@]}"; do
  echo "Start container..."
  sudo docker start $container_name >/dev/null 2>&1
  sleep 3
  echo $mode
  run_yolo_script "$mode"
  sleep 5
done
