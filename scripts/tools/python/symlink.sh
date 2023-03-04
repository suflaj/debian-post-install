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

printf "[Python] symlink.sh "

if [[ "$(id -u)" -eq 0 ]]; then
    printf ":: Error (run without root)\n"
    exit 1
fi

THIS="$(realpath $0)"
THIS_DIR="$(dirname ${THIS})"
source "${THIS_DIR}/.config"

for python_dir in $(find "${PYTHON_PREFIX}" -maxdepth 1 -mindepth 1 -type d | grep -E '[0-9]+\.[0-9]+$'); do
    bin_dir="${python_dir}/bin"
    version="$(basename ${python_dir})"
    major_version="$(echo ${version} | cut -d. -f1)"

    python_dests=()
    for name in python "python${major_version}"; do
        dest="${bin_dir}/${name}"
        if [[ ! -f "${dest}" ]]; then
            python_dests+=( "${dest}" )
        fi
    done
    if [[ "${#python_dests[@]}" -ne 0 ]]; then
        src="${bin_dir}/python${version}"
        for dest in "${python_dests[@]}"; do
            ln -s "${src}" "${dest}"
        done
    fi

    pip_dests=()
    for name in pip "pip${major_version}"; do
        dest="${bin_dir}/${name}"
        if [[ ! -f "${dest}" ]]; then
            pip_dests+=( "${dest}" )
        fi
    done
    if [[ "${#pip_dests[@]}" -ne 0 ]]; then
        src="${bin_dir}/pip${version}"
        for dest in "${pip_dests[@]}"; do
            ln -s "${src}" "${dest}"
        done
    fi
done

printf ":: Done\n"
