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

printf "[Python] download.sh "

if [[ "$(id -u)" -eq 0 ]]; then
    printf ":: Error (run without root)\n"
    exit 1
fi

THIS="$(realpath $0)"
THIS_DIR="$(dirname ${THIS})"
UTILS="${THIS_DIR}/utils"
source "${THIS_DIR}/.config"

if [[ $# -eq 1 && $1 =~ "help" ]]; then
    printf "download.sh: downloads Python tarballs\n\n"

    printf "USAGE:\n"
    printf "  download.sh python-versions...\n"

    exit 0
fi

DOWNLOADABLE=( $(bash ${UTILS}/query-versions.sh $(echo "$@")) )
if [[ "${#DOWNLOADABLE[@]}" -eq 0 ]]; then
    version_string="$1"
    shift 1

    if [[ "$#" -ne 0 ]]; then
        version_suffix=$(printf ', %s' "$@")
        version_string="${version_string}${version_suffix}"
    fi

    printf ":: Error (no version downloadable)\n"
    exit 1
fi

TO_DOWNLOAD=()
for version in "${DOWNLOADABLE[@]}"; do
    if [[ ! -d "${PYTHON_DOWNLOAD_DIR}/${version}" ]]; then
        TO_DOWNLOAD+=( ${version} )
    fi
done

if [[ "${#TO_DOWNLOAD[@]}" -eq 0 ]]; then
    printf ":: Done (no version to download)\n"
    exit 0
fi

mkdir -p "${PYTHON_DOWNLOAD_DIR}"
for version in "${TO_DOWNLOAD[@]}"; do
    source="${PYTHON_NAME_TO_SOURCE[$version]}"
    unpack_dir="${PYTHON_DOWNLOAD_DIR}/${version}"
    tar_name="${unpack_dir}.tgz"

    mkdir -p "${unpack_dir}"

    wget "${source}" \
        -qO "${tar_name}" \
    > /dev/null
    tar xf "${tar_name}" \
        -C "${unpack_dir}" \
        --strip-components 1 \
    > /dev/null
    rm -f "${tar_name}" \
        > /dev/null
done

printf ":: Done\n"
