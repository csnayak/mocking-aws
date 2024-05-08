#!/bin/bash

# Update system and install necessary dependencies
sudo apt-get update && sudo apt-get install -y curl openssh-server ca-certificates

# Optional: Install Postfix to send notification emails.
# You can skip this if you plan to use an external SMTP server later.
sudo apt-get install -y postfix

# Download and install the GitLab package
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
sudo EXTERNAL_URL="http://localhost:8081" apt-get install gitlab-ce

# Run GitLab reconfigure
sudo gitlab-ctl reconfigure

