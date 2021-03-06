#!/bin/bash

# This script contains common functions for setting up the dot files.

ROOT_UID=0   # Root has $UID 0.

if [ "$UID" -eq "$ROOT_UID" ]
then
  echo "You must not run this as root, otherwise the user customizations\
  will not work. Installation commands etc. simply use sudo."
  exit 1
fi

# Print passed argument with
success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

function link_file () {

  local src=$1 dst=$2

  local overwrite='' backup='' skip=''
  local action=''

  if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
  then

    local currentSrc="$(readlink $dst)"

    if [ "$currentSrc" == "$src" ]
    then

      skip=true;

    else

      echo "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
      [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
      read -n 1 action

      case "$action" in
        o )
          overwrite=true;;
        O )
          overwrite_all=true;;
        b )
          backup=true;;
        B )
          backup_all=true;;
        s )
          skip=true;;
        S )
          skip_all=true;;
        * )
          ;;
      esac

    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]
    then
      rm -rf "$dst"
      success "removed $dst"
    fi

    if [ "$backup" == "true" ]
    then
      mv "$dst" "${dst}.backup"
      success "moved $dst to ${dst}.backup"
    fi

    if [ "$skip" == "true" ]
    then
      success "skipped $src"
    fi
  fi

  if [ "$skip" != "true" ]  # "false" or empty
  then
    ln -s "$1" "$2"
    success "linked $1 to $2"
  fi
}


function create_symlinks(){
	local here=$1
	local foldername=$(basename "$here")
	echo "Create symlinks from *.symlink $here"
	for src in $(find -H "$here" -maxdepth 1 -name '*.symlink')
	do
		dst="$HOME/$foldername/$(basename "${src%.*}")"
		link_file "$src" "$dst"
	done

	# get rid of the folder
	shift 1

	until [ -z "$1" ]
    do
		local src=$1
		dst="$HOME/$foldername/$src"
		link_file "$here/$src" "$dst"
		shift 1
	done
}


function check_append_to_file(){
  local file=$1
  local text=$2
  echo "Appending $2 to $1 (if not already present)"
  grep -q -F "$text" $file || echo $text >> $file
}
