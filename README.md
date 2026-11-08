# Setup
Configuration files for Debian KDE

## Quick Start
```console
$ ./build.sh
```

## Notes
### Wine
Download [`winetricks`](https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks)

```console
$ sudo dpkg --add-architecture i386
$ sudo apt update
$ sudo apt install wine wine32 cabextract
$ winetricks vcrun2022
```

### Wallpaper
- [Link](https://4kwallpapers.com/nature/stac-a-phris-arch-26748.html)
- For login screen, move the image into `/usr/share/sddm/themes/breeze/` and update the `background` field in `theme.conf`
