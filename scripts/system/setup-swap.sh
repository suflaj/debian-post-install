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

printf "[System] setup-swap.sh "

THIS="$(realpath $0)"
THIS_DIR="$(dirname $THIS)"
source "${THIS_DIR}/.config"

if [[ ! -z "$(free | grep Swap:)" ]]; then
    printf ":: Done (already activated)\n"
    exit 0
fi

if [[ -f "${SWAP_PATH}" ]]; then
    printf ":: Error (already exists)\n"
    exit 1
fi

sudo fallocate -l "${SWAP_SIZE}" "${SWAP_PATH}"
sudo chmod 600 "${SWAP_PATH}"
sudo mkswap "${SWAP_PATH}"

sudo cp /etc/fstab /etc/fstab.old
echo "${SWAP_PATH} none swap sw 0 02" \
    | sudo tee -a /etc/fstab \
    > /dev/null

sudo cp /etc/sysctl.conf /etc/sysctl.conf.old
sed -r '/^vm\.swappiness=[0-9]+$/d' /etc/sysctl.conf \
    | sudo tee /etc/sysctl.conf \
    > /dev/null
echo "vm.swappiness=${SWAPPINESS}" \
    | sudo tee -a /etc/sysctl.conf \
    > /dev/null

printf ":: Done\n"