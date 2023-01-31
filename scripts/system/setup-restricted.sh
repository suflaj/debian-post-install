#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

APT_APPS=(
    gstreamer1.0-libav
    gstreamer1.0-plugins-ugly
    gstreamer1.0-vaapi
    libavcodec-extra
    rar
    ttf-mscorefonts-installer
    unrar
)

apt update -y
for app in "${APT_APPS[@]}"; do
    apt install "${app}" -y
done