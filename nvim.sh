#!/bin/sh

mkdir -p ~/Software ~/.local/bin
cd ~/Software
rm -rf nvim

echo "[INFO] Downloading"
TAG="$(curl -s "https://api.github.com/repos/neovim/neovim/releases/latest" | grep -oP '"tag_name": "\K(.*)(?=")')"
curl -sLO "https://github.com/neovim/neovim/releases/download/${TAG}/nvim-linux-x86_64.tar.gz"

echo "[INFO] Extracting"
tar fx nvim-linux-x86_64.tar.gz
rm nvim-linux-x86_64.tar.gz

echo "[INFO] Linking"
mv nvim-linux-x86_64 nvim
ln -sf $PWD/nvim/bin/nvim ~/.local/bin
