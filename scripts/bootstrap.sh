#!/bin/bash

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$HERE/common.sh"

ROOT_UID=0   # Root has $UID 0.
HERE=$(pwd -P)

if [ "$UID" -eq "$ROOT_UID" ]
then
  echo "You must not run this as root, otherwise the user customizations\
  will not work. Installation commands etc. simply use sudo."
  exit 1
fi

all(){
  remove_services
  install_system_tools
  install_user_tools
  setup_dropbox
  setup_dev_tools
  ui_customizations
  remove_unity
}

remove_services(){
  echo "Removing unnecessary services"
  sleep 1
  sudo apt-get purge --yes rhythmbox evolution
}

remove_unity(){
   sudo apt-get install gnome-session-flashback
}

install_system_tools(){
  echo "Installing system tools"
  sleep 1
  sudo apt-get install --yes encfs gdebi htop ubuntu-restricted-extras python-pip gnome-tweak-tool

  echo "Installing tools via Pip"
  sudo pip install gkeyring

  echo "installing nemo filemanager"
  sudo apt-get install nemo nemo-fileroller

}

setup_zsh(){
  echo "installing zsh"
  sudo apt-get install --yes zsh
}

install_user_tools(){
  echo "Installing user tools....."
  sleep 1
  sudo apt-get install --yes chromium-browser kate emacs keepassx pepperflashplugin-nonfree zim vlc unison clementine

  echo "Sourcing our own bash-script in .bashrc"
  local ALIAS="source $HOME/dotfiles/bash/tools.sh"
  grep -q -F "$ALIAS" ~/.bashrc || echo $ALIAS >> ~/.bashrc
}

setup_dropbox(){
  echo "... Setting up DropboxPrivate"

  # check if the dropbox-entry exists in keyring, if not, add it.
  # save its ID to the tmp file anyway
  gkeyring -n "db" -o "id" > /tmp/_bootstrap_keyId || \
      gkeyring -n "db" --set > /tmp/_bootstrap_keyId

  local KEY_ID=`cat /tmp/_bootstrap_keyId`
  echo "Key ID is $KEY_ID"
  rm /tmp/_bootstrap_keyId

  DROPBOX_PRIVATE_SRC=~/Dropbox/Private
  DROPBOX_PRIVATE_DIR=~/DropboxPrivate
  echo "Creating DropboxPrivate dir"
  mkdir -p $DROPBOX_PRIVATE_DIR


  RUN_FILE=~/.config/autostart/dropbox_private.desktop
  MOUNT_SCRIPT=~/.mount_dropboxprivate.sh
  echo "Adding mount_script to startup applications"
  echo "#!/bin/bash

gkeyring --id=$KEY_ID -o secret | encfs --stdinpass $DROPBOX_PRIVATE_SRC $DROPBOX_PRIVATE_DIR

    " > $MOUNT_SCRIPT
    chmod +x $MOUNT_SCRIPT
    echo "[Desktop Entry]
Name=DropboxPrivate
GenericName=DropboxPrivate
Comment=Mount encrypted folder in dropbox to local folder.
Exec=$MOUNT_SCRIPT
Terminal=false
Type=Application
Icon=
Categories=Network;FileTransfer;
StartupNotify=false
" > $RUN_FILE

}

setup_dev_tools(){
  echo "Setting up development tools..."
  sleep 0.5
  sudo apt-get install --yes python-pip git-core fabric
}

ui_customizations(){
 echo "UI-Buttons to right side"
 gsettings set org.gnome.desktop.wm.preferences button-layout 'menu:minimize,maximize,close'
 echo "Fixing Scroll bars"
 gsettings set com.canonical.desktop.interface scrollbar-mode normal

 echo "create link of eigene_dateien"
 if [ ! -a ~/eigene_dateien ]
 then
 ln -s ~/MASTER/eigene_dateien ~/eigene_dateien
 fi

 echo "setting nautilus defaults"
 gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'
 gsettings set org.gnome.nautilus.list-view default-zoom-level 'smallest'
 gsettings set org.gnome.nautilus.list-view use-tree-view 'true'

 echo "setting nemo defaults"
 gsettings set org.nemo.preferences default-folder-viewer 'list-view'
 gsettings set org.nemo.list-view default-zoom-level 'smallest'


 echo "disabling sounds"
 gsettings set org.gnome.desktop.sound event-sounds 'false'

}
