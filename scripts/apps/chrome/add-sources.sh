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

printf "[Google Chrome] add-sources.sh "

wget -qO - "https://dl.google.com/linux/linux_signing_key.pub" \
    | sudo gpg --dearmor \
    | sudo tee "/usr/share/keyrings/googlechrome-linux-keyring.gpg" \
        > "/dev/null"
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/googlechrome-linux-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" \
    | sudo tee "/etc/apt/sources.list.d/google-chrome.list" \
        > "/dev/null"

printf ":: Done\n"
