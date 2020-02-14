


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

# install docker
# sudo apt-get install docker.io
# usermod -aG docker franz


MEDIA=/media/julie

backup-master-gabi:
	test -d ${MEDIA}/Gabi-Franz && rsync ${HOME}/MASTER/ -a --info=progress2 --exclude="lost+found" --delete ${MEDIA}/Gabi-Franz
backup-bilder-gabi:
	test -d ${MEDIA}/Siggi-Bilder && test -d ${MEDIA}/Gabi-Bilder && rsync ${MEDIA}/Siggi-Bilder/ -a --info=progress2 --exclude=".Trash-*" --exclude="lost+found" --delete ${MEDIA}/Gabi-Bilder
backup-bilder-backup:
	test -d ${MEDIA}/Siggi-Bilder && test -d "${MEDIA}/Backup Bilder" && rsync ${MEDIA}/Siggi-Bilder/ -a --info=progress2 --exclude=".Trash-*" --exclude="lost+found" --delete "${MEDIA}/Backup Bilder"
backup-bilder:
	test -d ${MEDIA}/Siggi-Bilder && test -d "${MEDIA}/Bilder" && rsync ${MEDIA}/Siggi-Bilder/ -a --info=progress2 --exclude=".Trash-*" --exclude="lost+found" --delete "${MEDIA}/Bilder"
backup-master-backup:
	test -d "${MEDIA}/Backup Franz" && rsync ${HOME}/MASTER/ -a --info=progress2 --exclude="lost+found" --delete "${MEDIA}/Backup Franz/MASTER"
backup-master-hannelore:
	test -d ${MEDIA}/Hannelore && rsync ${HOME}/MASTER/ -a --info=progress2 --delete --exclude="lost+found" ${MEDIA}/Hannelore/MASTER
