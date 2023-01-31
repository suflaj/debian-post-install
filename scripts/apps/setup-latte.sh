#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

_USER="suflaj"
GITHUB_PATH="https://github.com/KDE/latte-dock.git"
INSTALL_DIR="${HOME}/programs/latte-dock"

APT_APPS=(\
    build-essential
    cmake 
    extra-cmake-modules
    gettext
    git
    kirigami2-dev
    libkf5activities-dev
    libkf5archive-dev
    libkf5crash-dev
    libkf5declarative-dev
    libkf5iconthemes-dev
    libkf5newstuff-dev
    libkf5notifications-dev
    libkf5plasma-dev
    libkf5wayland-dev
    libkf5windowsystem-dev
    libkf5xmlgui-dev
    libqt5waylandclient5-dev
    libqt5x11extras5-dev
    libsm-dev
    libwayland-client0
    libwayland-dev
    libx11-dev
    libx11-xcb-dev
    libxcb-randr0-dev
    libxcb-shape0-dev
    libxcb-util-dev
    libxcb-util0-dev
    plasma-wayland-protocols
    qtdeclarative5-dev
    qtwayland5-dev-tools
)

apt update -y
for app in "${APT_APPS[@]}"; do
    apt install "${app}" -y
done

mkdir -p "${INSTALL_DIR}"
git clone "${GITHUB_PATH}" "${INSTALL_DIR}"
bash "${INSTALL_DIR}/install.sh"
chown -R "${_USER}:${_USER}" "${INSTALL_DIR}"
