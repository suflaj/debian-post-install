#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

THIS=$(realpath $0)
SCRIPTS_DIR=$(dirname "$THIS")

SETUP_PATHS=(
    "${SCRIPTS_DIR}/system/setup-package-managers.sh"
    "${SCRIPTS_DIR}/system/setup-essentials.sh"
    "${SCRIPTS_DIR}/system/setup-fingerprint.sh"
    "${SCRIPTS_DIR}/system/setup-restricted.sh"
    "${SCRIPTS_DIR}/system/setup-firewall.sh"
    "${SCRIPTS_DIR}/system/setup-swap.sh"
)

apt update -y
apt upgrade -y

apt install software-properties-common -y
apt-add-repository contrib
apt-add-repository non-free
apt update -y

for path in "${SETUP_PATHS[@]}"; do
    bash "${path}"
done
