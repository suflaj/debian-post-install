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
    zoom-client
)
for app in "${SNAP_APPS[@]}"; do
    snap install "${app}"
done

SNAP_APPS=(
    slack
)
for app in "${SNAP_APPS[@]}"; do
    snap install "${app}" --classic
done
