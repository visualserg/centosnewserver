#!/bin/sh
echo "--> Updating CentOS System"
yum -y update

echo "--> Install docker"
curl -sS https://get.docker.com/ | sh
systemctl start docker
systemctl enable docker
systemctl status docker

echo "--> Install portainer"
docker volume create portainer_data
docker run --restart=always -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer