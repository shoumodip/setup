case $- in
  *i*) ;;
  *) return;;
esac

shopt -s histappend
shopt -s checkwinsize

alias v="nvim"
alias mv="mv -fv"
alias cp="cp -fvr"
alias rm="rm -fvr"
alias ls="ls -v --color=auto --group-directories-first"
alias ll="ls -l"
alias diff="diff --color=auto"
alias grep="grep --color=auto"

HISTSIZE=1000
HISTCONTROL=ignoreboth
HISTFILESIZE=2000

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

PS1="\[\033[01;34m\]\w\[\033[00m\]: "
BASE="$HOME/Software"

export PATH="$(ls "$BASE" | sed "s|.*|$BASE/&/bin|" | tr '\n' ':')$BASE:$PATH"
export EDITOR="$(which nvim)"
export GOPATH="$HOME/.local/share/go"
export CPRPATH="$HOME/Software"

fmcd() {
    path="$(mktemp -uq)"
    fm -last-path "$path" "$@"

    if [ -f "$path" ]; then
      last="$(cat "$path")"
      [ -d "$last" ] && cd "$last"
      rm "$path"
    fi
}

bind '"\C-o":"\C-k \C-ufmcd\n"'

export ANDROID_HOME="$HOME/.Android"
export GRADLE_HOME="$BASE/gradle"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
