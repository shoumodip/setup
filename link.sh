#!/bin/sh

link() {
  mkdir -p $2
  ln -sf $PWD/src/$1 $2
}

link .bashrc ~/
link .gitconfig ~/
link .clang-format ~/
link init.lua ~/.config/nvim/
link tmux.conf ~/.config/tmux/
link alacritty.yml ~/.config/alacritty/
link gruvbox-material.theme ~/.local/share/xfce4/terminal/colorschemes/
