case $- in
  *i*) ;;
  *) return;;
esac

shopt -s histappend
shopt -s checkwinsize

alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias diff="diff --color=auto"

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

PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
BASE_PATH="$PATH"
BASE_HOME="$HOME/Software"

export PATH="$(ls "$BASE_HOME" | sed "s|.*|$BASE_HOME/&/bin|" | tr '\n' ':')$BASE_PATH"
export EDITOR="$(which nvim)"
export GOPATH="$HOME/.local/share/go"
