#!/bin/sh

# Install programs
sudo apt install alacritty tmux ripgrep wl-clipboard zsh zsh-autosuggestions zsh-syntax-highlighting fonts-roboto fonts-jetbrains-mono

# Remove Konqueror
sudo apt autoremove konqueror

# Shell
sudo chsh -s $(which zsh) $USER

# Dotfiles
link() {
    mkdir -p $2
    ln -sf $PWD/src/$1 $2
}

link .zshrc ~/
link .zprofile ~/
link .gitconfig ~/
link .clang-format ~/

link nvim ~/.config/
link tmux.conf ~/.config/tmux/
link alacritty.toml ~/.config/alacritty/

link allwebp2png ~/.local/bin/

# Install neovim
mkdir -p ~/Software/nvim ~/.local/bin

curl -sL "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz" \
    | tar xz -C ~/Software/nvim --strip-components 1

ln -sf ~/Software/nvim/bin/nvim ~/.local/bin
