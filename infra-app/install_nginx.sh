#!/bin/bash
sudo yum update -y
sudo yum install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
echo "<h1>Terraform Welcome to Nginx Server</h1>" | sudo tee /var/www/html/index.html