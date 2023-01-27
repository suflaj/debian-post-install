#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

__USER__="suflaj"
HOME="/home/${__USER__}"

MINICONDA_URL=\
"https://repo.anaconda.com/miniconda/Miniconda3-py310_22.11.1-1-Linux-x86_64.sh"

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

# Python dependencies --------------------------------------------
apt update -y
apt upgrade -y
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


TEMP="${HOME}/__temp-setup-python__"
rm -rfI "${TEMP}"
mkdir "${TEMP}"

INSTALLER_NAME="miniconda-installer.sh"
INSTALLER_PATH="${TEMP}/${INSTALLER_NAME}"
PREFIX="${HOME}/programs/miniconda"

wget ${MINICONDA_URL} \
    -O "${INSTALLER_PATH}"
bash "${TEMP}" -b -p "${PREFIX}"
mv "${INSTALLER_PATH}" "${PREFIX}/${INSTALLER_NAME}"
eval "$("$PREFIX}/bin/conda" shell.bash hook)"

for i in "${!PYTHON_SOURCES[@]}"; do
    url="${PYTHON_SOURCES[i]}"
    name="${PYTHON_NAMES[i]}"
    path="${TEMP}/${name}"

    wget "${url}" -O "${path}.tgz"

    tar xf "${path}.tgz"
    cd "${path}"

    bash ./configure \
        --prefix "${HOME}/programs/python/${name}" \
        --enable-optimizations \
        --with-ensurepip=install
    make -j4
    make install
done

rm -rf "${TEMP}"
chown -R "${__USER__}:${__USER__}" "${HOME}/programs/python"
