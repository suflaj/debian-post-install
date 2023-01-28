#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

THIS=$(realpath $0)
PARENT=$(dirname "$THIS")
SCRIPTS="${SCRIPTS}/scripts"
EXTRAS="${SCRIPTS}/extras"

# Always install this
bash "${SCRIPTS}/setup-important.sh"
bash "${SCRIPTS}/setup-de.sh"
bash "${SCRIPTS}/setup-apps.sh"

# I guess it's personal, you might want to change these
bash "${EXTRAS}/setup-xps.sh"
bash "${EXTRAS}/setup-swap.sh"
bash "${EXTRAS}/setup-vscode.sh"
bash "${EXTRAS}/setup-nvidia.sh"

# Change __USER__ in these scripts before removing comments!!!
# bash "${EXTRAS}/setup-python.sh"
# bash "${EXTRAS}/setup-conda.sh"