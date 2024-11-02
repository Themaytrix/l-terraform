#!/bin/bash


sudo yum install httpd -y
sudo yum install start httpd
sudo systemctl enable httpd
sudo yum install -y aws-cli
# configure to get region and outpup
sudo aws configure set region "us-east-1"
sudo aws configure set output "json"
# copy files s3 bucket
sudo aws s3 cp s3://achia-bucket/portfolio /var/www/html --recursive
systemctl restart httpd