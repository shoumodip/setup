#!/bin/sh

# Link
link() {
    mkdir -p $2
    ln -sf $PWD/src/$1 $2
}

# Go
go_version() {
    curl -s "https://go.dev/dl/" | grep -oP "go[0-9]+\.[0-9]+\.[0-9]+\.linux-amd64\.tar\.gz" | head -n 1
}

go_download() {
    echo "[INFO] Downloading Go"

    DIR="$HOME/Software/go"
    URL="https://go.dev/dl/$(go_version)"

    mkdir -p "$DIR"
    curl -sL "$URL" | tar fzx - -C "$DIR" --strip-components 1
}

# Menu
menu_version() {
    curl -s "https://api.github.com/repos/shoumodip/menu/releases/latest" | grep -oP '"tag_name":\s*"\K[^"]+'
}

menu_download() {
    echo "[INFO] Downloading Menu"

    EXE="$HOME/Software/menu"
    URL="https://github.com/shoumodip/menu/releases/download/$(menu_version)/menu-linux-amd64"

    curl -sL "$URL" > "$EXE"
    chmod +x "$EXE"

    EXE="$HOME/Software/menurun"
    URL="https://github.com/shoumodip/menu/releases/download/$(menu_version)/menurun-linux-amd64"

    curl -sL "$URL" > "$EXE"
    chmod +x "$EXE"
}

# NodeJS
node_version() {
    curl -s "https://nodejs.org/dist/index.json" | grep -oP '"version":\s*"\K[^"]+' | head -n 1
}

node_download() {
    echo "[INFO] Downloading NodeJS"

    VER="$(node_version)"
    DIR="$HOME/Software/node"
    URL="https://nodejs.org/dist/$VER/node-$VER-linux-x64.tar.xz"

    mkdir -p "$DIR"
    curl -sL "$URL" | tar fJx - -C "$DIR" --strip-components 1
}

# Neovim
nvim_version() {
    curl -s "https://api.github.com/repos/neovim/neovim/releases/latest" | grep -oP '"tag_name":\s*"\K[^"]+'
}

nvim_download() {
    echo "[INFO] Downloading Neovim"

    DIR="$HOME/Software/nvim"
    URL="https://github.com/neovim/neovim/releases/download/$(nvim_version)/nvim-linux64.tar.gz"

    mkdir -p "$DIR"
    curl -sL "$URL" | tar fzx - -C "$DIR" --strip-components 1
}

# Qrcp
qrcp_version() {
    curl -s "https://api.github.com/repos/claudiodangelis/qrcp/releases/latest" | grep -oP '"tag_name":\s*"\K[^"]+'
}

qrcp_download() {
    echo "[INFO] Downloading Qrcp"

    VER="$(qrcp_version)"
    DIR="$HOME/Software"
    URL="https://github.com/claudiodangelis/qrcp/releases/download/$VER/qrcp_${VER}_linux_amd64.tar.gz"

    curl -sL "$URL" | tar fzx - -C "$DIR" qrcp
}

# Brave
brave_download() {
    sudo curl -fsSLo "/usr/share/keyrings/brave-browser-archive-keyring.gpg" "https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg"

    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee "/etc/apt/sources.list.d/brave-browser-release.list"

    sudo apt update
    sudo apt install brave-browser
}

# Thono
thono_version() {
    curl -s "https://api.github.com/repos/shoumodip/thono/releases/latest" | grep -oP '"tag_name":\s*"\K[^"]+'
}

thono_download() {
    echo "[INFO] Downloading Thono"

    EXE="$HOME/Software/thono"
    URL="https://github.com/shoumodip/thono/releases/download/$(thono_version)/thono-linux-amd64"

    curl -sL "$URL" > "$EXE"
    chmod +x "$EXE"
}

# Main
sudo apt install -y curl bspwm picom sxhkd xclip xwallpaper build-essential

go_download
menu_download
node_download
nvim_download
qrcp_download
brave_download
thono_download

echo "[INFO] Linking Dotfiles"
link .bashrc ~/
link .gitconfig ~/
link .clang-format ~/
link bspwmrc ~/.config/bspwm/
link sxhkdrc ~/.config/sxhkd/
link init.lua ~/.config/nvim/
link gruvbox-material.theme ~/.local/share/xfce4/terminal/colorschemes/
