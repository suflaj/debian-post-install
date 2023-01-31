#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Must run as root"
    exit 1
fi

EXTENSION_IDENTIFIERS=(\
    "13xforever.language-x86-64-assembly"   # x86 highlighting
    "dan-c-underwood.arm"                   # ARM highlighting
    "file-icons.file-icons"                 # File icons
    "grapecity.gc-excelviewer"              # CSV viewer
    "gruntfuggly.todo-tree"                 # Todo Tree
    "hnw.vscode-auto-open-markdown-preview" # Auto-open Markdown preview
    "mechatroner.rainbow-csv"               # Rainbow CSV
    "ms-python.python"                      # Python
    "ms-python.vscode-pylance"              # Pylance
    "ms-vscode.cpptools"                    # C/C++
    "ms-vscode-remote.remote-ssh"           # Remote SSH
    "njpwerner.autodocstrin"                # Auto docstring
    "oderwat.indent-rainbow"                # Rainbow indentation
    "shd101wyy.markdown-preview-enhanced"   # Markdown preview
    "sirtori.indenticator"                  # Indenticator
    "stkb.rewrap"                           # Rewrap text
    "streetsidesoftware.code-spell-checker" # Spell checker
    "stuart.unique-window-colors"           # Window Colors
    "tyriar.sort-lines"                     # Sort lines
    "usernamehw.errorlens"                  # Error Lens
    "vscode-icons-team.vscode-icons"        # VSCode Icons
    "yzane.markdown-pdf"                    # Markdown PDF
    "yzhang.markdown-all-in-one"            # Markdown All in One
    "zhuangtongfa.material-theme"           # One Dark Pro
)

snap install \
    code \
--classic

for identifier in "${EXTENSION_IDENTIFIERS[@]}"; do
    code --install-extension "${identifier}"
done
