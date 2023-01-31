#/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

SWAP_SIZE="8G"
SWAP_PATH="/swap"
SWAPPINESS=5

fallocate -l "${SWAP_SIZE}" "${SWAP_PATH}"
chmod 600 "${SWAP_PATH}"
mkswap "${SWAP_PATH}"

cp "/etc/fstab" "/etc/fstab.old"
echo "${SWAP_PATH} none swap sw 0 02" | tee -a /etc/fstab

cp "/etc/sysctl.conf" "/etc/sysctl.conf.old"
sed -r '/^vm\.swappiness=[0-9]+$/d' "/etc/sysctl.conf" \
    | tee "/etc/sysctl.conf"
echo "vm.swappiness=${SWAPPINESS}" \
    | tee -a "/etc/sysctl.conf"
