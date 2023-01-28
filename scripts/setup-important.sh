#/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

# Add contrib and non-free repos
apt-add-repository contrib
apt-add-repository non-free

# Update & upgrade
apt update -y
apt upgrade -y

# Extra package managers -----------------------------------------
apt install \
    flatpak \   # Flatpack
    snapd \     # Snap
-y
snap install core   # Snap core

# Essentials -----------------------------------------------------
apt install \
    build-essential \           # Build essential
    curl \                      # cURL
    dkms \                      # dkms
    linux-headers-$(uname -r)   # Kernel headers
    wget \                      # wget
-y

# Restricted packages (restricted-extras) ------------------------
apt install \
    gstreamer1.0-libav \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-vaapi
    libavcodec-extra \
    rar \
    ttf-mscorefonts-installer \
    unrar \
-y

# Missing fonts --------------------------------------------------
apt install \
    fonts-crosextra-carlito \   # Calibri replacement
    fonts-crosextra-caladea \   # Cambria replacement
-y

# Utilities ------------------------------------------------------
apt install \
    powertop \      # Powertop
    preload \       # Preload
    tar \           # tar
    thermald \      # Thermald
    tlp \           # TLP
    tlp-rdw \       # TLP Radio Device Wizard
    ufw \           # Uncomplicated Firewall
-y

# Fix Bluetooth sleep bug
sed -i '/RESTORE_DEVICE_STATE_ON_STARTUP/s/=.*/=1/' /etc/tlp.conf
systemctl restart tlp

# Set GRUB timeout to 1 second
sed -i '/^GRUB_TIMEOUT/s/=.*/=1' /etc/default/grub
update-grub

# Activate firewall
ufw enable