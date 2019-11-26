#!/bin/bash
echo "The script is starting."
echo "The docker installer is running."
curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
systemctl enable docker
systemctl stop firewalld
systemctl start docker
echo "The images is pulling."
docker pull nieaowei/campus_network_unlock
echo "The dchlient is closing. The port 68 is open for docker."
ps -ef | grep dhclient | grep -v grep | awk '{print $2}' | xargs kill -9
docker run --net=host -d nieaowei/campus_network_unlock
mkdir ~/auto-scripts && cd ~/auto-scripts
curl -O https://raw.githubusercontent.com/nieaowei/campus_network_unlock/master/campus_network_unlock.sh
chmod +x campus_network_unlock.sh && ./campus_network_unlock.sh
echo "Add auto start scripts."
bash "echo \"~/auto-scripts/campus_network_unlock.sh\" >> /etc/rc.d/rc.local"
chmod +x /etc/rc.d/rc.local