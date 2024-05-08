#!/bin/bash

# Update package lists
sudo apt-get update

# Install OpenSSH Server
sudo apt-get install openssh-server -y

# Enable and start the SSH service
sudo systemctl enable ssh
sudo systemctl start ssh

# Configure the firewall to allow SSH connections
sudo ufw allow OpenSSH
sudo ufw --force enable

# Install nano
sudo apt-get install nano -y

# Configure SSH to allow root login and password authentication
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Restart the SSH service to apply the changes
sudo systemctl restart ssh

# Check the SSH service status
sudo systemctl status ssh --no-pager

# Display the IP address of the machine
echo "Machine IP Address(es):"
ip addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v '127.0.0.1'