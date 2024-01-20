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

THIS=$(realpath $0)
SCRIPTS_DIR=$(dirname "$THIS")
SETUP_PATHS=(
    "${SCRIPTS_DIR}/tools/package-managers/setup.sh"
    "${SCRIPTS_DIR}/system/setup-essentials.sh"
    "${SCRIPTS_DIR}/system/setup-restricted.sh"
    "${SCRIPTS_DIR}/system/setup-firewall.sh"
)

sudo apt update -y -qq \
    > /dev/null 2>&1
sudo apt upgrade -y -qq \
    > /dev/null 2>&1
sudo apt install software-properties-common -y -qq \
    > /dev/null 2>&1

for path in "${SETUP_PATHS[@]}"; do
    bash "${path}"
done
