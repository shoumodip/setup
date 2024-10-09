#!/bin/sh

sudo xbps-install neovim xclip bspwm sxhkd fish-shell base-devel fonts-roboto-ttf font-iosevka papirus-icon-theme xsetroot feh slock

link() {
    mkdir -p $2
    ln -sf $PWD/src/$1 $2
}

link .gitconfig ~/
link .clang-format ~/
link buttons ~/.config/feh/
link bspwmrc ~/.config/bspwm/
link sxhkdrc ~/.config/sxhkd/
link init.lua ~/.config/nvim/
link snippets.lua ~/.config/nvim/lua/

link config.fish ~/.config/fish/
link fish_variables ~/.config/fish/
link fish_prompt.fish ~/.config/fish/functions/
link gruvbox-material.theme ~/.local/share/xfce4/terminal/colorschemes/
