#!/bin/bash

# This script assumes a minimal Debian install. Before this, you 
# will need to connect to the internet. This can be done by 
# following these steps:
#
# First find your adapter ID:
#   sudo iwconfig
# It's probably going to be named something like wlp3s0.
#
# Then you need to find the SSID of what you're connecting to:
#   sudo iwlist ADAPTER_ID scan | grep "ESSID"
# You can skip this step if you know the SSID already.
#
# Then, using the SSID and the password of the network, connect:
#   nmcli d wifi connect SSID password PASSWORD
# Congratulations, you're connected to the internet via WiFi.
#
#
#
# The last part is making sure that sudo is installed. If it 
# isn't then do the following:
#   su
#   apt install sudo -y
#
# Then you'll need to add your user to sudoers. First, open the 
# sudoers file:
#   nano /etc/sudoers
#
# Then, add yourself under the line starting with root ALL=, ex.:
#   suflaj ALL=(ALL:ALL) ALL
#
# Save the changes with CTRL+S, and exit with CTRL+X.
#
#
#
# After that, you should be able to use sudo, this script, and 
# other ones.

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
