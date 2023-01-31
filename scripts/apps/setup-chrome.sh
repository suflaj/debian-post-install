#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

wget -qO - "https://dl.google.com/linux/linux_signing_key.pub" \
    | gpg \
        --dearmor \
        -o "/usr/share/keyrings/googlechrome-linux-keyring.gpg"
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/googlechrome-linux-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" \
    | tee "/etc/apt/sources.list.d/google-chrome.list"
apt update -y
apt install google-chrome-stable -y
