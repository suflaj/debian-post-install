#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

curl https://packages.microsoft.com/keys/microsoft.asc \
    | gpg --dearmor > microsoft.gpg
install \
    -o root \
    -g root \
    -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" \
    > /etc/apt/sources.list.d/microsoft-edge-dev.list
rm microsoft.gpg
