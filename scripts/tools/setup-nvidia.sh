#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

apt update -y
apt install nvidia-driver -y

# nVidia PRIME setup for SDDM
echo "\
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
xrandr --dpi 96
" \
    | tee -a "/usr/share/sddm/scripts/Xsetup"
systemctl restart sddm
