#!/bin/bash

# on UBUNTU server

# upgrade instance
sudo apt update
sudo apt upgrade -y




# install mysql and pkg dependencies for mysqlclient
sudo apt install -y mysql-server
sudo apt install pkg-config
sudo apt-get install gcc libmysqlclient-dev python3-dev

sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
sudo rm /etc/apt/sources.list.d/docker.

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu jammy stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

cd /





sudo apt install git -y


# clone project
git clone https://github.com/Themaytrix/notes.git

cd /notes

# create env files
sudo tee .env > /dev/null <<EOF
MYSQL_ROOT_PASSWORD="nanaachia"
MYSQL_DATABASE="database1"
MYSQL_USER="admin"
MYSQL_PASSWORD="database1password"
EOF

sudo cp .env django-notes-app/noteapp/

sudo usermod -aG docker $USER
newgrp docker

sudo systemctl stop mysql-server