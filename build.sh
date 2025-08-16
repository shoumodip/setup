#!/bin/sh

# Install programs
sudo apt install alacritty tmux zsh zsh-autosuggestions zsh-syntax-highlighting fonts-jetbrains-mono

# Install Brave
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
sudo curl -fsSLo /etc/apt/sources.list.d/brave-browser-release.sources https://brave-browser-apt-release.s3.brave.com/brave-browser.sources

sudo apt update
sudo apt install brave-browser

# Remove Firefox and Konqueror
sudo apt autoremove firefox konqueror

# Shell
sudo chsh -s $(which zsh) $USER

# Dotfiles
link() {
    mkdir -p $2
    ln -sf $PWD/src/$1 $2
}

link .zshrc ~/
link .gitconfig ~/
link .clang-format ~/

link nvim ~/.config/
link tmux.conf ~/.config/tmux/
link profile.sh ~/.config/plasma-workspace/env/
link alacritty.toml ~/.config/alacritty/

link allwebp2png ~/.local/bin/

# Install neovim
mkdir -p ~/Software/nvim ~/.local/bin

curl -sL "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz" \
    | tar xz -C ~/Software/nvim --strip-components 1

ln -sf ~/Software/nvim/bin/nvim ~/.local/bin
