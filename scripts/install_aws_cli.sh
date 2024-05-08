#!/bin/bash

# Check if AWS CLI is already installed
if aws --version &>/dev/null; then
    echo "AWS CLI is already installed."
else
    # Update the package index
    echo "Updating package index..."
    sudo apt-get update -y

    # Install required packages
    echo "Installing required packages..."
    sudo apt-get install -y unzip curl

    # Download the latest version of AWS CLI
    echo "Downloading AWS CLI..."
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

    # Unzip the installer
    echo "Unzipping AWS CLI..."
    unzip awscliv2.zip

    # Run the installer
    echo "Installing AWS CLI..."
    sudo ./aws/install
fi

# Set up AWS CLI profile for LocalStack
echo "Configuring AWS CLI for LocalStack..."

# Create config directory if it doesn't exist
mkdir -p ~/.aws

# Write to the config file
cat > ~/.aws/config << EOL
[profile localstack]
region = us-east-1
output = json
endpoint_url = http://localhost:4566
EOL

# Write to the credentials file
cat > ~/.aws/credentials << EOL
[localstack]
aws_access_key_id = test
aws_secret_access_key = test
EOL

echo "AWS CLI configuration for LocalStack has been set."



