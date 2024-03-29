#!/bin/bash
source Scripts/Titles.sh
source Scripts/Create/Select-Systems.sh
source Scripts/Create/Select-Desktop.sh
# Choose -------------------------------------------------
#echo -n "   Would you like to test after build?(Y): "
#read TEST_FLAG
source Scripts/Titles.sh
echo -e "   ============================Builder Info================================"
echo -e "   Systems: $OS_TYPE";
echo -e "   Version: $VERSION";
echo -e "   Desktop: $GUI_ENV";
echo -e "   ========================================================================";
echo -n "   Confirm to create the container? (y/n): "
read CONFIRM
if [ ! $CONFIRM ] || [ $CONFIRM == 'n' ] ; then
  echo "   Warn: Not Confirmed, Exit"
  exit 0
elif [ $CONFIRM == 'y' ]; then
  echo -e "   ========================================================================";
  source Scripts/Titles.sh
fi

# Build ---------------------------------------------------
source Scripts/Titles.sh
echo -e "sudo proxychains4 docker buildx build \
  --allow security.insecure \
  -f Dockers/${OS_UPPE}/Desktop/${DC_FILE} \
  -t pikachuim/${OS_TYPE}:${VERSION}-${GUI_ENV} \
  --build-arg OS_VERSION=${VERSION} \
  ./Dockers"
sudo docker buildx create --use \
  --name insecure-builder \
  --buildkitd-flags '--allow-insecure-entitlement security.insecure'
sudo proxychains4 docker buildx build  \
  --allow security.insecure \
  -f Dockers/${OS_UPPE}/Desktop/${DC_FILE} \
  -t pikachuim/${OS_TYPE}:${VERSION}-${GUI_ENV} \
  --build-arg OS_VERSION=${VERSION} \
  --load\
  ./Dockers > /tmp/buildx-log.txt
sudo docker push pikachuim/${OS_TYPE}:${VERSION}-${GUI_ENV}
echo "     ======================= Enter to back to menu ========================"
read KEY

# exit 0
# Test ----------------------------------------------------
# if [ $TEST_FLAG == 'Y' ]; then
#   source Scripts/Titles.sh
#   sudo docker stop ${OS_TYPE}_${GUI_ENV}
#   sudo docker rm   ${OS_TYPE}_${GUI_ENV}
#   sudo docker run -itd \
#               --network=host \
#               --name=${OS_TYPE}_${GUI_ENV} \
#               --privileged=true \
#               --cap-add=SYS_PTRACE \
#               --shm-size=1024m \
#               --hostname=${OS_TYPE}_${GUI_ENV} \
#               pikachuim/${OS_TYPE}:${VERSION}-$GUI_ENV
#   sudo docker exec    ${OS_TYPE}_${GUI_ENV} /bin/bash -c "echo root:pika | chpasswd"
#   sudo docker exec    ${OS_TYPE}_${GUI_ENV} /bin/bash -c "echo user:user | chpasswd"
#   sudo docker exec    ${OS_TYPE}_${GUI_ENV} /bin/bash -c "systemctl daemon-reload"
#   sudo docker exec    ${OS_TYPE}_${GUI_ENV} /bin/bash -c "systemctl enable run"
#   sudo docker restart ${OS_TYPE}_${GUI_ENV}
#   sudo docker exec    ${OS_TYPE}_${GUI_ENV} /bin/bash -c "ps -ef"
#   sudo docker exec    ${OS_TYPE}_${GUI_ENV} /bin/bash -c "systemctl status run"
#   sudo docker exec    ${OS_TYPE}_${GUI_ENV} /bin/bash
# fi