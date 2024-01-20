#!/bin/bash

#   Copyright 2024 Miljenko Šuflaj
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

printf "[Flameshot] setup-shortcuts-kde.sh "

if [[ $(id -u) -eq 0 ]]; then
    printf ":: Error (run without root)\n"
    exit 1
fi

THIS=$(realpath $0)
THIS_DIR="$(dirname ${THIS})"
source "${THIS_DIR}/.config"

sudo apt install khotkeys -y -qq > /dev/null 2>&1

mkdir -p "${FLAMESHOT_INSTALL_DIR}"
if [[ ! -f "${FLAMESHOT_SHORTCUTS_PATH}" ]]; then
    wget "${FLAMESHOT_SHORTCUTS_SOURCE}" \
        -qO "${FLAMESHOT_SHORTCUTS_PATH}" \
        > /dev/null
fi

printf ":: Done\n\n"

printf "To enable Flameshot shortcuts:\n"
printf "  1) Go to System Settings; Shortcuts; Custom Shortcuts\n"
printf "  2) Remove any Spectacle shortcuts\n"
printf "    2a) Look for them in Shortcuts as well\n"
printf "  3) Click Edit; Import\n"
printf "    3a) Navigate to ${FLAMESHOT_INSTALL_DIR}\n"
printf "    3b) Open ${FLAMESHOT_SHORTCUTS_NAME}\n"
printf "  4) Click Apply\n"
