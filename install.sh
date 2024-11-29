#!/bin/bash

# Introduce variables for URLs and file paths for better maintainability and readability.
DOCKER_GPG_URL="https://download.docker.com/linux/debian/gpg"
DOCKER_KEYRING_PATH="/usr/share/keyrings/docker-archive-keyring.gpg"
DOCKER_REPO_URL="https://download.docker.com/linux/debian"
DOCKER_SOURCE_LIST="/etc/apt/sources.list.d/docker.list"



# Install necessary packages
apt install apt-transport-https ca-certificates curl software-properties-common openssl git -y

# Add Docker GPG key
curl -fsSL $DOCKER_GPG_URL | sudo gpg --dearmor -o $DOCKER_KEYRING_PATH

# Add Docker repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=$DOCKER_KEYRING_PATH] $DOCKER_REPO_URL $(lsb_release -cs) stable" | sudo tee $DOCKER_SOURCE_LIST > /dev/null

# Update package list and install Docker
apt update -y
apt install docker-ce -y

# install htpasswd
sudo apt install apache2-utils

# Verify Docker installation
sudo docker --version

# Clone the repository
mkdir -p /etc/nginx/ && cd /etc/nginx/
git clone https://github.com/tokujun-t/Nginx-Docker.git .

# Self-sign certificate
mkdir -p ./nginx/ssl/
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout ./nginx/ssl/default.key \
    -out ./nginx/ssl/default.crt \
    -subj "/C=US/ST=Test/L=Test/O=Test/OU=Test/CN=default"

# Start the docker compose
docker compose up -d
