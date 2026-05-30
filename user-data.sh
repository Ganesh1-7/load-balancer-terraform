#!/bin/bash
set -euxo pipefail

# Wait for network and package repositories
sleep 60

# Refresh package cache
apt-get clean
rm -rf /var/lib/apt/lists/*

# Retry apt update
for i in {1..5}; do
    apt-get update && break
    sleep 15
done

# Install required packages
apt-get install -y nginx git

# Enable and start nginx
systemctl enable nginx
systemctl start nginx

# Clone website repository
rm -rf /tmp/site
git clone https://github.com/Ganesh1-7/Bubble_game.git /tmp/site

# Deploy website
rm -rf /var/www/html/*
cp -r /tmp/site/* /var/www/html/

# Set permissions
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

# Restart nginx
systemctl restart nginx

# Log deployment status
echo "Deployment completed successfully at $(date)" > /var/log/deployment.log
