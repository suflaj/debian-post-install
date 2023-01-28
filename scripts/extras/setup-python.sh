#!/bin/bash

__USER__="suflaj"

PYTHON_SOURCES=( \
    "https://www.python.org/ftp/python/3.11.1/Python-3.11.1.tgz" \
    "https://www.python.org/ftp/python/3.10.9/Python-3.10.9.tgz" \
    "https://www.python.org/ftp/python/3.9.16/Python-3.9.16.tgz" \
    "https://www.python.org/ftp/python/3.8.16/Python-3.8.16.tgz" \
    "https://www.python.org/ftp/python/3.6.15/Python-3.6.15.tgz" \
    "https://www.python.org/ftp/python/3.4.10/Python-3.4.10.tgz" \
)
PYTHON_NAMES=( \
    "3.11" \
    "3.10" \
    "3.9" \
    "3.8" \
    "3.6" \
    "3.4" \
)

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

# Update & upgrade -----------------------------------------------
apt update -y
apt upgrade -y

# Python dependencies --------------------------------------------
apt install \
    build-essential \
    gdb \
    lcov \
    libbz2-dev \
    libffi-dev \
    libgdm-compat-dev \
    liblzma-dev \
    libncurses5-dev \
    libreadline6-dev \
    libsqlite3-dev \
    libssl-dev \
    lzma \
    lzma-dev \
    pkg-config \
    tk-dev \
    uuid-dev \
    xvfb \
    zlib1g-dev \
-y

# Temporary folder setup -----------------------------------------
TEMP="${HOME}/__temp__setup-python"
mkdir -p "${TEMP}"

# Python installations -------------------------------------------
for i in "${!PYTHON_SOURCES[@]}"; do
    url="${PYTHON_SOURCES[i]}"
    name="${PYTHON_NAMES[i]}"
    path="${TEMP}/${name}"
    prefix="${HOME}/programs/python/${name}"

    wget "${url}" -O "${path}.tgz"
    tar xf "${path}.tgz"
    rm -f "${path}.tgz"

    cd "${path}"
    bash ./configure \
        --prefix "${prefix}" \
        --enable-optimizations \
        --with-ensurepip=install
    make -j4
    make install
    chown -R "${__USER__}:${__USER__}" "${prefix}"

    cd ..
    rm -rf "${path}"
done