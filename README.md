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

## 构建镜像 / Build Images

- ### 使用脚本 / Use Script

  ```shell
  ./Manager.sh
  ```

  1. Enter  `b` and press `Enter`
  2. Choose system and desktop

## 支持镜像 / Support Imgs

|   系统/OS    | Server | CuteFishDE | KDE Plasma | GNOME | Deepin | OpenBox | Xfce4 |
| :----------: | :----: | :--------: | :--------: | :---: | :----: | :-----: | :---: |
| Ubuntu 20.04 |   ✔    |     ✔      |     ×      |   ×   |   ×    |  ✔(*)   |   ×   |
| Ubuntu 22.04 |   ✔    |     ✔      |     ×      |   ×   |   ×    |  ✔(*)   |   ×   |
| ArchOS News  |   ✔    |     ✔      |     ×      |   ×   |   ×    |    ×    |   ×   |
| Debian Dock  |   ×    |     ×      |     ×      |   ×   |   ×    |    ×    |   ×   |
| Centos Dock  |   ×    |     ×      |     ×      |   ×   |   ×    |    ×    |   ×   |
| Deepin Dock  |   ×    |     ×      |     ×      |   ×   |   ×    |    ×    |   ×   |

### 备注 / Hints

1. 标注了(*)的表示支持，但存在使用问题
2. Ubuntu 18.04已于2023Q1不再维护支持

