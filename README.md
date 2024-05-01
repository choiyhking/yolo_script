#### Environment
- YOLOv8.2.2
- torch 2.2.2
- torchvision 0.17.2
  
#### NATIVE
##### How-To
- host: native_run.sh, native_monitor.sh, cal_cpu.py, cal_inf.py
  - ./native_run.sh
 
#### DOCKER
##### How-To
- host: docker_run.sh, docker_monitor.sh, cal_cpu.py
  - ./docker_run.sh
- guest: smallrun.sh, cal_inf.py 
#### KVM
##### How-To
- host: kvm_run.sh, kvm_monitor.sh, cal_cpu.py
  - ./kvm_run.sh
  - kvm_run.sh, kvm_monitor.sh
    - username, ip 확인
- guest: smallrun.sh, cal_inf.py
  - smallrun.sh
    - IMG_PATH=**~**/yolo_script/images 으로 수정
    - INF_RESULT_PATH=**~**/yolo_script/inference_results 으로 수정
    - INF_RESULT_FILENAME=$INF_RESULT_PATH/**kvm**\_inf\_$1 으로 수정
    - python3 **~**/yolo_script/cal_inf.py 으로 수정
#### FIRECRACKER
#### KATA CONTAINER
