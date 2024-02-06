#!/bin/bash
source Scripts/Config.sh
source Scripts/Create/Select-Systems.sh
source Scripts/Create/Select-Desktop.sh
source Scripts/Nvidia.sh
source Scripts/Number.sh
sudo mkdir -p "${DATAPATH}${PV_DATA}/user"
sudo mkdir -p "${DATAPATH}${PV_DATA}/root"
mkdir -p ~/DockerUsers/
# RUN Images ---------------------------------------------------------------------
echo -n "   Docker: "

sudo docker run -itd \
$GPU_LIST \
--privileged=true \
--shm-size=1024m \
--name $D_NAMES \
--cap-add SYS_ADMIN \
--cap-add=SYS_PTRACE \
-h $D_NAMES.$HOSTNAME \
   $PORTMAP \
-p $PM_SSHS:22 \
-p $PM_NXSR:4000 \
-p $PM_VNCS:5900 \
-v "${DATAPATH}${PV_DATA}/root:/root" \
-v "${DATAPATH}${PV_DATA}/user:/home/user" \
pikachuim/$OS_TYPE:$VERSION-$GUI_ENV

if [ $GUI_ENV == 'server' ]; then
  sudo docker exec $D_NAMES /bin/bash -c "systemctl daemon-reload"
  echo -n "   "
  sudo docker exec $D_NAMES /bin/bash -c "systemctl enable run" >> /dev/null
  sudo docker exec $D_NAMES /bin/bash -c "systemctl start run" >> /dev/null
  echo -n "   Docker Restarting Container: "
  sudo docker restart $D_NAMES
fi
D_PASSW=$(openssl rand -hex 12)
echo Password: $D_NAMES $D_PASSW >> ~/DockerUsers/DockerUsers.conf
ssh-keygen -f ~/DockerUsers/$D_NAMES -t ed25519 -N '' -C $D_NAMES -q
SSH_KEY=$(cat ~/DockerUsers/$D_NAMES)
SSH_PUB=$(cat ~/DockerUsers/$D_NAMES.pub)
HOM_DIR=$(echo ~)
sudo docker exec $D_NAMES /bin/bash -c "echo root:${D_PASSW} | chpasswd"
sudo docker exec $D_NAMES /bin/bash -c "echo user:${D_PASSW} | chpasswd"
sudo docker exec $D_NAMES /bin/bash -c "mkdir -p ~/.ssh/"
sudo docker exec $D_NAMES /bin/bash -c "mkdir -p /home/user/.ssh/"
sudo docker exec $D_NAMES /bin/bash -c "echo ${SSH_PUB} >> ~/.ssh/authorized_keys"
sudo docker exec $D_NAMES /bin/bash -c "echo ${SSH_PUB} >> /home/user/.ssh/authorized_keys"
sudo docker exec $D_NAMES /bin/bash -c "chmod 600 ~/.ssh/authorized_keys"
sudo docker exec $D_NAMES /bin/bash -c "chmod 600 /home/user/.ssh/authorized_keys"

echo "   ==========================Enter Key to Continue========================="
read KEY

# Password and Output ------------------------------------------------------------
source Scripts/Titles.sh
echo "──────────────────────────────────────────────────────────────────────"
echo "Congratulations! Your Docker Container has been Created Successfully! "
echo "----------------------------------------------------------------------"
echo "                 Container $D_NAMES                     "
echo "                 OSSystem: $OS_TYPE $VERSION            "
echo "----------------------------------------------------------------------"
echo "                 SSHLogin: $DOMAIN_T:$PM_SSHS    "
if [ $GUI_ENV != 'server' ]; then
echo "                 NXServer: $DOMAIN_T:$PM_NXSR    "
fi
echo "                 IPV4Host: $D_NAMES.$IPV4HOST    " 
echo "                 IPV6Host: $D_NAMES.$IPV6HOST    " 
echo "                 HostName: $D_NAMES.$HOSTNAME    "
echo "----------------------------------------------------------------------"
echo "                 Username: root                         " 
echo "                 Password: $D_PASSW                     " 
echo "                 Username: user                         " 
echo "                 Password: $D_PASSW                     " 
echo "----------------------------------------------------------------------" 
echo "Port Mapping Details:" 
echo -e "       $PORTMAP_TEXT" 
echo "                                                                      "
echo "Container Volume Map:"                                                "
echo -e "    Host: ${DATAPATH}${PV_DATA} -> OCI: /home/user" 
echo ""
echo "SSHLogin Private Key:"
cat ${HOM_DIR}/DockerUsers/${D_NAMES}
echo "----------------------------------------------------------------------" 
echo "Note: Saved password in ~/docker-users.conf, please delete if no need!"
echo "For any questions or suggestions, please visit:                       " 
echo "                 https://github.com/PIKACHUIM/DockerFiles             " 
echo "──────────────────────────────────────────────────────────────────────"
echo "======================= Enter to back to menu ========================"
read KEY
