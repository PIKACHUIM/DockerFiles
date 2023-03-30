#!/bin/bash
cd DockerFiles/
# 构建Ubuntu ----------------------------------------
# Base ----------------------------------------------
sudo proxychains4 docker build\
  -f Dockers/Ubuntu/Base \
  -t pikachuim/ubuntu:22.04-server \
  --build-arg OS_VERSION=22.04 \
  ./Dockers
# CuteOS --------------------------------------------
sudo proxychains4 docker build \
  -f Dockers/Ubuntu/Desktop/CuteFishDE \
  -t pikachuim/ubuntu:22.04-cuteos \
  ./Dockers
# KDE -----------------------------------------------
sudo proxychains4 docker build \
  -f Dockers/Ubuntu/Desktop/KDE \
  -t pikachuim/ubuntu:22.04-plasma \
  ./Dockers
# GNOME ---------------------------------------------
sudo proxychains4 docker build \
  -f Dockers/Ubuntu/Desktop/GNOME \
  -t pikachuim/ubuntu:22.04-gnome3 \
  ./Dockers
# DDE -----------------------------------------------
sudo proxychains4 docker build \
  -f Dockers/Ubuntu/Desktop/DDE \
  -t pikachuim/ubuntu:22.04-deepin \
  ./Dockers
# OpenBox -------------------------------------------
sudo proxychains4 docker build \
  -f Dockers/Ubuntu/Desktop/OpenBox \
  -t pikachuim/ubuntu:22.04-op-box \
  ./Dockers
# Xfce4 ---------------------------------------------
sudo proxychains4 docker build \
  -f Dockers/Ubuntu/Desktop/Xfce4 \
  -t pikachuim/ubuntu:22.04-xfce-4 \
  ./Dockers


# 构建ArchOS ----------------------------------------
# Base ----------------------------------------------
sudo proxychains4 docker build \
  -f Dockers/ArchOS/Base \
  -t pikachuim/archos:build-server \
  ./Dockers
# CuteOS --------------------------------------------
sudo proxychains4 docker build \
  -f Dockers/ArchOS/Desktop/CuteFishDE-old \
  -t pikachuim/archos:build-cuteos \
  ./Dockers


# 退出 ----------------------------------------------
exit 0

# 仅供测试 ==========================================
# 测试脚本 ------------------------------------------
# Ubuntu --------------------------------------------
sudo docker stop ubuntu_server
sudo docker rm ubuntu_server
sudo docker run -it \
--network=host \
--name=ubuntu_server \
--privileged=true \
--cap-add=SYS_PTRACE \
--cap-add SYS_ADMIN \
--shm-size=1024m \
--hostname=ubuntu_server \
pikachuim/ubuntu:22.04-server
sudo docker exec ubuntu_server /bin/bash -c \
"systemctl daemon-reload && systemctl enable run"
sudo docker restart ubuntu_server
sudo docker exec -it ubuntu_server /bin/bash
# CuteOS --------------------------------------------
sudo docker stop ubuntu_cuteos
sudo docker rm ubuntu_cuteos
sudo docker run -it \
--network=host \
--name=ubuntu_cuteos \
--privileged=true \
--cap-add=SYS_PTRACE \
--shm-size=1024m \
--hostname=ubuntu_cuteos \
pikachuim/ubuntu:22.04-cuteos
sudo docker exec ubuntu_cuteos /bin/bash -c "echo root:pika | chpasswd"
sudo docker exec ubuntu_cuteos /bin/bash -c "echo user:user | chpasswd"
sudo docker exec -it ubuntu_cuteos /bin/bash
# KDE -----------------------------------------------
sudo docker stop ubuntu_plasma
sudo docker rm ubuntu_plasma
sudo docker run -it \
--network=host \
--name=ubuntu_plasma \
--privileged=true \
--cap-add=SYS_PTRACE \
--shm-size=1024m \
--hostname=ubuntu_plasma \
pikachuim/ubuntu:22.04-plasma
sudo docker exec ubuntu_deepin /bin/bash -c "echo root:pika | chpasswd"
sudo docker exec ubuntu_deepin /bin/bash -c "echo user:user | chpasswd"
sudo docker exec -it ubuntu_deepin /bin/bash
# GNOME ---------------------------------------------
sudo docker stop ubuntu_gnome3
sudo docker rm ubuntu_gnome3
sudo docker run -it \
--network=host \
--name=ubuntu_gnome3 \
--privileged=true \
--cap-add=SYS_PTRACE \
--shm-size=1024m \
--hostname=ubuntu_gnome3 \
pikachuim/ubuntu:22.04-gnome3
sudo docker exec ubuntu_gnome3 /bin/bash -c "echo root:pika | chpasswd"
sudo docker exec ubuntu_gnome3 /bin/bash -c "echo user:user | chpasswd"
sudo docker exec -it ubuntu_gnome3 /bin/bash
# DDE -----------------------------------------------
sudo docker stop ubuntu_deepin
sudo docker rm ubuntu_deepin
sudo docker run -it \
--network=host \
--name=ubuntu_deepin \
--privileged=true \
--cap-add=SYS_PTRACE \
--shm-size=1024m \
--hostname=ubuntu_deepin \
pikachuim/ubuntu:22.04-deepin
sudo docker exec ubuntu_deepin /bin/bash -c "echo root:pika | chpasswd"
sudo docker exec ubuntu_deepin /bin/bash -c "echo user:user | chpasswd"
sudo docker exec -it ubuntu_deepin /bin/bash
# OpenBox -------------------------------------------
# Xfce4 ---------------------------------------------
sudo docker stop ubuntu_xfce-4
sudo docker rm ubuntu_xfce-4
sudo docker run -it \
--network=host \
--name=ubuntu_xfce-4 \
--privileged=true \
--cap-add=SYS_PTRACE \
--shm-size=1024m \
--hostname=ubuntu_xfce-4 \
pikachuim/ubuntu:22.04-xfce-4
sudo docker exec ubuntu_xfce-4 /bin/bash -c "echo root:pika | chpasswd"
sudo docker exec ubuntu_xfce-4 /bin/bash -c "echo user:user | chpasswd"
sudo docker exec -it ubuntu_xfce-4 /bin/bash


# ArchOS --------------------------------------------
sudo docker stop archos_cuteos
sudo docker rm archos_cuteos
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

# ArchOS -------------------------------------------------------------
sudo docker exec archos_test /bin/bash -c "echo root:pika | chpasswd"
sudo docker exec archos_test /bin/bash -c "echo user:user | chpasswd"
sudo docker exec -it archos_test /bin/bash

# 清理内容 ----------------------------------------------------------
docker stop ubuntu_test
docker stop archos_test

# 删除镜像 ----------------------------------------------------------
exit -1
# 删除None镜像
docker rmi $(docker images -a | grep none | awk '{print $3}')
docker system prune --volumes