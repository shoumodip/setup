#!/bin/zsh

export PATH="$HOME/.local/bin:$HOME/.local/share/go/bin:$PATH"

export EDITOR="nvim"
export BROWSER="qutebrowser"
export TERMINAL="alacritty"

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"

export XINITRC="$XDG_CONFIG_HOME/xinitrc"
export XAUTHORITY="$XDG_CACHE_HOME/Xauthority"
export QTWEBENGINE_DISABLE_GPU_THREAD=1

export PS1="\[\e[1;36m\]\w\[\e[0m\] "
export HISTFILE="$XDG_CACHE_HOME/history"

export GOPATH="$XDG_DATA_HOME/go"
export GLOSPATH="$HOME/code/shoumodip/glos/"
export CARGO_HOME="$XDG_DATA_HOME/cargo"

[ "$(tty)" = "/dev/tty1" ] && exec startx "$XINITRC" 2>/dev/null
