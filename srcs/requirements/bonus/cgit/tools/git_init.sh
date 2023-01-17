#!/bin/bash

mkdir /var/git/.ssh
chmod 760 /var/git/.ssh
touch /var/git/.ssh/authorized_keys
chmod 660 /var/git/.ssh/authorized_keys
mkdir /var/git/inception.git
cd /var/git/inception.git
git config --global init.defaultBranch master
git --bare init
