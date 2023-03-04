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

printf "[Bismuth] add-sources.sh "

echo "deb http://deb.volian.org/volian/ scar main" \
    | sudo tee "/etc/apt/sources.list.d/volian-archive-scar-unstable.list" \
    > "/dev/null"
wget -qO - "https://deb.volian.org/volian/scar.key" \
    | sudo tee "/etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg" \
    > "/dev/null"

printf ":: Done\n"