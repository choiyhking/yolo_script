#!/bin/bash
#
# Usage: ./docker_run.sh
#

container_name="yolo-docker"

do_smallrun() {
  ./monitor.sh docker $1 &
  sudo docker exec $container_name /bin/bash -c "cd /yolo_script; ./smallrun.sh docker $1"
  #echo "Stop container..."
  sudo docker stop $container_name >/dev/null 2>&1
}

mkdir cpu_results 2>/dev/null
rm cpu_results/docker* 2>/dev/null

INF_RESULT_PATH=/yolo_script/inference_results

sudo docker start $container_name >/dev/null 2>&1
sudo docker exec $container_name /bin/bash -c "mkdir $INF_RESULT_PATH 2>/dev/null; rm -rf $INF_RESULT_PATH/* 2>/dev/null"
sudo docker stop $container_name >/dev/null 2>&1
sleep 10

tasks=("classify" "detect" "pose" "segment" "obb")

for task in "${tasks[@]}"; do
  #echo "Start container..."
  sudo docker start $container_name >/dev/null 2>&1
  echo "Start [[${task}]]"
  do_smallrun ${task}
  sleep 10
done

echo "All tasks finished successfully!!"
