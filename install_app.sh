#!/bin/bash

# Update the system and install Apache web server
yum update -y
yum install -y httpd

# Start Apache web server
systemctl start httpd.service

# Install Git
yum install -y git

# # Clone the GitHub repository
# sudo git clone https://github.com/akinwunmi-akinrimisi/infrastructure-random-quote-app.git /var/www/html/

# #change directory to remove files not needed
# cd /var/www/html/
# sudo rm -f variables.tf install_app.sh Jenkinsfile main.tf

# #copy webfiles into the html directory
# mv /var/www/html/app/* .
# sudo rmdir  app/

# Change ownership of the files to Apache user
chown -R apache:apache /var/www/html/

# Restart Apache web server
systemctl restart httpd.service
