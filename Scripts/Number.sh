#!/bin/bash
source Scripts/Titles.sh
# Config --------------------------------------------------------------------------
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
  PM_NXSR="1${USE_PID}40";
  PM_VNCS="1${USE_PID}41";
  IN_PORT="q";
  D_NAMES="DC${USE_PID}-S1V3-Docker"
  TMP1MAP="-p 1${USE_PID}01-1${USE_PID}21:1${USE_PID}01-1${USE_PID}21";
  TMP2MAP="-p 1${USE_PID}23-1${USE_PID}39:1${USE_PID}23-1${USE_PID}39";
  TMP3MAP="-p 1${USE_PID}42-1${USE_PID}99:1${USE_PID}42-1${USE_PID}99";
  PORTMAP="${TMP1MAP} ${TMP2MAP} ${TMP3MAP}";
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
PORTMAP_TEXT=${PORTMAP//-\\n\\n\\n}
PORTMAP_TEXT=${PORTMAP_TEXT//-p/\\n\\t}
echo -e "   ===========================Container Info==============================="
echo -e "   Note: Port Mapping: $PORTMAP_TEXT";
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