#!/bin/sh

# Install programs
sudo apt install alacritty tmux ripgrep wl-clipboard zsh zsh-autosuggestions zsh-syntax-highlighting fonts-roboto

# Install Brave
curl -fsS "https://dl.brave.com/install.sh" | sh

# Remove Firefox and Konqueror
sudo apt autoremove firefox-esr konqueror

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

# Install tree-sitter-cli
curl -sL "https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-cli-linux-x64.zip" \
    | funzip > ~/.local/bin/tree-sitter

chmod +x ~/.local/bin/tree-sitter

# Install JetBrainsMono Nerd Font
FONT_DIR_PATH="$HOME/.local/share/fonts/JetBrainsMono Nerd Font"
FONT_ZIP_PATH="JetBrainsMono.zip"

mkdir -p "$FONT_DIR_PATH" && cd "$FONT_DIR_PATH"
curl -LO "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/$FONT_ZIP_PATH"
unzip "$FONT_ZIP_PATH" && rm "$FONT_ZIP_PATH"
