#!/bin/bash
source Scripts/Config.sh
source Scripts/Create/Select-Systems.sh
source Scripts/Create/Select-Desktop.sh
source Scripts/Nvidia.sh
source Scripts/Number.sh
sudo mkdir -p "${DATAPATH}${PV_DATA}"
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
-v "${DATAPATH}${PV_DATA}:/home/user" \
pikachuim/$OS_TYPE:$VERSION-$GUI_ENV
sudo docker exec $D_NAMES /bin/bash -c "systemctl daemon-reload"
echo -n "   "
sudo docker exec $D_NAMES /bin/bash -c "systemctl enable run" >> /dev/null
echo -n "   Docker Restarting Container: 
sudo docker restart $D_NAMES
echo "   ==========================Enter Key to Continue========================="
read KEY

# Password and Output ------------------------------------------------------------
source Scripts/Titles.sh
D_PASSW=$(openssl rand -hex 12)
sudo docker exec $D_NAMES /bin/bash -c "echo root:${D_PASSW} | chpasswd"
sudo docker exec $D_NAMES /bin/bash -c "echo user:${D_PASSW} | chpasswd"
echo Password: $D_NAMES $D_PASSW >> ~/DockerUsers.conf
clear
echo "     ──────────────────────────────────────────────────────────────────────"
echo "     Congratulations! Your Docker Container has been Created Successfully! "
echo "     ----------------------------------------------------------------------"
echo "                      Container $D_NAMES                     "
echo "                      OSSystem: $OS_TYPE $VERSION            "
echo "     ----------------------------------------------------------------------"
echo "                      SSHLogin: v4-cd1.pika.wiki:$PM_SSHS    "
echo "                      NXServer: v4-cd1.pika.wiki:$PM_NXSR    "
echo "                      IPV4Host: $D_NAMES.$IPV4HOST    " 
echo "                      IPV6Host: $D_NAMES.$IPV6HOST    " 
echo "                      HostName: $D_NAMES.$HOSTNAME    "
echo "     ----------------------------------------------------------------------"
echo "                      Username: root                         " 
echo "                      Password: $D_PASSW                     " 
echo "                      Username: user                         " 
echo "                      Password: $D_PASSW                     " 
echo "     ----------------------------------------------------------------------" 
echo "     Port Mapping Details:" 
echo -e "            $PORTMAP_TEXT" 
echo ""
echo "     Container Volume Map:" 
echo ""
echo -e "         Host: ${DATAPATH}${PV_DATA} -> OCI: /home/user" 
echo "     ----------------------------------------------------------------------" 
echo "     Note: Saved password in ~/docker-users.conf, delete if no need backup!"
echo "     For any questions or suggestions, please visit:                       " 
echo "                      https://github.com/PIKACHUIM/DockerFiles             " 
echo "     ──────────────────────────────────────────────────────────────────────"
echo "     ======================= Enter to back to menu ========================"
read _
