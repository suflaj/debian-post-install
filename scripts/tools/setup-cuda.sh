#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

_USER="suflaj"
CUDA_DIR="${HOME}/programs/cuda"
INSTALLER_DIR="${CUDA_DIR}/12.0"
INSTALLER_PATH="${INSTALLER_DIR}/installer.deb"

add-apt-repository contrib
apt-key del 7fa2af80

mkdir -p "${INSTALLER_DIR}"
wget "https://developer.download.nvidia.com/compute/cuda/12.0.0/local_installers/cuda-repo-debian11-12-0-local_12.0.0-525.60.13-1_amd64.deb" \
    -O "${INSTALLER_PATH}"
dpkg -i "${INSTALLER_PATH}"
cp "/var/cuda-repo-debian11-12-0-local/cuda-*-keyring.gpg" "/usr/share/keyrings/"

apt update -y
apt install cuda -y
chown -R "${_USER}:${_USER}" "${CUDA_DIR}"
