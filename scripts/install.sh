#/bin/bash

THIS=$(realpath $0)
PARENT=$(dirname "$THIS")

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

# Update the repos
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

# Restricted packages --------------------------------------------

apt install \
    fonts-crosextra-carlito \
    fonts-crosextra-caladea \
    gstreamer1.0-libav \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-vaapi
    libavcodec-extra \
    rar \
    ttf-mscorefonts-installer \
    unrar \
-y

# KDE minimal install --------------------------------------------
apt install \
    kde-plasma-desktop \    # KDE Plasma desktop
    plasma-nm \             # Plasma network manager
-y

# Browsers -------------------------------------------------------
snap install \
    chromium    # Chromium

bash "${PARENT}/extras/setup-edge-repo.sh"
apt update -y
apt install \
    microsoft-edge-stable   # Microsoft Edge
-y

# Coding ---------------------------------------------------------
snap install \
    code \      # Visual Studio Code
    docker \    # Docker
    git \       # Git
--classic

# Communication --------------------------------------------------
snap install \
    discord \               # Discord
    mailspring \            # Mailspring
    telegram-desktop \      # Telegram
    whatsapp-for-linux \    # WhatsApp
    zoom-client \           # Zoom

snap install \
    slack \     # Slack
--classic

# Multimedia -----------------------------------------------------

add-apt-repository ppa:easymodo/qimgv
apt update -y
apt install \
    elisa \         # Elisa Music Player
    obs-studio \    # OBS
    qimgv \         # qimgv Image Viewer
    spotify \       # Spotify
    vlc \           # VLC
-y

# Utilities ------------------------------------------------------
apt install \
    htop \          # htop
    p7zip-full \    # 7-zip
    powertop \      # Powertop
    preload \       # Preload
    qbittorrent \   # qBitTorrent
    screen \        # GNU Screen
    stacer \        # Stacer cleanup
    tar \           # tar
    thermald \      # Thermald
    tlp \           # TLP
    tlp-rdw \       # TLP Radio Device Wizard
-y
snap install \
    onlyoffice-desktopeditors \ # OnlyOffice
    spectacle \                 # KDE Spectacle
    zenkit-todo                 # Zenkit To-Do


# Fix Bluetooth sleep bug
sed -i '/RESTORE_DEVICE_STATE_ON_STARTUP/s/=.*/=1/' /etc/tlp.conf
systemctl restart tlp
