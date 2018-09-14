#!/bin/sh
echo "--> Updating CentOS System"
yum -y update

echo "--> Install docker"
sudo curl -sS https://get.docker.com/ | sh
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker