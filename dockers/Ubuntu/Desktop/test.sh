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
-v /var/run/dbus:/var/run/dbus \
archos:22.04-cuteos

sudo docker exec archos_test /bin/bash -c "echo root:pika | chpasswd"
sudo docker exec archos_test /bin/bash -c "echo user:user | chpasswd"
sudo docker exec -it archos_test /bin/bash

docker stop $(docker ps -a  | grep /bin/sh | awk '{print $1}')
docker rm $(docker ps -a -q)
docker rmi $(docker images -a -q)