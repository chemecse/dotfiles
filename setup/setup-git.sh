#!/bin/sh

set -eu

. ./user-config.dat

sudo dnf install -y git
sudo dnf install -y git-email

git config --global user.email $EMAIL
git config --global user.name "$NAME"
git config --global core.editor vim
git config --global sendemail.smtpserver smtp.gmail.com
git config --global sendemail.smtpserverport 587
git config --global sendemail.smtpencryption tls
git config --global sendemail.smtpuser $EMAIL

