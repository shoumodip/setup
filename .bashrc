PS1="\[\e[01;34m\]\w\[\e[0m\] "

alias g="git"
alias v="nvim"
alias ls="ls -v --color=auto --group-directories-first"
alias ll="ls -Al"
alias mv="mv -fv"
alias rm="rm -fvr"
alias cp="cp -fvr"
alias mkd="mkdir -p"
alias grep="grep -inH --color=auto"

HISTSIZE=1000
HISTCONTROL=ignoreboth

shopt -s histappend

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

for dir in ~/opt/*/; do
  if [ -d "${dir}bin" ]; then
    PATH="$PATH:${dir}bin"
  fi
done
