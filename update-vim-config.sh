#!/bin/bash

cd ~
mkdir tmp$$
git clone git@github.com:axin/Vim-config.git tmp$$
rm -Rf tmp$$/.git
cp -R tmp$$/.[^.]* ~
rm -Rf tmp$$

