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

printf "[System] setup-firewall.sh "

sudo apt install ufw -y -qq \
    > /dev/null 2>&1

if [[ -z $(sudo ufw status | grep -Ei 'status:\s+active' ) ]]; then
    sudo ufw enable \
        > /dev/null
fi

printf ":: Done\n"
