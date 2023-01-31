#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

_USER="suflaj"
PREFIX="${HOME}/programs/miniconda"
INSTALLER="${PREFIX}/installer.sh"
mkdir -p ${PREFIX}

wget "https://repo.anaconda.com/miniconda/Miniconda3-py310_22.11.1-1-Linux-x86_64.sh" \
    -O "${INSTALLER}"
bash "${INSTALLER}" \
    -b \
    -p "${PREFIX}"
chown -R "${_USER}:${_USER}" "${PREFIX}"
eval "$(${PREFIX}/bin/conda shell.bash hook)"
