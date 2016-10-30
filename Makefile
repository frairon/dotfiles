


install: export CMD = install
install:c
	.atom/setup.sh

setup: export CMD = setup
setup:
	-.atom/setup.sh
	-bash/setup.sh
	-dropbox/setup.sh
	-golang/setup.sh


install-system-basics:
	sudo apt-get install encfs gdebi htop ubuntu-restricted-extras gnome-tweak-tool nemo nemo-fileroller
	sudo apt-get install zsh

install-user-basics:
	sudo apt-get install --yes chromium-browser kate keepassx pepperflashplugin-nonfree zim vlc unison clementine


install-dev-packages:
	sudo apt-get install --yes python-pip git-core fabric zeal
	sudo pip install gkeyring

remove-packages:
	sudo apt-get install gnome-session-flashback
	sudo apt-get purge --yes rhythmbox evolution


install: install-syste-basics install-user-basics install-python-packages


ui-customizations:
	echo "UI-Buttons to right side"
	gsettings set org.gnome.desktop.wm.preferences button-layout 'menu:minimize,maximize,close'
	echo "Fixing Scroll bars"
	gsettings set com.canonical.desktop.interface scrollbar-mode normal

	echo "setting nautilus defaults"
	gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'
	gsettings set org.gnome.nautilus.list-view default-zoom-level 'smallest'
	gsettings set org.gnome.nautilus.list-view use-tree-view 'true'

	echo "setting nemo defaults"
	gsettings set org.nemo.preferences default-folder-viewer 'list-view'
	gsettings set org.nemo.list-view default-zoom-level 'smallest'


	echo "disabling sounds"
	gsettings set org.gnome.desktop.sound event-sounds 'false'
