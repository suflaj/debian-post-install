# Wallpapers

Generally, I really like digital impressionism. In that regard, the 2 big names for me are
[Marta Nael](https://martanael.com/projects) and [Alena
Aenami](https://www.artstation.com/aenamiart). However, most wallpaper images are made
by Alena.

In `wallpapers.csv`, I've compiled a list of URLs for the wallpapers I use.
Please make sure to support the artists if you like these images.

## Usage

To download the folders to your `~/wallpapers` folder, simply run

```bash
bash wallpapers/download-wallpapers.sh
```

It's also possible to change the destination folder by passing an argument:

```bash
bash wallpapers/download-wallpapers.sh /the/path/you/want
```

If that location requires `root` permissions, you can call it with `sudo`, and then pass
the `user` as the 2nd parameter to chown the destination for recursively:

```bash
sudo bash wallpapers/download-wallpapers.sh /path/requiring/root user
```