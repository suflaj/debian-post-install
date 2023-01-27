#/bin/bash

SWAP_PATH="/swap"

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

fallocate -l 8G "${SWAP_PATH}"
chmod 600 "${SWAP_PATH}"
mkswap "${SWAP_PATH}"

cp /etc/fstab /etc/fstab.old
echo "${SWAP_PATH} none swap sw 0 02" | tee -a /etc/fstab

printf 'Run `sudo nano /etc/sysctl.conf`\n'
printf 'Append `vm.swappiness=5`\n'
printf "Can't be bothered scripting this bs\n"
