#!/bin/bash

# Set variables for file names
minio_deb="minio_20240501011110.0.0_amd64.deb"
mc_bin="mc"

# Download the latest stable MinIO DEB
wget https://dl.min.io/server/minio/release/linux-amd64/archive/$minio_deb -O $minio_deb

# Install MinIO
sudo dpkg -i $minio_deb

# Check if the MinIO data directory exists, create if it doesn't
if [ ! -d "$HOME/minio" ]; then
    mkdir "$HOME/minio"
fi

# Start the MinIO server with a custom console address
# minio server $HOME/minio --console-address :9001

# Download the MinIO Client (mc) if it does not exist
if [ ! -f "/usr/local/bin/$mc_bin" ]; then
    wget https://dl.min.io/client/mc/release/linux-amd64/$mc_bin
    chmod +x $mc_bin
    sudo mv $mc_bin /usr/local/bin/$mc_bin
fi

# Ensure mc is executable
sudo chmod +x /usr/local/bin/$mc_bin

# Set up the MinIO Client alias
/usr/local/bin/$mc_bin alias set local http://127.0.0.1:9000 minioadmin minioadmin

echo "MinIO installation and configuration complete!"

