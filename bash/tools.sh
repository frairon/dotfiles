#!/bin/bash

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac


# make sure cp doesn't silently overwrite stuff.
alias cp='cp -i'

# add home local paths to path
export PATH=$PATH:$HOME/local/bin
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
    allDir=$(dirname $(pwd))
    dir=$(basename $(pwd))

    while true; do
        read -p "Sure to delete $allDir/$dir? (y/n)" yn
        case $yn in
            [Yy]* ) cd ..; rm -r $dir; break;;
            [Nn]* ) break;;
            * ) echo "Please answer yes or no.";;
        esac
    done
    echo "You are now in $PWD"
}

function syslog(){
	less /var/log/syslog
}

alias venv='source venv/bin/activate'


source ~/workbash
source ~/MASTER/system/scripts/bash

PATH=$PATH:$HOME/bin


alias mdv='/home/franz/tools/terminal_markdown_viewer/mdv.py'


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
