#!/bin/bash

set -eu

. ./user-config.dat

readonly MESADIR="/home/$USERNAME/Documents/mesa-dev/mesa"

sudo dnf install -y gcc
sudo dnf install -y gcc-c++

sudo dnf install -y autoconf
sudo dnf install -y libtool
sudo dnf install -y flex
sudo dnf install -y bison
sudo dnf install -y python-mako
sudo dnf install -y xorg-x11-proto-devel
sudo dnf install -y libdrm-devel
sudo dnf install -y libxcb-devel
sudo dnf install -y libxshmfence-devel
sudo dnf install -y xorg-x11-server-devel
sudo dnf install -y systemd-devel
sudo dnf install -y expat-devel

mkdir -p $MESADIR

echo -e '#!/bin/sh\n'"LD_LIBRARY_PATH=$MESADIR/lib LIBGL_DRIVERS_PATH=$MESADIR/lib "'$@\n' > mesadev-dri
echo -e '#!/bin/sh\n'"LD_LIBRARY_PATH=$MESADIR/lib LIBGL_DRIVERS_PATH=$MESADIR/lib/gallium "'$@\n' > mesadev-gallium
chmod u+rwx mesadev-dri
chmod u+rwx mesadev-gallium
sudo mv mesadev-dri /usr/local/bin/mesadev-dri
sudo mv mesadev-gallium /usr/local/bin/mesadev-gallium

git clone https://github.com/chemecse/mesa.git $MESADIR
pushd $MESADIR
git remote add upstream git://anongit.freedesktop.org/git/mesa/mesa
git fetch upstream master
git merge upstream/master
./autogen.sh --prefix=$MESADIR --enable-debug --disable-gallium-llvm --with-dri-drivers= --with-gallium-drivers=swrast --with-egl-platforms=x11,drm
make
popd

