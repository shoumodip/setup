# Setup
Configuration files for Debian KDE

## Quick Start
```console
$ ./build.sh
```

## Notes
### Clang LSP
Use `:MasonInstall clangd@21.1.0` because some small dicked loser decided to be
a pedantic nerd about the styling options in the latest `clang-format`

### Wine
Download [`winetricks`](https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks)

```console
$ sudo dpkg --add-architecture i386
$ sudo apt update
$ sudo apt install wine wine32 cabextract
$ winetricks vcrun2022
```
