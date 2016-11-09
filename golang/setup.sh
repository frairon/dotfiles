#!/bin/bash

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FOLDERNAME=$(basename "$HERE")

source $HERE/../scripts/common.sh

function setup(){
	echo "$FOLDERNAME: Setting up..."
	for file in $HERE/bash.sh; do
    echo "Sourcing $file in bash"
    check_append_to_file "$HOME/.bashrc" "source $file"
  done

	for file in $HERE/bashprofile.sh; do
    echo "Sourcing $file in .profile"
    check_append_to_file "$HOME/.profile" "source $file"
  done

	mkdir -p $HOME/golang
	mkdir -p $HOME/golang-extras
	success "Create golang default folders"

}


case "$CMD" in
  setup) setup;;
  *) echo "Invalid command. Exiting"; exit 1;;
esac
