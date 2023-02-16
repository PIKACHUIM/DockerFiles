#!/bin/bash
sudo docker build ~/DockerFiles/ \
-f dockers/Ubuntu/Desktop/CuteFishDE \
--build-arg OS_VERSION=22.04 \
--build-arg OS_SYSTEMS=ubuntu \
-t ubuntu:22.04-cutefish


sudo proxychains4 docker build -f dockers/Ubuntu/Desktop/CuteFishDE -t ubuntu:22.04-cuteos .
sudo docker stop ubuntu_test
sudo docker rm ubuntu_test

sudo docker run -it \
--network=host \
--name=ubuntu_test \
--privileged=true \
--cap-add=SYS_PTRACE \
--shm-size=1024m \
--hostname=ubuntu_test \
ubuntu:22.04-cuteos

sudo docker exec ubuntu_test /bin/bash -c "echo root:pika | chpasswd"
sudo docker exec ubuntu_test /bin/bash -c "echo user:user | chpasswd"
sudo docker exec -it ubuntu_test /bin/bash

sudo proxychains4 docker build -f dockers/Arch/Desktop/CuteFishDE -t archos:22.04-cuteos .
sudo docker stop archos_test
sudo docker rm archos_test
sudo docker run -it \
--network=host \
--name=archos_test \
--privileged=true \
--cap-add=SYS_PTRACE \
--shm-size=1024m \
--hostname=archos_test \
-v /var/run/dbus:/var/run/dbus \
archos:22.04-cuteos

sudo docker exec archos_test /bin/bash -c "echo root:pika | chpasswd"
sudo docker exec archos_test /bin/bash -c "echo user:user | chpasswd"
sudo docker exec -it archos_test /bin/bash

docker stop $(docker ps -a  | grep /bin/sh | awk '{print $1}')
docker rm $(docker ps -a  | grep /bin/sh | awk '{print $1}')
docker rmi $(docker images -a | grep none | awk '{print $3}')

#Ubuntu镜像 ========================
sudo docker pull pikachuim/ubuntu:22.04-cuteos
sudo docker run -itd \
--network=host \
--privileged=true \
--cap-add=SYS_PTRACE \
--shm-size=1024m \
--name=cuteos_test \
pikachuim/ubuntu:22.04-cuteos
#Arch镜像 ==========================
sudo docker pull pikachuim/archos:22.04-cuteos
sudo docker run -itd \
--network=host \
--privileged=true \
--cap-add=SYS_PTRACE \
--shm-size=1024m \
--name=cuteos_test \
pikachuim/archos:22.04-cuteos
#连接方式 ==========================
sudo docker exec cuteos_test /bin/bash -c "echo root:设置一个密码 | chpasswd"
#然后用NoMachine连接IP:4000，用户名root，密码是上一条设置的