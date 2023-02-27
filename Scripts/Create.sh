#!/bin/bash
source Scripts/Titles.sh

# Choose System --------------------------------------------------------------------
echo "   ============================Available System============================"
echo "      [1] Ubuntu    [ √ Server / √ CuteFishDE / × KDE / × GNOME / × DDE ]  "
echo "      [2] ArchOS    [ √ Server / √ CuteFishDE / × KDE / × GNOME / × DDE ]  "
#echo "      [X] Debian    [ √ Server / √ CuteFishDE / √ KDE / √ GNOME / √ DDE ]  "
#echo "      [X] Centos    [ √ Server / × CuteFishDE / × KDE / × GNOME / × DDE ]  "
#echo "      [X] Deepin    [ √ Server / √ CuteFishDE / √ KDE / √ GNOME / √ DDE ]  "
echo "   ========================================================================"
echo 
echo -n "   Choose Platforms Type Number(1): "
read OS_TYPE
if [ ! $OS_TYPE ]; then
  echo Note: OS_TYPE='[1] Ubuntu'
  OS_TYPE=1
fi
if [ $OS_TYPE == 1 ]; then
  source Scripts/Create/Ubuntu-Version.sh
  OS_TYPE=ubuntu
elif [ $OS_TYPE == 2 ]; then
  source Scripts/Create/ArchOS-Version.sh
  OS_TYPE=archos
fi

# Choose Desktop -------------------------------------------------------------------
source Scripts/Titles.sh
echo "   ============================Available Desktop==========================="
echo "      [1] Servers No Desktop [ √ SSH / × GUI APPs / × NoMachine / × VNC ]  "
echo "      [2] Desktop CuteFishDE [ √ SSH / √ GUI APPs / √ NoMachine / √ VNC ]  "
#echo "      [X] Desktop KDE Plasma [ √ SSH / √ GUI APPs / √ NoMachine / √ VNC ]  "
#echo "      [X] Desktop GNOME Base [ √ SSH / √ GUI APPs / √ NoMachine / √ VNC ]  "
#echo "      [X] Desktop Deepin DDE [ √ SSH / √ GUI APPs / √ NoMachine / √ VNC ]  "
echo "   ========================================================================"
echo
echo -n "   Choose GUI Environments Type(1): "
read GUI_ENV
if [ ! $GUI_ENV ]; then
  echo "   Note: GUI_ENV=[1] Servers"
  GUI_ENV=1
fi
if [ $GUI_ENV == 1 ]; then
#  source 
  GUI_ENV=server
elif [ $GUI_ENV == 2 ]; then
#  source 
  GUI_ENV=cuteos
fi

# Config --------------------------------------------------------------------------
source Scripts/Titles.sh
echo "   ===========================Config Port Mapping=========================="
#echo -n "   请输入容器ID，留空需要手动配置端口"
echo    "   Leave blank to manually configure!"
echo -n "   Enter Docker ID(Length=2 Like 01): "
read USE_PID
if [ ! $USE_PID ]; then
  echo "   Note: You need manually set port mapping!"
  PORTMAP=""
  IN_PORT=""
else
  PM_SSHS="1${USE_PID}22";
  IN_PORT="q";
  D_NAMES="s1v3-d${USE_PID}-user"
  TMP1MAP="-p 1${USE_PID}01-1${USE_PID}21:1${USE_PID}01-1${USE_PID}21";
  TMP2MAP="-p 1${USE_PID}23-1${USE_PID}99:1${USE_PID}23-1${USE_PID}99";
  PORTMAP="${TMP1MAP} ${TMP2MAP}";
fi

# --------------------------------------------------------------------------------
while [ ! $PM_SSHS ];
do
  echo -n "   Enter SSH Port Mapping(XXX): "
  read PM_SSHS
  if [ ! $PM_SSHS ]; then
    echo "   Error: You must enter ssh new port!!"
  else
    break
  fi
done

# --------------------------------------------------------------------------------
if [ "$IN_PORT" != "q" ]; then
    echo "   ===========================Manually Configure==========================="
    echo "   Note: !!!Enter 'q' to Finish Port Mapping Input!!!"
