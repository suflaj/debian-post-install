# Debian Installation

I use [Debian 12 Stable with non-free firmware](https://cdimage.debian.org/debian-cd/current/amd64/iso-dvd/debian-12.4.0-amd64-DVD-1.iso). I use [this method of installation](https://dev.to/brandonwallace/how-to-install-debian-11-bullseye-expert-mode-minimal-install-10pd). There are some relevant differences:

- Auto-configure networking: `Yes`
- NTP server to use: `hr.pool.ntp.org` (since I'm from Croatia)
- Partition disks: Manual
  - I dual boot my system with Windows 11
  - if there is no ESP partition, I create a 512 MB one
  - I allocate 4 GB to `boot`
  - I allocate 32 GB to `swap`
  - I allocate the rest to `root`
