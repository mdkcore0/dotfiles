# vim: set filetype=sh:

# super grep, will show grep on 'less' if result be greater than the console height
function sgrep(){
    result=$(grep -n --color=always --exclude=\*~ "$@" | sed 's/:/ +/')

    lines=$(echo "${result}" | wc -l)

    if (( $LINES <= $lines + 3 ))
    then
        echo "${result}" | less -R
    else
        echo "${result}"
    fi
}

# super run, will copy to the clipboard a given command as an argument or the last runned command, if no arguments
function srun(){
    if [[ x$@ !=  x ]]
    then
        echo $@ | xclip
    else
        result=$(history | tail -n2 | head -n1 | sed 's/   */_/g' | cut -d'_' -f3-)
        echo $result | xclip
    fi
}

# super cd, will save the last directory that you gone. Passing just xcd will entry on the mentioned dir. Util only with no new data has been sento to the clipboard buffer
function scd(){
    if [ x$@ == x ]
    then
        dir=$(xclip -o)

        if [ -d $dir ]
        then
            cd $dir
        else
            echo "scd: \"$dir\" isn't a valid directory"
        fi
    else
        cd $@
        pwd | xclip
    fi
}

# super pwd, will put the working dir path on the clipboard buffer
function spwd(){
    pwd | xclip
}

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

# definicoes especificas por usuario
if [ "$USER" = mdk ]
then
    # ssh keys (and gpg) on keychain
    eval `keychain --eval --quiet --agents "ssh,gpg" --quick --inherit any succubus_git succubus_ed25519 B805DFBC`

    PATH="$HOME/.bin:/sbin:/usr/sbin:$PATH"

    # XXX add function to enable/disable Android SDK/NDK devel
    PATH="$HOME/projects/android/android-sdk/platform-tools:$HOME/projects/android/android-sdk/tools:$HOME/projects/android/android-ndk:$PATH"
    PATH="$HOME/downloads/GIT/powerline/scripts:$PATH" # powerline
    export POWERLINE_COMMAND=powerline
    export ANDROID_SDK_ROOT="/home/mdk/projects/android/android-sdk"
    export SDK_ROOT="/home/mdk/projects/android/android-sdk"
    export ANDROID_NDK_ROOT="/home/mdk/projects/android/android-ndk"
    export NDK_ROOT="/home/mdk/projects/android/android-ndk"
    export NDK_CCACHE=ccache
    export JAVA_HOME="/usr/lib64/java"
    #

    # TV shows and movies :D
    export TV_SHOWS="/media/KODI/TV_Shows"
    export MOVIES="/media/KODI/Movies"

    # DROPCORE ;)
    export DROPCORE="$HOME/DockZ/DropCore"

    # mplayer things
    alias mplayer='mplayer -ass -ao alsa -channels 6'
    alias mplayer-hdmi='mplayer -ao alsa:device=hw=0.3 -fs -subfont-text-scale 3.5'
fi

. ~/.extras/git-prompt.sh # symbolic link to the git repository completion script

# definicoes globais
stty -ixon

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export GREP_COLOR="03;33"

alias grep='grep -n --color=always --exclude=\*~'
alias less='less -R'

alias ls='ls --color=always'
alias nls='ls -1 | wc -l'
alias tls='ls -ot --color --ignore=\*~ | head | grep -v "total" | tr -s " " | cut -d" " -f5- | column -t'
alias als='ls -la'

alias bkpchrome='rm -rf ~/.config/chromium_BKP/; cp -r ~/.config/chromium{,_BKP}'
alias wget='wget -c'

alias cmake='cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON'
alias vless='/usr/share/vim/vim74/macros/less.sh'
alias make='bear -a make'

# global git exports; really they need to be empty values
export GIT_PS1_SHOWDIRTYSTATE=mdk
export GIT_PS1_SHOWSTASHSTATE=mdk
export GIT_PS1_SHOWUPSTREAM="auto"

export EDITOR="vim"
export GIT_EDITOR=$EDITOR
export SVN_EDITOR=$GIT_EDITOR

export TERM="screen-256color"
#export TERM="xterm-256color"
#export TERM="st-256color"

export PYTHONSTARTUP=$HOME/.pythonrc

if [[ -n "$DISPLAY" && -z "$TMUX" ]];
then
    tmux
fi

eval $(dircolors ~/downloads/GIT/dircolors-solarized/dircolors.256dark)
