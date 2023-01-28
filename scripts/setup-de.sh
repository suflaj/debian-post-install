#/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

# Update & upgrade
apt update -y
apt upgrade -y

# KDE minimal install --------------------------------------------
apt install \
    kde-plasma-desktop \    # KDE Plasma desktop
    plasma-nm \             # Plasma network manager
-y
