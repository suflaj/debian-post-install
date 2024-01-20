# Connecting to the internet

If you install Debian without a DE, chances are you're not going to be connected to the internet when you boot up. If `sudo` is not install, run

```bash
su
```

and omit the `sudo` commands in the rest of the code snippets. If it is, better just use it as-is. The first thing you should do is find the ID of your WiFi adapter:

```bash
sudo iwconfig
```

You are expecting something named `wlp#s0`, where `#` is some number. For me it is 59; so `wlp59s0`, replace it with your number for the commands. Then you will associate the interface with an access point:

```bash
sudo rfkill unblock wifi
sudo ip link set dev wlp59s0 up
```

If you know the SSID of the network you are connecting to, you can skip this step. You can find the SSID of your network by running

```bash
sudo iwlist wlp59s0 scan | grep ESSID
```

and looking up your network. Once you know your network's SSID, you'll need to authenticate yourself by providing it alongside the password:

```bash
wpa_passphrase "SSID" "PASSWORD" \
    | sudo tee -a /etc/wpa_supplicant/wpa_supplicant.conf
```

just replace the `SSID` with the SSID of your network, and `PASSWORD` with the actual password to that network. Now, connect to your network:

```bash
sudo wpa_supplicant -B -c /etc/wpa_supplicant.conf -i wlp59s0
```

And finally, get yourself an IP address:

```bash
sudo dhclient wlp59s0
```

You should be able to use `apt` now and run all the scripts here. If `sudo` wasn't installed, remember to run

```bash
apt update && apt install sudo
```

before advancing, since you'll need it for most scripts.
