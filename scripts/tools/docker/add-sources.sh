#/bin/bash

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

printf "[Docker] add-source.sh "

mkdir -p /etc/apt/keyrings
if [[ ! -f '/etc/apt/keyrings/docker.gpg' ]]; then
    curl -fsSL "https://download.docker.com/linux/debian/gpg" \
        | sudo gpg \
            --dearmor \
            -o /etc/apt/keyrings/docker.gpg \
        > /dev/null
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
        | sudo tee /etc/apt/sources.list.d/docker.list \
        > /dev/null
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
fi

printf ":: Done\n"
