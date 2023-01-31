#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

APT_APPS=(
    flatpak
    snapd
)
SNAP_APPS=(
    core
)

apt update -y
for app in "${APT_APPS[@]}"; do
    apt install "${app}" -y
done

for app in "${SNAP_APPS[@]}"; do
    snap install "${app}"
done
