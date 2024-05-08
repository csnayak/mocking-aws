#!/bin/bash

# Ensure lsb-release is installed
sudo apt-get update
sudo apt-get install -y lsb-release

# Install necessary packages
sudo apt-get install -y lsb-release ca-certificates curl software-properties-common apt-transport-https

# Install required packages for building Python
sudo apt update
sudo apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev \
libnss3-dev libssl-dev libreadline-dev libffi-dev libbz2-dev wget curl

# Fixing potential lsb_release command issue
sudo apt install -y lsb-release

# Install SQLite Development Libraries
sudo apt-get update
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev


# Fetch Python 3.9.14 source
cd /tmp
wget https://www.python.org/ftp/python/3.9.14/Python-3.9.14.tgz

# Extract source code
tar -xzf Python-3.9.14.tgz

# Build and install Python 3.9.14
cd Python-3.9.14
./configure --enable-optimizations
make
sudo make altinstall

# Verify installation
if command -v python3.9 &> /dev/null; then
    echo "Python 3.9.14 installation complete!"
else
    echo "Python 3.9.14 installation failed!"
    exit 1
fi

# Set Python 3.9.14 as the default version
sudo update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python3.9 1
sudo update-alternatives --set python3 /usr/local/bin/python3.9
echo "Python 3.9.14 set as default version."

# Install pip for Python 3.9.14
curl https://bootstrap.pypa.io/get-pip.py | python3.9

# Add $HOME/.local/bin to the system's $PATH
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

# Source the bashrc to reflect changes immediately
source ~/.bashrc

# Install the required Python libraries
pip3.9 install ikp3db \
boto3==1.24.28 \
opensearch-py==2.3.1 \
python-dotenv==0.19.0 \
typing==3.7.4.3 \
pydantic==2.2.1 \
urllib3==1.26.16 \
opensearch-dsl==2.1.0 \
mangum==0.17.0 \
fastapi==0.103.1 \
xmltodict==0.13.0
