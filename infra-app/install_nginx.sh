#!/bin/bash
set -e
sudo yum update -y
sudo amazon-linux-extras install nginx1 -y   # only needed on Amazon Linux 2
sudo systemctl start nginx
sudo systemctl enable nginx
echo "<h1>Terraform Welcome to Nginx Server</h1>" | sudo tee /usr/share/nginx/html/index.html