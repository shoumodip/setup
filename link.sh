#!/bin/sh

link() {
  mkdir -p $2
  ln -sf $PWD/src/$1 $2
}

link .bashrc ~/
link .gitconfig ~/
link .clang-format ~/
link .config ~/Music/
link mpd.conf ~/.config/mpd/
link init.lua ~/.config/nvim/
link bspwmrc ~/.config/bspwm/
link sxhkdrc ~/.config/sxhkd/
link gruvbox-material.theme ~/.local/share/xfce4/terminal/colorschemes/
