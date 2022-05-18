#!/bin/sh -xe

mkdir -p ~/.local/bin ~/.config ~/.cache
rm -f ~/.*bash* ~/.inputrc

sudo sed -i 's/^\(GRUB_TIMEOUT\)=.*/\1=0/g' /etc/default/grub
sudo sed -i 's/^# \(%wheel ALL=(ALL) NOPASSWD: ALL\)/\1/g' /etc/sudoers
sudo sed -i 's/\(GETTY_ARGS\)=.*/\1="--autologin shoumodip"/g' /etc/sv/agetty-tty1/conf
sudo update-grub

git submodule update --init --recursive
sudo xbps-install -y $(cat packages.txt)

sudo ln -sf /etc/sv/dbus /var/service/
stow -vt ~ */

export HISTFILE=~/.cache/history
