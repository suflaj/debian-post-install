#/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

APT_APPS=(
    powertop
    thermald
    tlp
    tlp-rdw
)

apt update -y
for app in "${APT_APPS[@]}"; do
    apt install "${app}" -y
done

sed '/RESTORE_DEVICE_STATE_ON_STARTUP/s/=.*/=1/' \
    | tee "/etc/tlp.conf"
echo "PCIE_ASPM_ON_BAT=powersupersave" \
    tee -a "/etc/tlp.conf"
systemctl restart tlp
