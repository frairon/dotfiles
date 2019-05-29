#!/bin/bash


HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FOLDERNAME=$(basename "$HERE")

source $HERE/../scripts/common.sh
LINK_FILES="config.cjson config.cson keymap.cson styles.less"

function install(){
	sudo add-apt-repository ppa:webupd8team/atom
	sudo apt-get update
	sudo apt-get install -y atom
}

function savepackages(){
	apm list --installed --bare > $HERE/packages.txt
}

function installpackages(){
	m install --packages-file $HERE/packages.txt
}


# to get a list of all installed packages, do
# apm list -b -i -d | sed -r 's/^([^@]+)@.*$/\1/' > .atom/packages.txt


function setup(){
	echo "$FOLDERNAME: Setting up..."
	mkdir -p $HOME/$FOLDERNAME
	success "Creating folder in $$HOME"
	create_symlinks $HERE $LINK_FILES
}


case "$CMD" in
  install)  install;;
  setup) setup;;
  savepackages) savepackages;;
  installpackages) installpackages;;
  *) echo "Invalid command. Exiting"; exit 1;;
esac
