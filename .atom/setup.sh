
HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FOLDERNAME=$(basename "$HERE")

source $HERE/../scripts/common.sh
LINK_FILES="config.cjson config.cson keymap.cson styles.less"

function install(){
	sudo add-apt-repository ppa:webupd8team/atom
	sudo apt-get update
	sudo apt-get install -y atom
}


function setup(){
	echo "$FOLDERNAME: Setting up..."
	mkdir -p $HOME/$FOLDERNAME
	success "Creating folder in $$HOME"
	create_symlinks $HERE $LINK_FILES

	# install packages
	apm install --packages-file $HERE/packages.txt

}


case "$CMD" in
  install)  install;;
  setup) setup;;
  *) echo "Invalid command. Exiting"; exit 1;;
esac
