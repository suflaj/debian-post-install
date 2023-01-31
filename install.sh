#!/bin/bash

# Make sure to go through these scripts and change _USER to your 
# user name:
#
#   scripts/apps/setup-latte.sh
#   scripts/tools/setup-conda.sh
#   scripts/tools/setup-cuda.sh
#   scripts/tools/setup-docker.sh
#   scripts/tools/setup-python.sh

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

THIS=$(realpath $0)
SCRIPTS_DIR="$(dirname "$THIS")/scripts"

SETUP_PATHS=(
    "${SCRIPTS_DIR}/init.sh"
    "${SCRIPTS_DIR}/setup-base.sh"
    "${SCRIPTS_DIR}/setup-more.sh"
    "${SCRIPTS_DIR}/setup-tweaks.sh"
)
