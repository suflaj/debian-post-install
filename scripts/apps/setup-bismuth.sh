#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

echo "deb http://deb.volian.org/volian/ scar main" \
    > tee "/etc/apt/sources.list.d/volian-archive-scar-unstable.list" \
        > "/dev/null"
wget -q0 - "https://deb.volian.org/volian/scar.key" \
    | tee "/etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg" \
        > "/dev/null"
apt update -y
apt install kwin-bismuth -y