fi
while [ "$IN_PORT" != "q" ];
do
  while [ "$IN_PORT" == "" ];
  do
    echo -n "   Enter Port Mapping(XXX:XXX): "
    read IN_PORT
    if [ ! $IN_PORT ]; then
      echo "   Error: You need enter port map, or q to exit!!!"
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
  echo -n "   Enter Docker Names(XXXXXXX): "
  read D_NAMES
  if [ ! $D_NAMES ]; then
    echo "   Error: You must enter container name"
  else
        break
  fi
done

# --------------------------------------------------------------------------------
source Scripts/Titles.sh
PORTMAP=${PORTMAP//-\\n\\n\\n}
PORTMAP=${PORTMAP//-p/\\n\\t}
echo -e "   ===========================Container Info==============================="
echo -e "   Note: Port Mapping: $PORTMAP";
echo -e "   Note: SSH Port Use: $PM_SSHS";
echo -e "   Note: Docker Names: $D_NAMES";
echo -e "   ========================================================================";
echo -n "   Confirm to create the container? (y/n): "
read CONFIRM
if [ ! $CONFIRM ] || [ $CONFIRM == 'n' ] ; then
  echo "   Warn: Not Confirmed, Exit"
  exit 0
elif [ $CONFIRM == 'y' ]; then
  echo -e "   ========================================================================";
fi

# Build Images -------------------------------------------------------------------
#sudo docker rmi $OS_TYPE:$VERSION-server
#sudo docker build Dockers/ -f ./Dockers/Ubuntu/Base \
#--build-arg OS_VERSION=22.04 \
#--build-arg OS_SYSTEMS=ubuntu \
#-t $OS_TYPE:$VERSION-server

# RUN Images ---------------------------------------------------------------------
#sudo docker run -itd --privileged=true \
#--name $D_NAMES \
#-h $D_NAMES.13.cd1.pika.wiki \
#$PORTMAP \
#-p $PM_SSHS:22 \
#$OS_TYPE:$VERSION-server

# Message ------------------------------------------------------------------------

D_PASSW=$(openssl rand -hex 12)

# Password and Output ------------------------------------------------------------
#sudo docker exec ubuntu_test /bin/bash -c "echo root:${D_PASSW} | chpasswd"
#sudo docker exec ubuntu_test /bin/bash -c "echo user:${D_PASSW} | chpasswd"
#echo Password: $D_NAMES $D_PASSW >> ~/DockerUsers.conf
clear
echo "     ──────────────────────────────────────────────────────────────────────"
echo "     Congratulations! Your Docker Container has been Created Successfully! "             
echo "     ----------------------------------------------------------------------"
echo "                      Container $D_NAMES                     "                                                           
echo "                      OSSystem: $OS_TYPE $VERSION            "
echo "     ----------------------------------------------------------------------"                    
echo "                      SSHLogin: v4-cd1.pika.wiki:$PM_SSHS    " 
echo "                      IPV4Host: $D_NAMES.v4-cd1.pika.wiki    " 
echo "                      IPV6Host: $D_NAMES.v6-cd1.pika.wiki    " 
echo "                      HostName: $D_NAMES.13.cd1.pika.wiki    " 
echo "     ----------------------------------------------------------------------"
echo "                      Username: root                         " 
echo "                      Password: $D_PASSW                     " 
echo "                      Username: user                         " 
echo "                      Password: $D_PASSW                     " 
echo "     ----------------------------------------------------------------------" 
echo "     Port Mapping Details:                                   " 
echo -e "                         $PORTMAP                         " 
echo "     ----------------------------------------------------------------------" 
echo "     Note: Saved password in ~/docker-users.conf, delete if no need backup!"
echo "     For any questions or suggestions, please visit:                       " 
echo "                      https://github.com/PIKACHUIM/DockerFiles             " 
echo "     ──────────────────────────────────────────────────────────────────────"
echo "     ======================= Enter to back to menu ========================"
read _
