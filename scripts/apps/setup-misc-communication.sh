#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

SNAP_APPS=(
    discord
    mailspring
    telegram-desktop
    whatsapp-for-linux
)
for app in "${SNAP_APPS[@]}"; do
    snap install "${app}"
done
