#!/bin/sh

set -eu

sudo dnf install -y gcc
sudo dnf install -y gcc-c++
sudo dnf install -y gdb
sudo dnf install -y strace