#!/bin/bash

# Check if Docker Compose is already installed
if [ -x "$(command -v docker-compose)" ]; then
    echo "Docker Compose is already installed."
    exit 0
fi

# Install prerequisites
sudo apt update
sudo apt install -y curl

# Download the latest version of Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Apply executable permissions to the binary
sudo chmod +x /usr/local/bin/docker-compose

# Test the installation
if [ -x "$(command -v docker-compose)" ]; then
    echo "Docker Compose installation successful."
    docker-compose --version
else
    echo "Failed to install Docker Compose."
    exit 1
fi
