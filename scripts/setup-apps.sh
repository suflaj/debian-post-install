#/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

THIS=$(realpath $0)
PARENT=$(dirname "$THIS")

# Update & upgrade
apt update -y
apt upgrade -y

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

# Productivity ---------------------------------------------------
snap install \
    onlyoffice-desktopeditors \ # OnlyOffice
    spectacle \                 # KDE Spectacle
    zenkit-todo                 # Zenkit To-Do

# Utilities ------------------------------------------------------
apt install \
    htop \          # htop
    p7zip-full \    # 7-zip
    qbittorrent \   # qBitTorrent
    screen \        # GNU Screen
    stacer \        # Stacer cleanup
-y
