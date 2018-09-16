#!/bin/sh
echo "--> Updating CentOS System"
yum -y update && yum install mc -y && yum install nano -y && yum install git -y


docker -s $1 &> /dev/null
if [ $? -eq 0 ]; then
    echo "--> Install docker"
	curl -sS https://get.docker.com/ | sh
	systemctl start docker
	systemctl enable docker
	systemctl status docker
else
	echo "Package already installed!"    
fi


echo "--> Install portainer"
docker volume create portainer_data
docker run --restart=always -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer