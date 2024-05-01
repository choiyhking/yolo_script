#### Environment
- Ubuntu 22.04
- Linux 5.15.0-1053
- Python 3.10.12
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
- guest: smallrun.sh, cal_inf.py 
#### FIRECRACKER
#### KATA CONTAINER
