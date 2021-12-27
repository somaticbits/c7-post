#!/bin/bash
echo "Welcome to Binia's Centos 7 post install script! "

echo "Fist will update system... "

yum update -yyy 

echo "System is updated"

echo "Adding Epel repo... "

yum install epel-release -y

echo "Done! "

yum update

echo "Installing Development tools and few other things... "

yum install nano git -y
yum group install "Development Tools" -y
yum install yum-utils device-mapper-persistent-data lvm2 -y
yum install python-pip -y
pip install --upgrade pip

echo "Done! "

echo "Adding Docker Community Edition repository and installing docker-ce with docker-compose... "
curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)"  -o /usr/local/bin/docker-compose
cp /usr/local/bin/docker-compose /usr/bin/docker-compose
chmod +x /usr/bin/docker-compose
yum upgrade python*
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum update
yum install docker-ce -yy
systemctl start docker
systemctl enable docker

echo "Done! "

echo "Installing NTP syncing..."
yum install ntp ntpdate
systemctl start ntpd
systemctl enable ntpd
ntpdate -u -s 0.uk.pool.ntp.org 1.uk.pool.ntp.org 2.uk.pool.ntp.org 3.uk.pool.ntp.org
systemctl restart ntpd
hwclock -w

echo "Done!"

mkdir .ssh
touch .ssh/authorized_keys
chmod -R 600 .ssh/

## Azuracast docker install ##
# echo "Azuracast docker install... "
# curl -L https://raw.githubusercontent.com/AzuraCast/AzuraCast/master/docker.sh > docker.sh
# chmod a+x docker.sh
# ./docker.sh install
