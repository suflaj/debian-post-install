# Debian Installation

I use [Debian 11.6 with non-free firmware](https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/11.6.0+nonfree/amd64/iso-dvd/). I use [this method of installation](https://dev.to/brandonwallace/how-to-install-debian-11-bullseye-expert-mode-minimal-install-10pd). There are some relevant differences:

- Auto-configure networking: `Yes`
- NTP server to use: `hr.pool.ntp.org` (since I'm from Croatia)
- Partition disks: Manual
  - I dual boot my system with Windows 10
  - if there is no ESP partition, I create a 512 MB one
  - I allocate the rest to `root`
    - I create a swap file later separately, even though I have 32 GB of RAM
