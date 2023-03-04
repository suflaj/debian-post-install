# Setting up `sudo`

This requires an internet connection. If you still haven't connected to the internet, check out [Connecting to the internet](./connecting-to-the-internet.md).

First, you'll need to install `sudo` via apt:

```bash
apt update && apt install sudo -y
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
