#!/bin/bash

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FOLDERNAME=$(basename "$HERE")

source $HERE/../scripts/common.sh

function setup(){
	echo "$FOLDERNAME: Setting up..."

  for file in $HERE/*; do
    [[ $(basename $file) =~ setup.sh ]] && continue
    echo "Sourcing $file in bash"
    check_append_to_file "$HOME/.bashrc" "source $file"
  done
} 


case "$CMD" in
  setup) setup;;
  *) echo "Invalid command. Exiting"; exit 1;;
esac
