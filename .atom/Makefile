source := ${CURDIR}/../scripts/common.sh
LINK_FILES := config.cjson config.cson keymap.cson styles.less

install:
	sudo add-apt-repository ppa:webupd8team/atom
	sudo apt-get update
	sudo apt-get install -y atom

savepackages:
	# apm list -b -i -d | sed -r 's/^([^@]+)@.*$/\1/' > .atom/packages.txt
	apm list -b -i -d | sed -r 's/^([^@]+)@.*$$/\1/' > ${CURDIR}/packages.txt

installpackages:
	apm install --packages-file ${CURDIR}/packages.txt


setup:
	echo ".atom: Setting up..."
	mkdir -p $HOME/.atom
	success "Creating folder in $$HOME"
	create_symlinks ${CURDIR} $LINK_FILES

	sudo apt-get install shellcheck
	# install packages
	apm install --packages-file ${CURDIR}/packages.txt
