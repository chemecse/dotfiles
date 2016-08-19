#!/bin/bash

set -eu

. ./user-config.dat

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

