#!/bin/bash
#
# Usage: ./docker_run.sh
#

container_name="yolo-docker"

run_yolo_script() {
  sudo docker exec $container_name /bin/bash -c "$SCRIPT_PATH/smallrun.sh $1" &
  ./monitor.sh docker $1 
  echo "Stop container..."
  sudo docker stop $container_name >/dev/null 2>&1
}

mkdir cpu_results
rm cpu_results/docker*

SCRIPT_PATH=/yolo_script
INF_RESULT_PATH=$SCRIPT_PATH/inference_results

sudo docker start $container_name >/dev/null 2>&1
sudo docker exec $container_name /bin/bash -c "mkdir $INF_RESULT_PATH; rm -rf $INF_RESULT_PATH/*"
sudo docker stop $container_name >/dev/null 2>&1

tasks=("classify" "detect" "pose" "segment" "obb")

for mode in "${tasks[@]}"; do
  echo "Start container..."
  sudo docker start $container_name >/dev/null 2>&1
  echo "[[${task}]]"
  run_yolo_script ${task}
  sleep 10
done

echo "All tasks finished successfully!!"
