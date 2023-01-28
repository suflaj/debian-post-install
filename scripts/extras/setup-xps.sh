#/bin/bash

# Contains XPS 9570 tweaks, based on
# https://github.com/JackHack96/dell-xps-9570-ubuntu-respin

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

# Update & upgrade
apt update -y
apt upgrade -y

# Intel MicroCode
apt install \
    intel-microcode \
    iucode-tool \
-y
