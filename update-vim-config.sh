#!/bin/bash

# Parameters:
# -d - download config from the repository.
# -u - upload config to the repository.

configRepository="git@github.com:axin/Vim-Config.git"
backupFolder="oldvimconfig"

cd ~

case "$1" in
-d)
    # Backup old config to backupFolder
    if [ -d "$backupFolder" ]; then
        rm -Rf "$backupFolder"
    fi
    mkdir "$backupFolder"
    if [ -f ".vimrc" ]; then
        cp .vimrc "$backupFolder"
    fi
    if [ -f ".gvimrc" ]; then
        cp .vimrc "$backupFolder"
    fi
    if [ -d ".vim" ]; then
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
    mkdir "tmp$$"

    git clone "$configRepository" "tmp$$"

    cd "tmp$$"
    git rm -r .
    if [ -f "../.vimrc" ]; then
        cp ~/.vimrc .
        git add .vimrc
    fi
    if [ -f "../.gvimrc" ]; then
        cp ~/.gvimrc .
        git add .gvimrc
    fi
    if [ -d "../.vim" ]; then
        cp -R ~/.vim .
        git add .vim
    fi
    git commit -m "$(date '+%d.%m.%Y %T')"
    git push
    cd ..

    rm -Rf "tmp$$"
    ;;

*)
    echo "Invalid parameter!"
    exit 1
    ;;
esac

