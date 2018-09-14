#!/bin/sh
echo "--> Updating CentOS System"
yum -y update

echo "--> Install docker"
curl -sS https://get.docker.com/ | sh
systemctl start docker
systemctl enable docker
systemctl status docker