# vim: set filetype=sh:

# recursively remove temp (backup) files
function erase_bkp(){
    recursive=0

    while [ $# -gt 0 ]
    do
        case $1 in
            -r)
                recursive=1
                shift 1
                ;;
            *)
                echo "Invalid argument $1"
                shift 1
                ;;
        esac
    done

    if [[ $recursive = 1 ]]
    then
        find . -iname \*~ | xargs rm
    else
        find . -iname \*~ -maxdepth 1 | xargs rm
    fi
}

# git please <REMOTE>
_git_please() {
    __git_remotes
}

export PINENTRY_USER_DATA="USE_CURSES=1"

# global definitions
stty -ixon

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

alias grep='grep -n --color=auto --exclude=\*~'
alias less='less -R'
alias ip='ip --color=auto'

# alias ls='ls --color=auto'
alias nls='ls -1 | wc -l'
# alias tls='ls -ot --color --ignore=\*~ | head | grep -v "total" | tr -s " " | cut -d" " -f5- | column -t'
alias tls='ls --color=always -lr --sort=new | head'
alias als='ls -la'

alias wget='wget -c'

alias cmake='cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON'
#alias make='bear -a make'

alias diff='diff --color=auto'

# simple bell, usefull when waiting the completion of something on another
# tmux window ;)
alias bell='echo -n "\007"' # or 'tput bel'

# use modern tools
alias ls=exa
alias cat='bat --theme=base16-256 --color=always --style=numbers --italic-text=always --pager "less -RF"'
alias cd=z # zoxide

export EDITOR="nvim"
export GIT_EDITOR=$EDITOR

export PYTHONSTARTUP=$HOME/.pythonrc

if [[ -n "$DISPLAY" && -z "$TMUX" ]];
then
    tmux
fi

# my own completions
#source $HOME/.completions/*

# pass
export PASSWORD_STORE_DIR=$HOME/QTRNN/password-store
export PASSWORD_STORE_GIT=$PASSWORD_STORE_DIR

# use clang as c/c++ compiler as default
#export CC=clang
#export CXX=clang++

export LESS="-M -R"
export BAT_THEME="base16-256"

export PODMAN_USERNS="keep-id"
alias podman-compose="unset PODMAN_USERNS; podman-compose"

# from https://git.sr.ht/~sircmpwn/dotfiles/tree/master/item/.profile:
export GOPATH=~/.local/share/go
export GOPROXY=direct
export GOSUMDB=off
export GOTELEMETRY=off

# PATHs definition
PATH="$HOME/.local/bin:$GOPATH/bin:$PATH"
