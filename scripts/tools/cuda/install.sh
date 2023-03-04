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

printf "[CUDA] install.sh "

if [[ "$(id -u)" -eq 0 ]]; then
    printf ":: Error (run without root)\n"
    exit 1
fi

THIS="$(realpath $0)"
THIS_DIR="$(dirname ${THIS})"
source "${THIS_DIR}/.config"

if [[ ! -d '/usr/local/cuda' ]]; then
    sudo dpkg -i "${CUDA_INSTALLER_PATH}"
fi

cuda_keyrings=$(ls -1 "${CUDA_KEY_DIR}"/cuda-*-keyring.gpg)
cuda_keyrings=$(basename "${cuda_keyrings}")
share_keyrings=$(ls -1 /usr/share/keyrings/cuda-*-keyring.gpg)
share_keyrings=$(basename "${share_keyrings}")
if [[ "${cuda_keyrings}" != "${share_keyrings}" ]]; then
    sudo cp "${CUDA_KEY_DIR}"/cuda-*-keyring.gpg '/usr/share/keyrings/'
    sudo apt update -y -qq \
        > /dev/null 2>&1
fi

sudo apt install cuda -y -qq \
    > /dev/null 2>&1

printf ":: Done\n"
