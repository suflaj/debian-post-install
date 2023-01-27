#/bin/bash

# Contains XPS 9570 tweaks, based on
# https://github.com/JackHack96/dell-xps-9570-ubuntu-respin/blob/master/xps-tweaks.sh

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

# Update the repo
apt update -y
apt upgrade -y

# Intel MicroCode
apt install \
    intel-microcode \
    iucode-tool \
-y
