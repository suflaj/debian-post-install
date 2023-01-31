#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

SNAP_APPS=(
    onlyoffice-desktopeditors
    spectacle
    zenkit-todo
)
for app in "${SNAP_APPS[@]}"; do
    snap install "${app}"
done