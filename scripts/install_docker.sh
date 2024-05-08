#!/bin/bash

# Manually specify the distribution codename
UBUNTU_CODENAME="jammy"

# Ensure system is up-to-date
sudo apt-get update
sudo apt-get install -y lsb-release ca-certificates curl software-properties-common apt-transport-https

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Set up the stable repository
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $UBUNTU_CODENAME stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the apt package index
sudo apt-get update

# Install Docker CE, CLI, and containerd.io
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Enable and start Docker
sudo systemctl enable --now docker

# Verify Docker is running
if [ "$(sudo systemctl is-active docker)" = "active" ]; then
    echo "Docker is active and running."
else
    echo "Docker installation failed or Docker is not running. Please check the errors above."
fi

# Add the default 'vagrant' user to the Docker group
sudo usermod -aG docker vagrant

# New lines added to refresh the Docker group membership
# Refresh group membership without logging out
newgrp docker

# Verify group membership
groups vagrant

echo "Docker installation is complete."

docker pull localstack/localstack


