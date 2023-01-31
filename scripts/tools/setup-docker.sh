#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

_USER="suflaj"

# Delete old Docker packages
APT_APPS=(
    containerd
    docker
    docker-engine
    docker.io
    runc
)
for app in "${APT_REMOVE[@]}"; do
    apt remove "${app}" -y
done

# Install Docker prerequisites
APT_APPS=(
    ca-certificates
    curl
    gnupg
    lsb-release
)
apt update -y
for app in "${APT_APPS[@]}"; do
    apt install "${app}" -y
done

# Add Docker repo
mkdir -p "/etc/apt/keyrings"
curl -fsSL "https://download.docker.com/linux/debian/gpg" \
    | gpg \
        --dearmor \
        -o "/etc/apt/keyrings/docker.gpg"
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
    | tee "/etc/apt/sources.list.d/docker.list" \
        > "/dev/null"
chmod a+r "/etc/apt/keyrings/docker.gpg"

# Install Docker
APT_APPS=(
    containerd.io
    docker-ce
    docker-ce-cli
    docker-compose-plugin
)
apt update -y
for app in "${APT_APPS[@]}"; do
    apt install "${app}" -y
done

# Add docker group and yourself to it
groupadd docker
usermod -aG docker "${_USER}"
newgrp docker
