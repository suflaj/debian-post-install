#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

APT_APPS=(
    fprintf
    libpam-fprintd
)

apt update -y
for app in "${APT_APPS[@]}"; do
    apt install "${app}" -y
done

fprintd-enroll
pam-auth-update --enable fprintd
