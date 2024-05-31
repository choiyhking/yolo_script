### Check List
- YOLO 8.2.2
- torch 2.2.2
- torchvision 0.17.2
- opencv-python 4.9.0.80
- memory size should be half of the host size!!

### NATIVE
##### Environment
- kernel: 5.15.0-1055
##### How-To
- host: ./native_run.sh

### DOCKER
##### How-To
- host: ./docker_run.sh

### KVM
##### Environment
- kernel:
##### How-To
- guest VM start
- username, ip 확인
- ./kvm_run.sh
  
### FIRECRACKER
##### Environment
- kernel:
##### How-To
- firecracker microVM start
- username, ip 확인
- ./fc_run.sh

### KATA CONTAINER
##### Environment
- kernel:
##### How-To
- kata container start(using docker command)
- username, ip 확인
- ./kata_run.sh
