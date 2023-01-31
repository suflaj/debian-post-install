#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

# Will set Grub timeout to 1 second, change if you want
GRUB_TIMEOUT=1
GRUB_OPTIONS="quiet splash acpi_rev_override=1 acpi_osi=Linux nouveau.modeset=0 pcie_aspm=force drm.vblankoffdelay=1 scsi_mod.use_blk_mq=1 nouveau.runpm=0 mem_sleep_default=deep"

sed "s/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=${GRUB_TIMEOUT}/" "/etc/default/grub" \
    > tee "/etc/default/grub"
sed "s/^GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT=\"${GRUB_OPTIONS}\"/g" "/etc/default/grub" \
    | tee "/etc/default/grub"
update-grub
