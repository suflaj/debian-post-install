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

printf "[Python] add-pip-embargo.sh "

if [[ "$(id -u)" -eq 0 ]]; then
    printf ":: Error (run without root)\n"
    exit 1
fi

THIS="$(realpath $0)"
THIS_DIR="$(dirname ${THIS})"
source "${THIS_DIR}/.config"

mkdir -p "${PIP_EMBARGO_PREFIX}"
cp "${PIP_EMBARGO_SOURCE}" "${PIP_EMBARGO_PATH}"

bashrc_path="${HOME}/.bashrc"
dot_pattern="\|\\.\\s+.*\\${PIP_EMBARGO_NAME}|d"
source_pattern="\|source\\s+.*\\${PIP_EMBARGO_NAME}|d"
sed -Ei "${dot_pattern}" "${bashrc_path}" 
sed -Ei "${source_pattern}" "${bashrc_path}" 

echo "source '${PIP_EMBARGO_PATH}'" \
    | tee -a "${bashrc_path}" \
    > /dev/null

printf ":: Done\n\n"

printf "To use pip-embargo:\n"
printf "  1) Reload your shell\n"
printf "    1a) For ex. bash, run \`source ~/.bashrc\`\n"
