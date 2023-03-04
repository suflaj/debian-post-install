#!/bin/bash

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

THIS=$(realpath $0)
SCRIPTS_DIR=$(dirname "$THIS")
SETUP_PATHS=(
    "${SCRIPTS_DIR}/apps/chrome/setup.sh"
    "${SCRIPTS_DIR}/apps/edge/setup.sh"
    "${SCRIPTS_DIR}/apps/misc/setup.sh"
    "${SCRIPTS_DIR}/apps/vscode/setup.sh"
    "${SCRIPTS_DIR}/tools/nvidia/setup.sh"
    "${SCRIPTS_DIR}/tools/conda/setup.sh"
    "${SCRIPTS_DIR}/tools/cuda/setup.sh"
    "${SCRIPTS_DIR}/tools/docker/setup.sh"
    "${SCRIPTS_DIR}/tools/setup-misc.sh"
    "${SCRIPTS_DIR}/tools/python/setup.sh"
)

apt update -y -qq \
    > /dev/null 2>&1

for path in "${SETUP_PATHS[@]}"; do
    bash "${path}"
done
