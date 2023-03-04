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

printf "[Tweaks] tweak-power.sh "

THIS="$(realpath $0)"
THIS_DIR="$(dirname ${THIS})"
source "${THIS_DIR}/.config"

sudo apt install $(echo ${POWER_PACKAGES[@]}) -y -qq \
    > /dev/null 2>&1

sudo cp "${THIS_DIR}/tlp.conf" /etc/tlp.conf
sudo systemctl restart tlp

sudo adduser "${USER}" bumblebee \
    > /dev/null

printf ":: Done\n"