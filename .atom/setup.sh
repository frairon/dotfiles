
HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FOLDERNAME=$(basename "$HERE")

source $HERE/../scripts/common.sh
LINK_FILES="config.cjson config.cson keymap.cson styles.less"

function install(){
	sudo add-apt-repository ppa:webupd8team/atom
	sudo apt-get update
	sudo apt-get install atom -y
}


function setup(){
	echo "$FOLDERNAME: Setting up..."
	mkdir -p $HOME/$FOLDERNAME

	create_symlinks $HERE $LINK_FILES

}


case "$CMD" in
  install)  install;;
  setup) setup;;
  *) echo "Invalid command. Exiting"; exit 1;;
esac
