#!/bin/bash

# Check if wget is installed
if ! [ -x "$(command -v wget)" ]; then
  echo 'Error: wget is not installed. Please install wget before running this script.' >&2
  exit 1
fi

# Check if unzip is installed
if ! [ -x "$(command -v unzip)" ]; then
  echo 'Error: unzip is not installed. Please install unzip before running this script.' >&2
  exit 1
fi

# Define installation directory
INSTALL_DIR="/usr/local/bin"

# Define Terraform URL
TERRAFORM_URL="https://releases.hashicorp.com/terraform/1.8.2/terraform_1.8.2_linux_amd64.zip"

# Download Terraform binary
echo "Downloading Terraform..."
wget -q -P /tmp "${TERRAFORM_URL}"

# Unzip Terraform binary
echo "Extracting Terraform binary..."
unzip -qq -d /tmp "/tmp/terraform_1.8.2_linux_amd64.zip"

# Move Terraform binary to installation directory
echo "Installing Terraform..."
sudo mv /tmp/terraform "${INSTALL_DIR}"

# Verify installation
echo "Verifying Terraform installation..."
terraform --version

echo "Terraform installation completed successfully."



