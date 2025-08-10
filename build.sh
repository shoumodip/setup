#!/bin/sh

# Install programs
sudo dnf install alacritty tmux neovim zsh zsh-autosuggestions zsh-syntax-highlighting jetbrains-mono-fonts

# Install Brave
sudo dnf config-manager addrepo --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo dnf install brave-browser

# Remove Firefox
sudo dnf remove firefox

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
