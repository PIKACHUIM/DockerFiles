#!/bin/bash
clear
echo "   ┌──────────────────────────────────────────────────────────────────────┐"
echo "   │          Pikachu Docker Image Build and Container Setup Tool         │"
echo "   │                     Last Updated Feb 01 / 2023                       │"
echo "   │            Copyright © 2023 Pikachu, All Rights Reserved             │"
echo "   └──────────────────────────────────────────────────────────────────────┘"
echo 
echo "   ============================Available System============================"
echo "      [1] Ubuntu    [ √ Server / √ CuteFishDE / √ KDE / √ GNOME / √ DDE ]  "
echo "      [2] Debian    [ √ Server / √ CuteFishDE / √ KDE / √ GNOME / √ DDE ]  "
echo "      [3] Centos    [ √ Server / × CuteFishDE / × KDE / × GNOME / × DDE ]  "
echo "      [4] Deepin    [ √ Server / √ CuteFishDE / √ KDE / √ GNOME / √ DDE ]  "
echo "      [5] ArchLinux [ √ Server / √ CuteFishDE / √ KDE / √ GNOME / √ DDE ]  "
echo "   ========================================================================"
echo
echo
echo "   ============================Available Desktop==========================="
echo "      [1] Servers No Desktop [ √ SSH / × GUI APPs / × NoMachine / × VNC ]  "
echo "      [2] Desktop CuteFishDE [ √ SSH / √ GUI APPs / √ NoMachine / √ VNC ]  "
echo "      [3] Desktop KDE Plasma [ √ SSH / √ GUI APPs / √ NoMachine / √ VNC ]  "
echo "      [4] Desktop GNOME Base [ √ SSH / √ GUI APPs / √ NoMachine / √ VNC ]  "
echo "      [5] Desktop Deepin DDE [ √ SSH / √ GUI APPs / √ NoMachine / √ VNC ]  "
echo "   ========================================================================"
echo 
echo -n "   Enter Docker OS Type(ubuntu): "
read OS_TYPE
echo 
echo 
echo "   ============================Available Version==========================="
echo "      [1] 22.04 Jammy Jellyfish  [ √ Now Recommend / Support Until 2032 ]  "
echo "      [2] 20.04 Focal Fossa      [ × Not Recommend / Support Until 2030 ]  "
echo "      [3] 18.04 Bionic Beaver    [ × Not Recommend / Support Until 2028 ]  "
echo "   ========================================================================"
echo -n "   Enter Docker Version(22.04): "
read VERSION
# --------------------------------------------------------------------------------
echo "   ===========================Config Port Mapping=========================="
echo -n "请输入容器ID，留空需要手动配置端口  "
echo    "Leave blank to manually configure!"
echo -n "Enter Docker ID(Length=2 Like 01): "
read USE_PID
if [ ! $USE_PID ]; then
  echo "Note: You need manually set port mapping!"
  PORTMAP=""
  IN_PORT=""
else
  echo "=================Auto Set Detail=================="
  PM_SSHS="1${USE_PID}22";
  IN_PORT="q";
  D_NAMES="s1v3-d${USE_PID}-user"
  TMP1MAP="-p 1${USE_PID}01-1${USE_PID}21:1${USE_PID}01-1${USE_PID}21";
  TMP2MAP="-p 1${USE_PID}23-1${USE_PID}99:1${USE_PID}23-1${USE_PID}99";
  PORTMAP="${TMP1MAP} ${TMP2MAP}";
  echo "Note: Port Mapping: $TMP1MAP";
  echo "Note: Port Mapping: $TMP2MAP";
  echo "Note: SSH Port Use: $PM_SSHS";
  echo "Note: Docker Names: $D_NAMES";
  echo "==================================================";
fi
# --------------------------------------------------------------------------------
while [ ! $PM_SSHS ];
do
  echo -n "Enter SSH Port Mapping(XXX): "
  read PM_SSHS
  if [ ! $PM_SSHS ]; then
    echo "Error: You must enter ssh new port!!"
  else
    break
  fi
done
# --------------------------------------------------------------------------------
if [ "$IN_PORT" != "q" ]; then
    echo "==============Manually Configure================="
    echo "Note: !!!Enter 'q' to Finish Port Mapping Input!!!"
fi
while [ "$IN_PORT" != "q" ];
do
  while [ "$IN_PORT" == "" ];
  do
    echo -n "Enter Port Mapping(XXX:XXX): "
    read IN_PORT
    if [ ! $IN_PORT ]; then
      echo "Error: You need enter port map, or q to exit!!!"
    else
        break
    fi
  done
  if [ "$IN_PORT" != "q" ]; then
    PORTMAP="${PORTMAP} -p ${IN_PORT} "
  else
    break
  fi
  IN_PORT=""
done
# --------------------------------------------------------------------------------
while [ ! $D_NAMES ];
do
  echo -n "Enter Docker Names(XXXXXXX): "
  read D_NAMES
  if [ ! $D_NAMES ]; then
    echo "Error: You must enter container name"
  else
        break
  fi
done
# NULL Data ----------------------------------------------------------------------
if [ ! $OS_TYPE ]; then
  echo Note: OS_TYPE='ubuntu'
  OS_TYPE='ubuntu'
fi
if [ ! $VERSION ]; then
  echo Note: VERSION='22.04'
  VERSION='22.04'
fi

# Build Images -------------------------------------------------------------------
sudo docker rmi $OS_TYPE:$VERSION-server
sudo docker build . -f ./dockers/Ubuntu/Base \
--build-arg OS_VERSION=22.04 \
--build-arg OS_SYSTEMS=ubuntu \
-t $OS_TYPE:$VERSION-server

# RUN Images ---------------------------------------------------------------------
sudo docker run -itd --privileged=true \
--name $D_NAMES \
-h $D_NAMES.13.cd1.pika.wiki \
$PORTMAP \
-p $PM_SSHS:22 \
$OS_TYPE:$VERSION-server
# Message ------------------------------------------------------------------------
PORTMAP=${PORTMAP//-\\n\\n\\n}
PORTMAP=${PORTMAP//-p/\\n\\t}
D_PASSW=$(openssl rand -hex 12)

# Password and Output ------------------------------------------------------------
docker exec $D_NAMES /bin/bash -c "echo root:${D_PASSW} | chpasswd"
echo      ──────────────────────────────────────────────────────────────────────
echo                      Docker Container Created Successfully                  
echo        
echo                         Container $D_NAMES                                                             
echo                         OSSystem: $OS_TYPE $VERSION                            
echo                         SSHLogin: v4-cd1.pika.wiki:$PM_SSHS
echo                         IPV4Host: $D_NAMES.v4-cd1.pika.wiki
echo                         IPV6Host: $D_NAMES.v6-cd1.pika.wiki
echo                         HostName: $D_NAMES.13.cd1.pika.wiki
echo                         Username: root         
echo                         Password: $D_PASSW  
echo    
echo                      Port Mapping Details:
echo -e                         $PORTMAP    
echo      ──────────────────────────────────────────────────────────────────────  
echo Password: $D_NAMES $D_PASSW >> ~/docker-users.conf

