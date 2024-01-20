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

printf "[NVIDIA] initialize.sh "

XSETUP_PATH="/usr/share/sddm/scripts/Xsetup"
LINES_TO_ADD=(
    'xrandr --setprovideroutputsource modesetting NVIDIA-0'
    'xrandr --auto'
    'xrandr --dpi 96'
)

for line in "${LINES_TO_ADD[@]}"; do
    if [[ -z $(cat "${XSETUP_PATH}" | grep -Ex \'"${line}"\') ]]; then
        echo "${line}" \
            | sudo tee -a "${XSETUP_PATH}" \
            > /dev/null
    fi
done

printf ":: Done\n\n"

printf "To apply NVIDIA sddm settings:\n"
printf "  1) Save your work\n"
printf "  2) Run \`sudo systemctl restart sddm\`\n"
