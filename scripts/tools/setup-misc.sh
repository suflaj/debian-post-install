#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

APT_APPS=(
    acpi
    htop
    p7zip
    powertop
    qbittorrent
    screen
    sensors
    stacer
    tar
)

apt update -y
for app in "${APT_APPS[@]}"; do
    apt install "${app}" -y
done
