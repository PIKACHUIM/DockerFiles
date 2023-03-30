# 带有桌面环境和工具的Docker容器镜像
# Docker Images with Desktop and Tools

## 项目信息 / Project Info

- ### Github：[PIKACHUIM/DockerFiles](https://github.com/PIKACHUIM/DockerFiles)

## 快速使用 / Quick Usage

- ### 使用脚本 / Use Script

  ```shell
  git clone https://github.com/PIKACHUIM/DockerFiles.git
  cd DockerFiles && chmod +x -R *.sh
  ./Manager.sh
  ```

  1. Enter  `c` and press `Enter`
  2. Choose system and desktop
  3. Use SSH/NoMachine to connect docker

## 手动启动 / Manual Run

- ### Ubuntu

  ```shell
  sudo docker run -itd \
      --network=host \
      --name=ubuntu_server \
      --privileged=true \
      --cap-add=SYS_PTRACE \
      --cap-add SYS_ADMIN \
      --shm-size=1024m \
      --hostname=ubuntu_server \
  	pikachuim/ubuntu:22.04-server
  ```

- 

## 构建镜像 / Build Images

- ### Ubuntu

  - #### Server

    ```shell
    sudo proxychains4 docker build\
      -f Dockers/Ubuntu/Base \
      -t pikachuim/ubuntu:22.04-server \
      --build-arg OS_VERSION=22.04 \
      ./Dockers
    ```

    

  - 



