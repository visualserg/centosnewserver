#!/bin/sh
echo "--> Updating CentOS System"
yum -y update && yum install mc -y && yum install nano -y && yum install git -y


pkg="docker"
if yum list installed | grep $pkg > /dev/null
then
    echo "$pkg installed"
else
    echo "$pkg NOT installed"
	curl -sS https://get.docker.com/ | sh
	systemctl start docker
	systemctl enable docker
	systemctl status docker
fi



echo "--> Install portainer"
docker volume create portainer_data
docker run --restart=always -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer

echo "--> Letsencrypt"
git clone https://github.com/letsencrypt/letsencrypt /opt/letsencrypt