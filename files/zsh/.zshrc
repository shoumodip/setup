#!/bin/zsh

# Colors
autoload -U colors && colors
export PS1="%B%{$fg[cyan]%}%~ [%?]%{$reset_color%}%b "
eval "$(dircolors)"

# Autocompletion
autoload -U compinit
zstyle ":completion:*" menu select
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"

zmodload zsh/complist
compinit -d "$XDG_CACHE_HOME/zcompdump"
_comp_options+=(globdots)

setopt autocd

# Keybindings
bindkey -e
autoload -U select-word-style && select-word-style bash

# Aliases
alias ls="ls --color=auto --group-directories-first -h"
alias ll="ls -l"
alias grep="grep --color=auto -inH"
alias diff="diff --color=auto"

alias v="nvim"
alias hd="hexdump -C"
alias mkd="mkdir -pv"

alias mv="mv -vf"
alias cp="cp -vrf"
alias rm="rm -vrf"

alias g="git"
alias gg="git status -s"
alias gp="git push origin main"
alias gf="git pull origin main"
alias gc="git commit"

function gh() {
    for i in $@; do
        git clone "git@github.com:shoumodip/$i"
    done
}

alias xi="sudo xbps-install"
alias xr="sudo xbps-remove -R"
alias xq="xbps-query"
alias xs="xbps-query -Rs"

alias tc="transmission-remote"
alias tw="watch transmission-remote -l"

# Directory Traversal
function chpwd() {
    ls -A
}

function mkcd() {
    mkdir -p "$1"
    cd "$1"
}
