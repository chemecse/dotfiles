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
sudo dnf install -y zlib-devel

# llvm
sudo dnf install -y llvm-devel
sudo dnf install -y redhat-rpm-config

mkdir -p $MESADIR

echo -e '#!/bin/sh\n'"LD_LIBRARY_PATH=$MESADIR/lib LIBGL_DRIVERS_PATH=$MESADIR/lib "'$@\n' > mesadev-dri
echo -e '#!/bin/sh\n'"LD_LIBRARY_PATH=$MESADIR/lib LIBGL_DRIVERS_PATH=$MESADIR/lib/gallium "'$@\n' > mesadev-gallium
chmod u+rwx mesadev-dri
chmod u+rwx mesadev-gallium
sudo mv mesadev-dri /usr/local/bin/mesadev-dri
sudo mv mesadev-gallium /usr/local/bin/mesadev-gallium

echo -e '#!/bin/sh\nDIR="$(cd  "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"\npushd $DIR\n./autogen.sh --prefix=$DIR --enable-debug --disable-gallium-llvm --with-dri-drivers= --with-gallium-drivers=swrast --with-egl-platforms=x11,drm\npopd\n' > $MESADIR/bin/setup-softpipe
echo -e '#!/bin/sh\nDIR="$(cd  "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"\npushd $DIR\n./autogen.sh --prefix=$DIR --enable-debug --enable-gallium-llvm --with-dri-drivers= --with-gallium-drivers=swrast --with-egl-platforms=x11,drm\npopd\n' > $MESADIR/bin/setup-llvmpipe
echo -e '#!/bin/sh\nDIR="$(cd  "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"\npushd $DIR\n./autogen.sh --prefix=$DIR --enable-debug --with-dri-drivers=i965 --with-gallium-drivers= --with-egl-platforms=x11,drm\npopd\n' > $MESADIR/bin/setup-i965

chmod u+x $MESADIR/bin/setup-softpipe
chmod u+x $MESADIR/bin/setup-llvmpipe
chmod u+x $MESADIR/bin/setup-i965

echo "bin/setup-softpipe" >> $MESADIR/.git/info/exclude
echo "bin/setup-llvmpipe" >> $MESADIR/.git/info/exclude
echo "bin/setup-i965" >> $MESADIR/.git/info/exclude

git clone https://github.com/chemecse/mesa.git $MESADIR
pushd $MESADIR
git remote add upstream git://anongit.freedesktop.org/git/mesa/mesa
git fetch upstream master
git merge upstream/master
./bin/setup-softpipe
make
popd

