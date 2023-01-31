#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

_USER="suflaj"
INSTALL_DIR="${HOME}/programs/python"
TEMP_DIR="${INSTALL_DIR}/temp"

PYTHON_SOURCES=(
    "https://www.python.org/ftp/python/3.11.1/Python-3.11.1.tgz"
    "https://www.python.org/ftp/python/3.10.9/Python-3.10.9.tgz"
    "https://www.python.org/ftp/python/3.9.16/Python-3.9.16.tgz"
    "https://www.python.org/ftp/python/3.8.16/Python-3.8.16.tgz"
    "https://www.python.org/ftp/python/3.6.15/Python-3.6.15.tgz"
    "https://www.python.org/ftp/python/3.4.10/Python-3.4.10.tgz"
    "https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz"
)
PYTHON_NAMES=(
    "3.11"
    "3.10"
    "3.9"
    "3.8"
    "3.6"
    "3.4"
    "2.7"
)
APT_APPS=(\
    build-essential
    gdb
    lcov
    libbz2-dev
    libffi-dev
    libgdm-compat-dev
    liblzma-dev
    libncurses5-dev
    libreadline6-dev
    libsqlite3-dev
    libssl-dev
    lzma
    lzma-dev
    pkg-config
    tk-dev
    uuid-dev
    xvfb
    zlib1g-dev
)

apt update -y
for app in "${APT_APPS[@]}"; do
    apt install "${app}" -y
done

mkdir -p "${INSTALL_DIR}"
mkdir -p "${TEMP_DIR}"
for i in "${!PYTHON_SOURCES[@]}"; do
    SOURCE="${PYTHON_SOURCES[i]}"
    NAME="${PYTHON_NAMES[i]}"

    DESTINATION="${TEMP_DIR}/${_NAME}"
    PREFIX="${INSTALL_DIR}/${_NAME}"

    wget "${SOURCE}" -O "${DESTINATION}.tgz"
    tar xf "${DESTINATION}.tgz"
    rm -f "${DESTINATION}.tgz"

    cd "${DESTINATION}"
    bash ./configure \
        --prefix "${PREFIX}" \
        --enable-optimizations \
        --with-ensurepip=install
    make -j4
    make install
    chown -R "${_USER}:${_USER}" "${PREFIX}"

    cd ..
    rm -rf "${DESTINATION}"
done

rm -rf "${TEMP_DIR}"
