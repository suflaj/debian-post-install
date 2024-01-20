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

printf "[Ulauncher] add-sources.sh "

gpg --keyserver keyserver.ubuntu.com --recv 0xfaf1020699503176 \
    > /dev/null 2>&1
gpg --export 0xfaf1020699503176 \
    | sudo tee /usr/share/keyrings/ulauncher-archive-keyring.gpg \
    > /dev/null
echo "deb [signed-by=/usr/share/keyrings/ulauncher-archive-keyring.gpg] http://ppa.launchpad.net/agornostal/ulauncher/ubuntu jammy main" \
    | sudo tee /etc/apt/sources.list.d/ulauncher-jammy.list \
    > /dev/null

printf ":: Done\n"
