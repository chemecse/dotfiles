#!/bin/sh

set -eu

sudo dnf install -y tmux

sudo dnf install -y gcc
sudo dnf install -y gcc-c++
sudo dnf install -y gdb
sudo dnf install -y strace
sudo dnf install -y cloc
sudo dnf install -y cppcheck

sudo dnf install -y kernel-devel
sudo dnf install -y libX11-devel
sudo dnf install -y mesa-libGL-devel
sudo dnf install -y gl-manpages

