if status is-interactive
    set fish_greeting
    set BASE "$HOME/Software"
    set -x PATH (find -L "$BASE" -maxdepth 1 -type d | sed '2,$s|$|/bin|') $PATH
    set -x EDITOR (which nvim)
    set -x GOPATH "$HOME/.local/share/go"
    set -x CPRPATH "$HOME/Software"

    set -x ANDROID_HOME "$HOME/.Android"
    set -x GRADLE_HOME "$BASE/gradle"
    set -x PATH "$ANDROID_HOME/cmdline-tools/latest/bin" $PATH

    if type -q cpr
        set -x LD_LIBRARY_PATH (cpr libs bs raylib | sed 's/^-L//;s/ -L/\n/g') $LD_LIBRARY_PATH
    end

    alias v "nvim"
    alias mv "mv -fv"
    alias cp "cp -fvr"
    alias rm "rm -fvr"
    alias ls "ls -v --color=auto --group-directories-first"
    alias ll "ls -l"
    alias diff "diff --color=auto"
    alias grep "grep --color=auto"
    alias tree "tree -C"
end
