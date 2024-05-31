#!/bin/sh

set -xe

ln -sf $PWD/.bashrc ~/
ln -sf $PWD/.gitconfig ~/
ln -sf $PWD/.clang-format ~/

ln -sf $PWD/.config ~/Music/

mkdir -p ~/.config/mpd
ln -sf $PWD/mpd.conf ~/.config/mpd/

mkdir -p ~/.config/nvim
ln -sf $PWD/init.lua ~/.config/nvim/

mkdir -p ~/.config/bspwm
ln -sf $PWD/bspwmrc ~/.config/bspwm/

mkdir -p ~/.config/sxhkd
ln -sf $PWD/sxhkdrc ~/.config/sxhkd/

mkdir -p ~/.local/share/xfce4/terminal/colorschemes
ln -sf $PWD/gruvbox-material.theme ~/.local/share/xfce4/terminal/colorschemes/
