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

printf "[Microsoft Edge] add-sources.sh "

sudo wget -qO - "https://packages.microsoft.com/keys/microsoft.asc" \
    | sudo gpg --dearmor \
    | sudo tee "/usr/share/keyrings/microsoft-edge.gpg" \
        > "/dev/null"
echo 'deb [signed-by=/usr/share/keyrings/microsoft-edge.gpg] https://packages.microsoft.com/repos/edge stable main' \
    | sudo tee "/etc/apt/sources.list.d/microsoft-edge.list" \
        > "/dev/null"

printf ":: Done\n"

