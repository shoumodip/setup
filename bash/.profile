#!/bin/zsh

export PATH="$HOME/.local/bin:$HOME/.local/share/go/bin:$PATH"

export EDITOR="nvim"
export BROWSER="qutebrowser"
export TERMINAL="urxvt"

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"

export INPUTRC="$XDG_CONFIG_HOME/inputrc"
export HISTFILE="$XDG_CACHE_HOME/history"
export XAUTHORITY="$XDG_CACHE_HOME/Xauthority"

export GOPATH="$XDG_DATA_HOME/go"
export CARGO_HOME="$XDG_DATA_HOME/cargo"

[ "$(tty)" = "/dev/tty1" ] && exec startx ~/.config/xinitrc 2>/dev/null
