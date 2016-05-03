#!/bin/sh

set -eu

USERNAME="chemecse"
NAME="Lars Hamre"
EMAIL="chemecse@gmail.com"


### vim setup

sudo dnf install -y vim
vim -c "VundleInstall" -c "qa"

### gcc setup

sudo dnf install -y gcc
sudo dnf install -y gcc-c++

### git setup

sudo dnf install -y git
sudo dnf install -y git-email

git config --global user.email $EMAIL
git config --global user.name "$NAME"
git config --global core.editor vim
git config --global sendemail.smtpserver smtp.gmail.com
git config --global sendemail.smtpserverport 587
git config --global sendemail.smtpencryption tls
git config --global sendemail.smtpuser $EMAIL

### mesa development setup

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

MESADIR="/home/$USERNAME/Documents/mesa-dev/mesa"
mkdir -p $MESADIR
git clone git://anongit.freedesktop.org/git/mesa/mesa $MESADIR
pushd $MESADIR
./autogen.sh --prefix=$MESADIR --enable-debug --with-dri-drivers=swrast --with-gallium-drivers= --with-egl-platforms=x11,drm
make
popd

echo -e "set expandtab\nset tabstop=3\nset softtabstop=3\nset shiftwidth=3\n" > $MESADIR/../.lvimrc

echo -e '#!/bin/sh\n'"LD_LIBRARY_PATH=$MESADIR/lib LIBGL_DRIVERS_PATH=$MESADIR/lib "'$@\n' > mesadev
chmod u+rwx mesadev
sudo mv mesadev /usr/bin/mesadev

### piglit development setup

sudo dnf install -y cmake
sudo dnf install -y waffle-devel
sudo dnf install -y python3-numpy
sudo dnf install -y mesa-libEGL-devel
sudo dnf install -y mesa-libGLU-devel

PIGLITDIR="/home/$USERNAME/Documents/piglit-dev/piglit"
mkdir -p $PIGLITDIR
git clone git://anongit.freedesktop.org/git/piglit $PIGLITDIR
pushd $PIGLITDIR
cmake .
make
popd

echo -e "set noexpandtab\nset tabstop=8\nset softtabstop=8\nset shiftwidth=8\n" > $PIGLITDIR/../.lvimrc

