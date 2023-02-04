#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

THIS=$(realpath $0)
SCRIPTS_DIR=$(dirname "$THIS")

TWEAK_PATHS=(
    "${SCRIPTS_DIR}/tweaks/tweak-grub.sh"
    "${SCRIPTS_DIR}/tweaks/tweak-home.sh"
    "${SCRIPTS_DIR}/tweaks/tweak-intel.sh"
    "${SCRIPTS_DIR}/tweaks/tweak-power.sh"
)

apt update -y
for path in "${TWEAK_PATHS[@]}"; do
    bash "${path}"
done
