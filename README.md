# Debian Post-Install

![](https://img.shields.io/github/repo-size/suflaj/debian-post-install?style=flat-square)
![](https://img.shields.io/github/license/suflaj/debian-post-install?style=flat-square)
![](https://img.shields.io/github/last-commit/suflaj/debian-post-install?style=flat-square)

This repository contains files I personally use as post-install scripts.

## Guides

- [Debian 11 installation guide](./guides/debian-11-installation-guide.md)
- [Connecting to the internet](./guides/connecting-to-the-internet.md)
- [Setting up `sudo`](./guides/setting-up-sudo.md)

### `init.sh`

This is the first thing you should run once you establish and internet connection and setup `sudo`.

First, this script will update `apt` and upgrade all packages. Then, it installs `software-properties-common` so we can add `contrib` and `non-free` repos. Once we do that, we update `apt` again and:

- setup additional package managers (`flatpak` and `snappy`)
- setup essential packages for the rest of the installation and smooth operation
- setup restricted packages
- setup a basic firewall
- setup 8 GB of swap (you can change that [here](./scripts/system/.config))

### `setup-base.sh`

This is likely the thing you want to run second. This will:

- setup a desktop environment (KDE)
- setup some additional fonts we might use
- setup a tiling tool (`bismuth`)
- setup a dock (`latte-dock`)

### `setup-more.sh`

This is likely the thing you want to run third. This will:

- setup Google Chrome
- setup Microsoft Edge (yes, I use both, but mainly Edge)
- setup a few apps I use for communication, multimedia and productivity
- setup Flameshot and the shortcuts for it
- setup Spotify
- setup Visual Studio Code and some extensions I use
- setup the nVidia drivers
- setup Conda (`miniconda3`)
- setup CUDA (version `12.0`)
- setup Docker
- setup a few useful tools
- setup Python (latest Python `2.7` and `3.X`, among others) and [`pip-embargo`](./scripts/tools/python/.pip-embargo)

### `setup-tweaks.sh`

This is likely the thing you want to run fourth. Or you might not want to run this at all. This will:

- tweak GRUB (add some settings to GRUB, most importantly change the timeout)
- tweak the Home folders (ex. `~/Pictures` -> `~/documents/pictures`)
- tweak stuff related to Intel CPU and GPU
- tweak stuff related to power consumption

### Chrome extensions

Read the [Chrome extensions README](./chrome-extensions/README.md) to find out more.

### GRUB

Read the [GRUB README](./grub/README.md) to find out more.

### Wallpapers

Read the [Wallpapers README](./wallpapers/README.md) to find out more.
