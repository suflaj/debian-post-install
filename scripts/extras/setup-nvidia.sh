#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

INSTALLER="cuda-12.0.deb"

apt install \
    nvidia-driver \
-y

wget "https://developer.download.nvidia.com/compute/cuda/12.0.0/local_installers/cuda-repo-debian11-12-0-local_12.0.0-525.60.13-1_amd64.deb" \
    -O "${INSTALLER}"
dpkg -i "${INSTALLER}"
cp /var/cuda-repo-debian11-12-0-local/cuda-*-keyring.gpg /usr/share/keyrings/

apt update
apt install \
    cuda \
-y