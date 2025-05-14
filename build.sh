#!/bin/sh

# Packages
sudo xbps-install \
    tmux alacritty neovim zsh zsh-autosuggestions zsh-syntax-highlighting curl ripgrep \
    bspwm sxhkd xsetroot picom xclip xfce4-whiskermenu-plugin libXft \
    base-devel fonts-roboto-ttf noto-fonts-cjk noto-fonts-emoji noto-fonts-ttf-extra \
    mpv mupdf

# Shell
sudo chsh -s $(which zsh) $USER

# Dotfiles
link() {
    mkdir -p $2
    ln -sf $PWD/src/$1 $2
}

link .zshrc ~/
link .profile ~/
link .gitconfig ~/
link .clang-format ~/

link nvim ~/.config/

link bspwmrc ~/.config/bspwm/
link sxhkdrc ~/.config/sxhkd/
link tmux.conf ~/.config/tmux/
link alacritty.toml ~/.config/alacritty/

link settings.ini ~/.config/gtk-2.0/
link settings.ini ~/.config/gtk-3.0/

link menurun ~/.local/bin/
link brave.desktop ~/.local/share/applications/

link allwebp2png ~/.local/bin/

# Icons and Themes
git clone https://github.com/TheGreatMcPain/gruvbox-material-gtk --depth 1
sudo mv gruvbox-material-gtk/icons/Gruvbox-Material-Dark /usr/share/icons/
sudo mv gruvbox-material-gtk/themes/Gruvbox-Material-Dark /usr/share/themes/
rm -rf gruvbox-material-gtk

# Font
FONT=~/.local/share/fonts/JetBrainsMono
mkdir -p $FONT && cd $FONT
curl -LO https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip
unzip *.zip && rm *.zip
cd -

# Switch from Firefox to Brave
./brave.sh
sudo xbps-remove -R firefox

# Thono and Menu
get_sk_util() {
    curl -s https://api.github.com/repos/shoumodip/$1/releases/latest \
        | grep "browser_download_url" \
        | cut -d : -f 2,3 \
        | tr -d ' "' \
        | xargs curl -LO
    chmod +x $1
}

cd ~/.local/bin
get_sk_util thono
get_sk_util menu
cd -

# Background
~/.local/bin/thono -W "src/wallpapers/Forest Steps.jpg"
