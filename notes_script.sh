#!/bin/bash

# on UBUNTU server

# upgrade instance
sudo apt update
sudo apt upgrade -y

#install nodejs
sudo apt install nodejs

# install mysql and pkg dependencies for mysqlclient
sudo apt install -y mysql-server
sudo apt install pkg-config
sudo apt-get install gcc libmysqlclient-dev python3-dev


# install nginx
sudo apt-get install -y nginx
sudo systemctl restart nginx

# allow http access
sudo ufw allow http

# install supervisor
sudo apt-get install supervisor

# install pip
sudo apt install python3-pip


# clone project
git clone https://github.com/Themaytrix/notes.git

# install nginx and gunicorn
cd notes/django-notes-app/frontend

# install npm modules
sudo apt install npm
npm i

# run build on react-script
npm run build

# go into django-notes-app
cd ../

# install virtual environment
sudo apt install -y python3.1-venv

# build and activate virtual environment
python3 -m venv venv
source venv/bin/activate

# install dependencies from requirements.txt
pip install -r requirements.txt


# create gunicorn service file in /etc/systemd/system/gunicorn.service

[Unit]
Description=gunicorn daemon
After=network.target

[Service]
User=ubuntu
Group=www-data
WorkingDirectory=/home/ubuntu/notes/django-notes-app
ExecStart=/home/ubuntu/notes/django-notes-app/venv/bin/gunicorn --workers 3 --bind unix:/home/ubuntu/notes/django-notes-app/app.sock noteapp.wsgi:application

[Install]
WantedBy=multi-user.target



# nginx config file in nano /etc/nginx/site-available/django-notes-app

server {
    listen 80;
    server_name 44.210.147.241;
    
    location / {
        proxy_pass http://unix:/home/ubuntu/notes/django-notes-app/app.sock;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
    # Serve React's static files directly
    location /static/ {
        alias /home/ubuntu/notes/django-notes-app/frontend/build/static/;
    }
    # Serve Django's media files (user-uploaded content)
    location /media/ {
        alias /home/ubuntu/notes/django-notes-app/media/;
    }
}
# restart daemon
sudo systemctl daemon-reload

# enable and start gunicorn and nginx

# create symbolic link to /etc/nginx/site-enabled
sudo ln -s /etc/nginx/sites-available/django-notes-app /etc/nginx/sites-enabled

#add www-data (nginx default user to ubuntu group)

# gunicorn error log
tail -f /var/log/nginx/error.log
