#!/bin/bash

# Install Apache web server
sudo yum update -y
sudo yum install -y httpd

# Start Apache web server
sudo systemctl start httpd.service

# Copy files from GitHub repository
sudo yum install -y git
git clone https://github.com/akinwunmi-akinrimisi/random-quote-generator-app.git /var/www/html/

# Change ownership of the files to Apache user
sudo chown -R apache:apache /var/www/html/

# Restart Apache web server
sudo systemctl restart httpd.service

sudo echo "Hello World from $(hostname -f)" > /var/www/html/index.html