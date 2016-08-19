#!/bin/bash

set -eu

. ./user-config.dat

readonly PIGLITDIR="/home/$USERNAME/Documents/piglit-dev/piglit"

sudo dnf install -y cmake
sudo dnf install -y waffle-devel
sudo dnf install -y python3-numpy
sudo dnf install -y mesa-libEGL-devel
sudo dnf install -y mesa-libGLU-devel

mkdir -p $PIGLITDIR

echo -e "set noexpandtab\nset tabstop=8\nset softtabstop=8\nset shiftwidth=8\n" > $PIGLITDIR/../.lvimrc

git clone https://github.com/chemecse/piglit.git $PIGLITDIR
pushd $PIGLITDIR
git remote add upstream git://anongit.freedesktop.org/git/piglit
git fetch upstream master
git merge upstream/master
cmake .
make
popd

