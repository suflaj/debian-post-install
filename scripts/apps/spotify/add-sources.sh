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

printf "[Spotify] add-sources.sh "

curl -sS "https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg" \
    | sudo gpg \
        --dearmor \
        --yes \
        -o /etc/apt/trusted.gpg.d/spotify.gpg \
    > /dev/null
echo "deb http://repository.spotify.com stable non-free" \
    | sudo tee /etc/apt/sources.list.d/spotify.list \
    > /dev/null

printf ":: Done\n"