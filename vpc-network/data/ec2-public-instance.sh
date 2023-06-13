#!/bin/bash

yum update -y
yum install -y httpd

systemctl enable httpd.service
systemctl start httpd

echo "Hello, World!" > /var/www/html/index.html
