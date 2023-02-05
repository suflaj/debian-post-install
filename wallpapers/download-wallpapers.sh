#!/bin/bash

THIS=$(realpath $0)
WALLPAPERS_DIR="$(dirname "$THIS")"

DESTINATION_FOLDER="$(xdg-user-dir PICTURES)/wallpapers"
_USER=""

if [[ $# -eq 1 ]]; then
    DESTINATION_FOLDER="$1"
elif [[ $# -eq 2 ]]; then
    _USER="$2"
elif [[ $# -gt 2 ]]; then
    printf "This scripts takes up to 2 parameters!\n"
    exit 1
fi

# Make sure CSV always has 2nd column as filenames, 3rd as URLs
filenames=( $(cut -d ',' -f2 "${WALLPAPERS_DIR}/wallpapers.csv") )
urls=( $(cut -d ',' -f3 "${WALLPAPERS_DIR}/wallpapers.csv") )

# Remove headers
unset filenames[0]
unset urls[0]

printf "Downloading to ${DESTINATION_FOLDER}:\n"
mkdir -p "${DESTINATION_FOLDER}"
for i in "${!urls[@]}"; do
    filename="${filenames[i]}"
    url="${urls[i]}"

    destination="${DESTINATION_FOLDER}/${filename}"

    printf "  Downloading ${filename}...\n"
    wget "${url}" -O "${destination}" -q
done

if [[ ! -z "${_USER}" ]]; then
    printf "Running chown for ${_USER} on ${DESTINATION_FOLDER}\}"
    chown -R "${_USER}:${_USER}" "${DESTINATION_FOLDER}"
fi
