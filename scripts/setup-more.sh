#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

THIS=$(realpath $0)
SCRIPTS_DIR=$(dirname "$THIS")

SETUP_PATHS=(
    "${SCRIPTS_DIR}/apps/setup-chrome.sh"
    "${SCRIPTS_DIR}/apps/setup-edge.sh"
    "${SCRIPTS_DIR}/apps/setup-misc-communication.sh"
    "${SCRIPTS_DIR}/apps/setup-misc-multimedia.sh"
    "${SCRIPTS_DIR}/apps/setup-productivity.sh"
    "${SCRIPTS_DIR}/apps/setup-qimgv.sh"
    "${SCRIPTS_DIR}/apps/setup-vscode.sh"
    "${SCRIPTS_DIR}/tools/setup-nvidia.sh"
    "${SCRIPTS_DIR}/tools/setup-conda.sh"
    "${SCRIPTS_DIR}/tools/setup-cuda.sh"
    "${SCRIPTS_DIR}/tools/setup-docker.sh"
    "${SCRIPTS_DIR}/tools/setup-misc.sh"
    "${SCRIPTS_DIR}/tools/setup-python.sh"
)

apt update -y
for path in "${SETUP_PATHS[@]}"; do
    bash "${path}"
done
