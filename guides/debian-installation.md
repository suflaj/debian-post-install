# Debian Installation

I use [Debian sid with non-free firmware](https://wiki.debian.org/DebianUnstable). I use [this method of installation](https://dev.to/brandonwallace/how-to-install-debian-11-bullseye-expert-mode-minimal-install-10pd). There are some relevant differences:

- Auto-configure networking: `Yes`
- NTP server to use: `hr.pool.ntp.org` (since I'm from Croatia)
- Partition disks: Manual
  - I dual boot my system with Windows 11
  - if there is no ESP partition, I create a 512 MB one
  - I allocate 2 GB to `boot`
  - I allocate 16 GB to `swap`
  - I allocate the rest to `root`
