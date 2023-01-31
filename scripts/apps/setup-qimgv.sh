#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

add-apt-repository ppa:easymodo/qimgv
apt update -y
apt install qimgv -y
