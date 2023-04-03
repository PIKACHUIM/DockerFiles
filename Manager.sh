#!/bin/bash
while [ true ];
do
  source Scripts/Titles.sh
  echo "   ==================================Menu=================================="
  echo "   --------------------------- Container Manage ---------------------------" 
  echo "          [n] [Created] Create a new docker container from an image"
  echo "          [l] [Display] Display all docker containers in the system"
  echo "          [s] [Started] Start your docker container already created"
  echo "          [r] [Restart] Restart your docker container which ctarted"
  echo "   *WARN* [K] [Killall] Stop your docker container which is running"
  echo "   *WARN* [D] [Deleted] Select and delete your docker container now"
  echo "   ----------------------------- Image Manage -----------------------------" 
  echo "          [b] [ Build ] Build your docker image from the DockerFile"
  echo "   *WARN* [C] [ Clean ] Clean all unuse images and untag image file"
  echo "   *WARN* [P] [ Prune ] Prune system(all unuse images & containers)"
  echo "   ------------------------------------------------------------------------" 
  echo "          [q] [ Exit~ ] Do nothing, just exit this script! Byebye~~"
  echo "   ========================================================================"
  echo  
  OP_TYPE="."
  echo -n "   Choose Operation Type Number(*): "
  read OP_TYPE
  # Create ------------------------------------------------------------------------
  if [ $OP_TYPE == 'q' ]; then
    clear
    exit 0
  elif [ $OP_TYPE == 'n' ]; then
    source Scripts/Create.sh
  elif [ $OP_TYPE == 'l' ]; then
    source Scripts/Titles.sh
    echo "   ========================================================================"
    sudo docker ps -a --format '.  {{.ID}}\t{{.Names}}\t{{.Image}}'
    echo "   ==========================Enter Key to Continue========================="
    read KEY
  elif [ $OP_TYPE == 'D' ]; then
    DEL_NAME=""
    echo "   ========================================================================"
    sudo docker ps -a --format '.  {{.ID}}\t{{.Names}}\t{{.Image}}'
    echo "   ========================================================================"
    echo -n "   Enter Container Name or ID to Delete(*): "
    read DEL_NAME
    docker stop $DEL_NAME
    docker rm   $DEL_NAME
  elif [ $OP_TYPE == 'b' ]; then
    source Builder.sh
  elif [ $OP_TYPE == 'C' ]; then
    echo -n "   "
    docker rmi $(docker images -a | grep none | awk '{print $3}')
  elif [ $OP_TYPE == 'P' ]; then
    echo -n "   "
    docker system prune --volumes
  fi
done



