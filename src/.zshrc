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

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# Aliases
alias v="nvim"
alias t="tmux"
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

function allwebp2png() {
    if ! type magick >/dev/null; then
        echo "Error: ImageMagick is not installed"
        return 1
    fi

    for f in *.webp; do
        echo "Converting $f..."
        magick $f $(basename $f .webp).png
    done

    rm *.webp
    echo "DONE!"
}

# Environment
export EDITOR="$(which nvim)"
export GOPATH="$HOME/.local/share/go"
export CARGO_HOME="$HOME/.local/share/cargo"

# Highlighting
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

ZSH_HIGHLIGHT_STYLES[comment]='fg=#928374'
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#928374'
