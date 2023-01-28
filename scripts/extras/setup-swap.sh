#/bin/bash

SWAP_PATH="/swap"
SWAPPINESS=5

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

fallocate -l 8G "${SWAP_PATH}"
chmod 600 "${SWAP_PATH}"
mkswap "${SWAP_PATH}"

cp /etc/fstab /etc/fstab.old
echo "${SWAP_PATH} none swap sw 0 02" | tee -a /etc/fstab

sed -r '/^vm\.swappiness=[0-9]+$/d' /etc/sysctl.conf | sudo tee /etc/sysctl.conf
echo "vm.swappiness=${SWAPPINESS}" | tee -a /etc/sysctl.conf
