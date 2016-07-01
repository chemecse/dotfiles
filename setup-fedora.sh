#!/bin/sh

set -eu

# setup-fedora
#
# This script automates the setup of a development environment
# running Fedora Workstation.
#
# The development environment includes (but is not limited to):
# - linux kernel
# - mesa
# - piglit
#

### notes

# enable a text login
# $ systemctl set-default multi-user.target

# enable a graphical login
# $ systemctl set-default graphical.target


readonly USERNAME="chemecse"
readonly NAME="Lars Hamre"
readonly EMAIL="chemecse@gmail.com"

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

### setup dotfiles

pushd /home/$USERNAME

git clone https://github.com/chemecse/dotfiles.git

cp ~/dotfiles/.inputrc             ~/.inputrc
cp ~/dotfiles/.gitconfig           ~/.gitconfig
cp ~/dotfiles/.git-completion.bash ~/.git-completion.bash
cp ~/dotfiles/.bashrc              ~/.bashrc
cp ~/dotfiles/.vimrc               ~/.vimrc

popd

### vim setup

sudo dnf install -y vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim -c "VundleInstall" -c "qa"

### gcc setup

sudo dnf install -y gcc
sudo dnf install -y gcc-c++

### mutt setup

sudo dnf install -y mutt

readonly EMAIL_USERNAME="chemecse"
readonly MUTTDIR="/home/$USERNAME/.mutt"
readonly MUTTRC="/home/$USERNAME/.muttrc"

mkdir -p $MUTTDIR/cache

echo "" >  $MUTTRC
echo "set from = \"$EMAIL\"" >> $MUTTRC
echo "set realname = \"$NAME\"" >> $MUTTRC
echo "set header_cache = \"$MUTTDIR/cache/headers\"" >> $MUTTRC
echo "set message_cachedir = \"$MUTTDIR/cache/bodies\"" >> $MUTTRC
echo "set certificate_file = \"$MUTTDIR/certificates\"" >> $MUTTRC
echo "set smtp_url = \"smtp://$EMAIL_USERNAME@smtp.gmail.com:587/\"" >> $MUTTRC
echo "set move = no" >> $MUTTRC

# how to send email via a script
# 1) set smtp_pass in .muttrc
#    $ echo "set smtp_pass = \"your_password_here\"" >> $MUTTRC
# 2) sample script
#    to="hello@world.org"
#    subject="hello, world"
#    body="there are attachments"
#    echo $body | mutt -s "$subject" $to -a attachment.txt

### kernel development setup

sudo dnf install -y kernel-devel
sudo dnf install -y sysklogd

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

readonly MESADIR="/home/$USERNAME/Documents/mesa-dev/mesa"
mkdir -p $MESADIR
git clone git://anongit.freedesktop.org/git/mesa/mesa $MESADIR
pushd $MESADIR
./autogen.sh --prefix=$MESADIR --enable-debug --disable-gallium-llvm --with-dri-drivers=swrast --with-gallium-drivers=swrast --with-egl-platforms=x11,drm
make
popd

echo -e "set expandtab\nset tabstop=3\nset softtabstop=3\nset shiftwidth=3\n" > $MESADIR/../.lvimrc

echo -e '#!/bin/sh\n'"LD_LIBRARY_PATH=$MESADIR/lib LIBGL_DRIVERS_PATH=$MESADIR/lib "'$@\n' > mesadev-dri
echo -e '#!/bin/sh\n'"LD_LIBRARY_PATH=$MESADIR/lib LIBGL_DRIVERS_PATH=$MESADIR/lib/gallium "'$@\n' > mesadev-gallium
chmod u+rwx mesadev-dri
chmod u+rwx mesadev-gallium
sudo mv mesadev-dri /usr/local/bin/mesadev-dri
sudo mv mesadev-gallium /usr/local/bin/mesadev-gallium

### piglit development setup

sudo dnf install -y cmake
sudo dnf install -y waffle-devel
sudo dnf install -y python3-numpy
sudo dnf install -y mesa-libEGL-devel
sudo dnf install -y mesa-libGLU-devel

readonly PIGLITDIR="/home/$USERNAME/Documents/piglit-dev/piglit"
mkdir -p $PIGLITDIR
git clone git://anongit.freedesktop.org/git/piglit $PIGLITDIR
pushd $PIGLITDIR
cmake .
make
popd

echo -e "set noexpandtab\nset tabstop=8\nset softtabstop=8\nset shiftwidth=8\n" > $PIGLITDIR/../.lvimrc

