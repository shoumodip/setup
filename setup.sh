#!/bin/sh

info() {
    echo "$(tput bold)> $@$(tput sgr0)"
}

link() {
    dest="$HOME/$2"

    if echo "$dest" | grep -q "/$"; then
        dest="$dest$(basename "$1")"
    fi

    mkdir -p "$(dirname "$dest")"
    unlink "$dest"
    ln -s "$PWD/files/$1" "$dest"
}

link_dotfiles() {
    info "Linking dotfiles"
    link "alacritty"         ".config/"
    link "bin/dmenu"         ".local/bin/"
    link "bin/notflix"       ".local/bin/"
    link "bin/dmenu_project" ".local/bin/"
    link "fontconfig"        ".config/"
    link "i3"                ".config/"
    link "i3status"          ".config/"
    link "nvim"              ".config/"
    link "qutebrowser"       ".config/"
    link "tmux"              ".config/"
    link "zsh"               ".config/"
    link "gitconfig"         ".gitconfig"
    link "zprofile"          ".zprofile"
    link "xinitrc"           ".config/"
}

install_packages() {
    info "Installing packages"
    sudo xbps-install -y $(cat packages.txt)

    if [ ! -d ~/code/thono ]; then
        info "Setting up thono"
        git clone https://github.com/shoumodip/thono ~/code/thono
        cd ~/code/shoumodip/thono
        cc -o make make.c
        ./make
        ln -sf $PWD/shoumodip/thono ~/.local/bin/
    fi
}

if [ "$1" = "push" ]; then
    cd "$(dirname $(realpath $0))"
    xbps-query -m | sed 's/^\([^ ]*\)-.*/\1/' > packages.txt

    if [ $(git status -s | wc -l) -gt 0 ]; then
        git add -A
        git commit -m "Autocommit $(date '+%H:%M:%S %d/%m/%y')"
        git push origin main
    fi
else
    sudo sed -i 's/^# \(%wheel ALL=(ALL) NOPASSWD: ALL\)/\1/g' /etc/sudoers
    sudo sed -i 's/^\(GETTY_ARGS\)=.*/\1="--autologin shoumodip"/g' /etc/sv/agetty-tty1/conf
    sudo sed -i 's/^\(GRUB_TIMEOUT\)=.*/\1=0/g' /etc/default/grub

    sudo update-grub
    install_packages
    link_dotfiles

    sudo ln -sf /etc/sv/dbus /var/service/
    sudo chsh -s /bin/zsh $USER

    rm -rf ~/*bash*
    sudo reboot
fi
