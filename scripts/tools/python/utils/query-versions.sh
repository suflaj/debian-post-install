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

THIS="$(realpath $0)"
THIS_DIR="$(dirname ${THIS})"
PYTHON_DIR="$(dirname ${THIS_DIR})"
source "${PYTHON_DIR}/.config"

AVAILABLE_VERSIONS=( "${!PYTHON_NAME_TO_SOURCE[@]}" )

if [[ $# -eq 0 ]]; then
    version_args=( "${AVAILABLE_VERSIONS[@]}" )
elif [[ $# -eq 1 ]]; then
    if [[ $1 =~ "help" ]]; then
        printf "query-versions.sh: prints out Python versions eligible for install\n\n"

        printf "USAGE:\n"
        printf "  query-versions.sh python-versions...\n"

        exit 0
    else
        version_args="$1"
        version_args=( ${version_args} )
    fi
else
    version_args=( $@ )
fi

for version in "${version_args[@]}"; do
    if [[ $(printf '%s\n' "${AVAILABLE_VERSIONS[@]}" | grep -Ex "${version}") ]]; then
        printf "${version}\n"
    fi
done
