#/bin/bash

#   Copyright 2023 Miljenko Šuflaj
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

printf "[Python] install.sh "

if [[ "$(id -u)" -eq 0 ]]; then
    printf ":: Error (run without root)\n"
    exit 1
fi

THIS="$(realpath $0)"
THIS_DIR="$(dirname ${THIS})"
source "${THIS_DIR}/.config"

INSTALLABLE=( $(ls -1 "${PYTHON_DOWNLOAD_DIR}") )
TO_INSTALL=()
for version in "${INSTALLABLE[@]}"; do
    if [[ ! -d "${PYTHON_PREFIX}/${version}" ]]; then
        TO_INSTALL+=( "${version}" )
    fi
done

if [[ "${#TO_INSTALL[@]}" -eq 0 ]]; then
    printf ":: Done (no version to install)\n"
    exit 0
fi

# Do this to ensure libs are loaded correctly
eval "$(command conda 'shell.bash' 'hook' > /dev/null 2>&1)"
conda deactivate

mkdir -p "${PYTHON_PREFIX}"
for version in "${TO_INSTALL[@]}"; do
    cd "${PYTHON_DOWNLOAD_DIR}/${version}"
    bash ./configure \
        --prefix "${PYTHON_PREFIX}/${version}" \
        --enable-optimizations \
        --with-ensurepip=install \
    > /dev/null 2>&1

    make -j$(($(nproc)+1)) \
        > /dev/null 2>&1
    make altinstall \
        > /dev/null 2>&1
done

printf ":: Done\n"