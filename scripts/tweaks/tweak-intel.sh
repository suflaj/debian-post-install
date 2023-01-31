#/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

APT_APPS=(
    intel-microcode
    iucode-tool
)

apt update -y
for app in "${APT_APPS[@]}"; do
    apt install "${app}" -y
done

# Power saving tweaks
echo "options i915 enable_fbc=1 enable_guc=3 disable_power_well=0 fastboot=1" \
    | tee "etc/modprobe.d/i915.conf"
