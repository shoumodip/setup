# Prompt
PS1='%B%F{blue}%~%f%b %(?..%F{red}[%B%?%b]%f )$ '

# General
setopt autocd
setopt extended_glob
setopt interactive_comments

# History
setopt inc_append_history
setopt hist_ignore_all_dups

HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="$HOME/.cache/zsh_history"

# Autocomplete
autoload -U compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' sort true
zmodload zsh/complist

# Keybindings
bindkey -e
autoload -U select-word-style && select-word-style bash

# Aliases
alias v="nvim"
alias mv="mv -fv"
alias cp="cp -fvr"
alias rm="rm -fvr"
alias ls="ls -v --color=auto --group-directories-first"
alias ll="ls -l"
alias diff="diff --color=auto"
alias grep="grep --color=auto"
alias tree="tree -C"

alias xi="sudo xbps-install"
alias xr="sudo xbps-remove -R"
alias xq="xbps-query -Rs"

alias feh="feh -B black"
alias wallpaper="feh --bg-scale"

# Environment
export PATH="$(find -L "$HOME/Software" -maxdepth 1 -type d | sed '2,$s|$|/bin|' | tr '\n' ':')$PATH"
export EDITOR="$(which nvim)"
export GOPATH="$HOME/.local/share/go"
export CPRPATH="$HOME/Software"
export CARGO_HOME="$HOME/.local/share/cargo"

if type cpr >/dev/null; then
    export LD_LIBRARY_PATH="$(cpr libs bs raylib | sed 's/^-L//;s/ -L/\n/g' | tr '\n' ':')$LD_LIBRARY_PATH"
fi

# Highlighting
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

ZSH_HIGHLIGHT_STYLES[comment]='fg=#928374'
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#928374'
