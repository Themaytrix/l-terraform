#!/bin/bash

# on linux server

echo "starting script"


# upgrade instance
sudo yum update
sudo yum upgrade -y
sudo yum install git -y
sudo yum install -y aws-cli
# configure to get region and outpup
sudo aws configure set region "us-east-1"
sudo aws configure set output "json"

# install mysql-server
sudo wget https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
sudo yum localinstall mysql80-community-release-el7-3.noarch.rpm -y
sudo yum install mysql-server -y


# install docker and docker-compose
sudo yum install -y docker
sudo systemctl start docker
sudo systemctl enable docker


sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose


sudo chmod +x /usr/local/bin/docker-compose


# clone project
git clone https://github.com/Themaytrix/notes.git

cd /notes



sudo cp .env django-notes-app/noteapp/

sudo usermod -aG docker $USER

newgrp docker

# get public IP address of instance
sudo curl http://169.254.169.254/latest/meta-data/public-ipv4

docker-compose up --build -d