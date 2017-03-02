#!/bin/bash

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FOLDERNAME=$(basename "$HERE")

source $HERE/../scripts/common.sh

function setup(){
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


  RUN_FILE=$HOME/.config/autostart/dropbox_private.desktop
  MOUNT_SCRIPT=$HOME/.mount_dropboxprivate.sh
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

case "$CMD" in
  setup) setup;;
  *) echo "Invalid command. Exiting"; exit 1;;
esac
