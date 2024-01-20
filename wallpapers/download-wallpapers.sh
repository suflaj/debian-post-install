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

printf "[Wallpapers] download-wallpapers.sh "

THIS=$(realpath $0)
WALLPAPERS_DIR="$(dirname "$THIS")"
DESTINATION_FOLDER="$(xdg-user-dir PICTURES)/wallpapers"

if [[ $# -eq 1 ]]; then
    DESTINATION_FOLDER="$1"
elif [[ $# -gt 1 ]]; then
    printf ":: Error (script takes up to 1 parameter)\n"
    exit 1
fi

# Make sure CSV always has 2nd column as filenames, 3rd as URLs
filenames=( $(cut -d ',' -f2 "${WALLPAPERS_DIR}/wallpapers.csv") )
urls=( $(cut -d ',' -f3 "${WALLPAPERS_DIR}/wallpapers.csv") )

# Remove headers
unset filenames[0]
unset urls[0]

mkdir -p "${DESTINATION_FOLDER}"
for i in "${!urls[@]}"; do
    filename="${filenames[i]}"
    url="${urls[i]}"

    destination="${DESTINATION_FOLDER}/${filename}"
    if [[ ! -f "${destination}" ]]; then
        wget "${url}" -O "${destination}" -q \
            > /dev/null
    fi
done

printf ":: Done\n"
