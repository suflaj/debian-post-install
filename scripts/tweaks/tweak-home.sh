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

printf "[Tweaks] tweak-home.sh "

if [[ "$(id -u)" -eq 0 ]]; then
    printf ":: Error (run without root)\n"
    exit 1
fi

THIS="$(realpath $0)"
THIS_DIR="$(dirname ${THIS})"
source "${THIS_DIR}/.config"

sudo apt install xdg-user-dirs -y -qq \
    > /dev/null 2>&1

for xdg_name in "${!XDG_NAME_TO_DIR[@]}"; do
    current_dir=$(xdg-user-dir "${xdg_name}")
    new_dir="${HOME}/${XDG_NAME_TO_DIR[${xdg_name}]}"

    if [[ -z "${current_dir}" || -z "${new_dir}" ]]; then
        continue
    elif [[ "${current_dir}" != "${new_dir}" ]]; then
        mv "${current_dir}" "${new_dir}"
        xdg-user-dirs-update --set "${xdg_name}" "${new_dir}"
    fi
done

printf ":: Done\n"
exit 0
