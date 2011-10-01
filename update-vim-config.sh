#!/bin/bash

# Parameters:
# -d - download config from the repository.
# -u - upload config to the repository.

configRepository="git@github.com:axin/Vim-config.git"
backupFolder="oldvimconfig"

case "$1" in
-d)
    # Backup old config to backupFolder
    cd ~
    if [ -d "$backupFolder" ]
    then
        rm -Rf "$backupFolder"
    fi
    mkdir "$backupFolder"
    if [ -f ".vimrc" ]
    then
        cp .vimrc "$backupFolder"
    fi
    if [ -f ".gvimrc" ]
    then
        cp .vimrc "$backupFolder"
    fi
    if [ -d ".vim" ]
    then
        cp -R .vim "$backupFolder"
    fi

    # Install config
    mkdir "tmp$$"
    git clone "$configRepository" "tmp$$"
    rm -Rf "tmp$$/.git"
    cp -R tmp$$/.[^.]* ~
    rm -Rf "tmp$$"
    ;;

-u)
    echo "update"
    ;;

*)
    echo "Invalid parameter!"
    exit 1
    ;;
esac

#cd ~
#mkdir tmp$$
#git clone git@github.com:axin/Vim-config.git tmp$$
#rm -Rf tmp$$/.git
#cp -R tmp$$/.[^.]* ~
#rm -Rf tmp$$

