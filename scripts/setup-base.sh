#!/bin/bash

# Make sure to go through these scripts and change _USER to your 
# user name::
#
#   scripts/apps/setup-latte.sh

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

THIS=$(realpath $0)
SCRIPTS_DIR=$(dirname "$THIS")

SETUP_PATHS=(
    "${SCRIPTS_DIR}/de/setup-kde.sh"
    "${SCRIPTS_DIR}/system/setup-fonts.sh"
    "${SCRIPTS_DIR}/apps/setup-bismuth.sh"
    "${SCRIPTS_DIR}/apps/setup-latte.sh"
)

apt update -y
for path in "${SETUP_PATHS[@]}"; do
    bash "${path}"
done
