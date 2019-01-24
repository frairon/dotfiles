


install: export CMD = install
install:
	.atom/setup.sh

setup: export CMD = setup
setup:
	-bash .atom/setup.sh
	-bash bash/setup.sh
	-bash dropbox/setup.sh
	#-golang/setup.sh


install-system-basics:
	sudo apt-get install encfs gdebi htop ubuntu-restricted-extras curl

install-user-basics:
	sudo apt-get install --yes chromium-browser keepassx zim vlc unison clementine chromium-codecs-ffmpeg-extra
	sudo apt-get install terminator python-pip
	
install-keyring:
	sudo add-apt-repository ppa:atareao/atareao 
	sudo apt-get update
	sudo apt-get install gkeyring
	$(info "The hamster-file is in .local/share/hamster-applet/. Link the database from dropbox or whatever")
	
install-hub:
	sudo add-apt-repository ppa:cpick/hub
	sudo apt-get update
	sudo apt-get install hub

# install slack
# https://slack.com/intl/de-de/downloads/instructions/ubuntu

# install spotify
# https://www.spotify.com/de/download/linux/

# thunderbird
# carddav
# install cardbook
# instructions here
# https://posteo.de/en/help/how-do-I-synchronise-my-posteo-address-book-with-other-programs-or-devices
