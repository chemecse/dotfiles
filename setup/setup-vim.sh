#!/bin/sh

set -eu

sudo dnf install -y vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim -c "VundleInstall" -c "qa"

