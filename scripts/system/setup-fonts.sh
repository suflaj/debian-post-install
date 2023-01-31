#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

APT_APPS=(
    fonts-crosextra-caladea     # Cambria replacement
    fonts-crosextra-carlito     # Calibri replacement
)

apt update -y
for app in "${APP_APPS[@]}"; do
    apt install "${app}" -y
done