#!/bin/bash
source Scripts/Titles.sh
source Scripts/Create/Select-Systems.sh
source Scripts/Create/Select-Desktop.sh
# Choose -------------------------------------------------
echo -n "   Would you like to test after build?(Y): "
read TEST_FLAG

# Build ---------------------------------------------------
source Scripts/Titles.sh
sudo proxychains4 docker build\
  -f Dockers/${OS_UPPE}/Desktop/${DC_FILE} \
  -t pikachuim/${OS_TYPE}:${VERSION}-${GUI_ENV} \
  --build-arg OS_VERSION=${VERSION} \
  ./Dockers
echo "     ======================= Enter to back to menu ========================"
read KEY

# Test ----------------------------------------------------
if [ $TEST_FLAG == 'Y' ]; then
  source Scripts/Titles.sh
  sudo docker stop ${OS_TYPE}_${GUI_ENV}
  sudo docker rm   ${OS_TYPE}_${GUI_ENV}
  sudo docker run -itd \
              --network=host \
              --name=${OS_TYPE}_${GUI_ENV} \
              --privileged=true \
              --cap-add=SYS_PTRACE \
              --shm-size=1024m \
              --hostname=${OS_TYPE}_${GUI_ENV} \
              pikachuim/${OS_TYPE}:${VERSION}-$GUI_ENV
  sudo docker exec    ${OS_TYPE}_${GUI_ENV} /bin/bash -c "echo root:pika | chpasswd"
  sudo docker exec    ${OS_TYPE}_${GUI_ENV} /bin/bash -c "echo user:user | chpasswd"
  sudo docker exec    ${OS_TYPE}_${GUI_ENV} /bin/bash -c "systemctl daemon-reload"
  sudo docker exec    ${OS_TYPE}_${GUI_ENV} /bin/bash -c "systemctl enable run"
  sudo docker restart ${OS_TYPE}_${GUI_ENV}
  sudo docker exec    ${OS_TYPE}_${GUI_ENV} /bin/bash -c "ps -ef"
  sudo docker exec    ${OS_TYPE}_${GUI_ENV} /bin/bash -c "systemctl status run"
  sudo docker exec    ${OS_TYPE}_${GUI_ENV} /bin/bash
fi