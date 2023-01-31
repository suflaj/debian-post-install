#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

APT_APPS=(
    ufw
)

apt update -y
for app in "${APT_APPS[@]}"; do
    apt install "${app}" -y
done

ufw enable
