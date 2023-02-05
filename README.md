# Debian Post-Install

![](https://img.shields.io/github/repo-size/suflaj/debian-post-install?style=flat-square)
![](https://img.shields.io/github/license/suflaj/debian-post-install?style=flat-square)
![](https://img.shields.io/github/last-commit/suflaj/debian-post-install?style=flat-square)

**WARNING**: Not completely tested as of 2023-02-05; coming really soon!

This repository contains files I personally use as post-install scripts.

## OS installation

I use [Debian 11.6 with non-free firmware](https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/11.6.0+nonfree/amd64/iso-dvd/). I use [this method of installation](https://dev.to/brandonwallace/how-to-install-debian-11-bullseye-expert-mode-minimal-install-10pd). There are some relevant differences:

- Auto-configure networking: `Yes`
- NTP server to use: `hr.pool.ntp.org` (since I'm from Croatia)
- Partition disks: Manual
  - I dual boot my system with Windows 10
  - if there is no ESP partition, I create a 512 MB one
  - I allocate the rest to `root`
    - I create a swap file later separately, even though I have 32 GB of RAM

## Installation

There are various components to install. The first you should do is establish an internet connection and setup `sudo`.

### Connecting to the internet

If you installed the minimal install, you will have no desktop environment, and so, you'll need to connect to the internet manually.

First, make sure you're doing everything as `root`:

```bash
su
```

Then, you'll need to find your adapter ID:

```bash
iwconfig
```

You're looking for something named similar to `wlp3s0`, I'm gonna refer to this as `ADAPTER_ID` from now on.

Then you'll need to find the SSID of what you're connecting to. This is the name of your network. You might know this already, and if you do, you can skip this step. If not, run:

```bash
iwlist ADAPTER_ID scan | grep "ESSID"
```

Once you know your SSID, which I'm gonna refer to as `SSID` from now on, you can connect to your WiFi network using your password, which I'm going to refer to as `PASSWORD` via `nmcli`:

```bash
nmcli d wifi connect SSID password PASSWORD
```

After this, you should be connected to the internet.

### Setting up `sudo`

First, you'll need to install `sudo` via apt:

```bash
apt install sudo -y
```

Then, you'll need to add yourself to sudoers. First, open the sudoers file with `nano` (or whatever text editor you like):

```bash
nano /etc/sudoers
```

Then, find the line starting with `root ALL=`, and add the following line under it:

```text
USER ALL=(ALL:ALL) ALL
```

where `USER` is whatever your user is called. Mine is `suflaj`, so I'd write

```text
suflaj ALL=(ALL:ALL) ALL
```

Save the changes (with `ctrl + s` in `nano`), and exit (with `ctrl + x` in `nano`). Now you should have a functional `sudo` command, as well as be able to use it.

### `init.sh`

This is the first thing you should run once you establish and internet connection and setup `sudo`.

First, this script will update `apt` and upgrade all packages. Then, it installs `software-properties-common` so we can add `contrib` and `non-free` repos. Once we do that, we update `apt` again and:

- setup additional package managers (`flatpak` and `snap`)
- setup essential packages for the rest of the installation and smooth operation
- setup the fingerprint sensor
- setup restricted packages
- setup a basic firewall
- setup 8 GB of swap

### `setup-base.sh`

This is likely the thing you want to run second. This will:

- setup a desktop environment (KDE)
- setup some additional fonts we might use
- setup a tiling tool (`bismuth`)
- setup a dock (`latte-dock`)

**WARNING**: Do change the user in:

- `scripts/apps/setup-latte.sh`

to however you're named.

### `setup-more.sh`

This is likely the thing you want to run third. This will:

- setup Google Chrome
- setup Microsoft Edge (yes, I use both, but mainly Edge)
- setup a few apps I use for communication
- setup a few apps I use for multimedia
- setup a few apps I use for productivity
- setup an image viewer (`qimgv`)
- setup the nVidia drivers and PRIME for SDDM
- setup Conda (`miniconda3`)
- setup CUDA (version `12.0`)
- setup Docker
- setup a few useful tools
- setup Python (latest Python `2.7` and `3.X`, but many more)

**WARNING**: Do change the user in:

- `scripts/tools/setup-conda.sh`
- `scripts/tools/setup-cuda.sh`
- `scripts/tools/setup-docker.sh`
- `scripts/tools/setup-python.sh`

to however you're named.

### `setup-tweaks.sh`

This is likely the thing you want to run fourth. Or you might not want to run this at all. This will:

- tweak GRUB (add some settings to GRUB, most importantly change the timeout)
- tweak stuff related to Intel CPU and GPU
- tweak stuff related to power consumption

### `tweaks/tweak-home.sh`

This script is not ran by `setup-tweaks.sh` because it is supposed to be ran without `sudo`. It will change the `HOME` folders in the following way:

- `Desktop` -> `desktop`
- `Documents` -> `documents`
- `Downloads` -> `downloads`
- `Music` -> `documents/music`
- `Pictures` -> `documents/pictures`
- `Public` -> `public`
- `Templates` -> `documents/templates`
- `Videos` -> `documents/videos`

### Chrome extensions

Read the [README](./chrome-extensions/README.md) to find out more.

### GRUB

Read the [README](./grub/README.md) to find out more.

### Wallpapers

Read the [README](./wallpapers/README.md) to find out more.
