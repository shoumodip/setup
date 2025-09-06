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

# Navigation with Fm
fmcd() {
    if ! type fm >/dev/null; then
        echo "Error: fm is not installed. Download it from https://github.com/shoumodip/fm"
        return 1
    fi

    cd $(fm -l)
}

bindkey -s "^o" "^ufmcd\\n"

# Aliases
alias v="$EDITOR"
alias t="tmux"
alias mv="mv -fv"
alias cp="cp -fvr"
alias rm="rm -fvr"
alias ls="ls -v --color=auto --group-directories-first"
alias ll="ls -lh"
alias diff="diff --color=auto"
alias grep="grep --color=auto"
alias tree="tree -C"

# Environment
export GOPATH="$HOME/.local/share/go"
export JAVA_HOME="/usr/lib/jvm/java-21-openjdk-amd64"
export CARGO_HOME="$HOME/.local/share/cargo"
export ANDROID_HOME="$HOME/Software/android-sdk"

# Highlighting
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

ZSH_HIGHLIGHT_STYLES[comment]='fg=#928374'
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#928374'
