### Check List
- YOLO 8.2.2
- torch 2.2.2
- torchvision 0.17.2
- opencv-python 4.9.0.80
- guest memory size should be half of the host size!!

### NATIVE
##### Environment
- kernel: 5.15.0-1055
##### How-To
- ./native_run.sh

### DOCKER
##### How-To
- `sudo docker update --memory 4gb --memory-swap 4gb yolo-docker`
- ./docker_run.sh

### KVM
##### Environment
- kernel: 5.15.0-107
##### How-To
- `virsh edit test-vm`
- guest VM start
- username, ip 확인
- ./kvm_run.sh
  
### FIRECRACKER
##### Environment
- kernel: 5.10.198
##### How-To
- edit `vm_config.json`
- firecracker microVM start
- username, ip 확인
- ./fc_run.sh

### KATA CONTAINER
##### Environment
- kernel:
##### How-To
- edit `/etc/kata-containers/configuration.toml`
- kata container start
- username, ip 확인
- ./kata_run.sh
