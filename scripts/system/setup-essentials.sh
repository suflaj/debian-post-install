#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

APT_APPS=(
    build-essential
    curl
    dkms
    linux-headers-$(uname -r)
    wget
)

apt update -y
for app in "${APT_APPS[@]}"; do
    apt install "${app}" -y
done
