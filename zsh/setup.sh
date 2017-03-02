#!/bin/bash

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FOLDERNAME=$(basename "$HERE")

source $HERE/../scripts/common.sh

function setup(){
	echo "$FOLDERNAME: Setting linking config-files"

  link_file "$HERE/.zshrc" "$HOME/.zshrc"
}

function install(){
	echo "Installing oh-my-zsh. You may enter your password to set zsh as default shell"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}


case "$CMD" in
  install)  install;;
  setup) setup;;
  *) echo "Invalid command. Exiting"; exit 1;;
esac
