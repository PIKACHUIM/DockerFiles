#!/bin/bash
cd DockerFiles/
# 构建Ubuntu ----------------------------------------
# Base ----------------------------------------------
sudo proxychains4 docker build \
  -f Dockers/Ubuntu/Base \
  -t pikachuim/ubuntu:22.04-server \
  --build-arg OS_VERSION=22.04 \
  ./Dockers
# CuteOS --------------------------------------------
sudo proxychains4 docker build \
  -f Dockers/Ubuntu/Desktop/CuteFishDE \
  -t pikachuim/ubuntu:22.04-cuteos \
  ./Dockers

# 构建ArchOS ----------------------------------------
# Base ----------------------------------------------
sudo proxychains4 docker build \
  -f Dockers/ArchOS/Base \
  -t pikachuim/archos:build-server \
  ./Dockers
# CuteOS --------------------------------------------
sudo proxychains4 docker build \
  -f Dockers/ArchOS/Desktop/CuteFishDE \
  -t pikachuim/archos:build-cuteos \
  ./Dockers

# 退出 ----------------------------------------------
exit 0

# 仅供测试 ==========================================
# 测试脚本 ------------------------------------------
# Ubuntu --------------------------------------------
sudo docker stop ubuntu_test
sudo docker rm ubuntu_test
sudo docker run -it \
--network=host \
--name=ubuntu_test \
--privileged=true \
--cap-add=SYS_PTRACE \
--shm-size=1024m \
--hostname=ubuntu_test \
pikachuim/ubuntu:22.04-cuteos

# ArchOS --------------------------------------------
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
pikachuim/archos:build-cuteos

# 密码 ---------------------------------------------------------------
# Ubuntu -------------------------------------------------------------
sudo docker exec ubuntu_test /bin/bash -c "echo root:pika | chpasswd"
sudo docker exec ubuntu_test /bin/bash -c "echo user:user | chpasswd"
sudo docker exec -it ubuntu_test /bin/bash
# ArchOS -------------------------------------------------------------
sudo docker exec archos_test /bin/bash -c "echo root:pika | chpasswd"
sudo docker exec archos_test /bin/bash -c "echo user:user | chpasswd"
sudo docker exec -it archos_test /bin/bash

# 清理内容 ----------------------------------------------------------
docker stop ubuntu_test
docker stop archos_test
docker 