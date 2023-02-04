#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

# I also use Comic Code, but it's not free
APT_APPS=(
    fonts-crosextra-caladea     # Cambria replacement
    fonts-crosextra-carlito     # Calibri replacement
    fonts-jetbrains-mono        # JetBrains Mono
    fonts-noto                  # Noto font metapackage
)

apt update -y
for app in "${APP_APPS[@]}"; do
    apt install "${app}" -y
done