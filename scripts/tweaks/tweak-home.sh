#!/bin/bash

USER_DIRS_PATH="${HOME}/.config/user-dirs.dirs"
COMPONENTS=(
    DESKTOP
    DOCUMENTS
    DOWNLOAD
    MUSIC
    PICTURES
    PUBLICSHARE
    TEMPLATES
    VIDEOS
)
NAMES=(
    "desktop"
    "documents"
    "downloads"
    "music"
    "pictures"
    "public"
    "templates"
    "videos"
)

for i in "${!COMPONENTS[@]}"; do
    component="${COMPONENTS[i]}"
    name="${NAMES[i]}"

    new_path="\$HOME/${name}"
    var_name="XDG_${component}_DIR"

    mv "$(xdg.user-dir ${component})" "${new_path}"
    sed -i "s|^${var_name}=.*$|${var_name}=\"${new_path}\"|" "${USER_DIRS_PATH}"
done
