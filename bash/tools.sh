#!/bin/bash

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac


# make sure cp doesn't silently overwrite stuff.
alias cp='cp -i'

# add home local paths to path
export PATH=$PATH:$HOME/local/bin:$HOME/dotfiles/bin:$HOME/bin:$HOME/.local/bin
export PYTHONPATH=$PYTHONPATH:$HOME/local/lib/python

function grephere() {
    grep --color=always -r "$1" .
}

function grep2less(){
    grep --color=always -r "$1" . | less -R
}


function ff(){
    what=$1
    #echo "got $@ arguments"
    if [ $2 ]; then
	where=$2
    else
	where=""
    fi

    # redirect the stderr to stdout, grep both to exclude 'permission denied'
    # assumes we don't want to find a file that's called "permission denied".
    find $where -iname "$what" 2>&1 | grep -v 'Permission denied'
}

# found at http://stackoverflow.com/a/245724/452140
function up(){
    LIMIT=$1
    if [ -z "$LIMIT" ]; then
        LIMIT=1
    fi
    P=$PWD
    for ((i=1; i <= LIMIT; i++))
    do
        P=$P/..
    done
    cd $P
    echo "you are now here: $PWD"
}

# copies the last command into the clipboard
function cplast(){
    echo -n `fc -nl -1` | tr -d '\n' | xclip -sel clipboard
}

# make subdirectories and
# move into them right away
function mdir(){
    mkdir -p $1
    cd $1
    echo "You are now in $PWD"
}


# delete the current directory and move one upwards
function delthis(){
    allDir=$(dirname "$(pwd)")
    dir=$(basename "$(pwd)")

    while true; do
        read -p "Sure to delete $allDir/$dir? (y/n)" yn
        case $yn in
            [Yy]* ) cd ..; rm -r $dir; break;;
            [Nn]* ) break;;
            * ) echo "Please answer y or n.";;
        esac
    done
    echo "You are now in $PWD"
}

function syslog(){
	less /var/log/syslog
}

alias venv='source venv/bin/activate'

function gitcfg(){
    if [ "$#" -lt "2" ] ; then
        echo "Usage: gitcfg <user> <email>"
        return 1
    fi
    username=$1
    email=$2
    git config user.name "$username"
    git config user.email "$email"
}


# Taken from Holman's dotfiles (https://github.com/holman/dotfiles/)

#!/bin/sh
#
# Usage: extract <file>
# Description: extracts archived files / mounts disk images
# Note: .dmg/hdiutil is macOS-specific.
#
# credit: http://nparikh.org/notes/zshrc.txt
extract () {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)  tar -jxvf $1                        ;;
            *.tar.gz)   tar -zxvf $1                        ;;
            *.bz2)      bunzip2 $1                          ;;
            *.dmg)      hdiutil mount $1                    ;;
            *.gz)       gunzip $1                           ;;
            *.tar)      tar -xvf $1                         ;;
            *.tbz2)     tar -jxvf $1                        ;;
            *.tgz)      tar -zxvf $1                        ;;
            *.zip)      unzip $1                            ;;
            *.ZIP)      unzip $1                            ;;
            *.pax)      cat $1 | pax -r                     ;;
            *.pax.Z)    uncompress $1 --stdout | pax -r     ;;
            *.rar)      unrar x $1                          ;;
            *.Z)        uncompress $1                       ;;
            *)          echo "'$1' cannot be extracted/mounted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}


function gitprune(){
  #https://stackoverflow.com/questions/13064613/how-to-prune-local-tracking-branches-that-do-not-exist-on-remote-anymore
  echo "TODO: so we need to check if they're not merged and then ask the user if he really wants to delete them anyway with -D"
  git fetch --prune
  git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -d
}
