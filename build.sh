#!/bin/bash
set -x
set -e
apt-get update
apt-get install -y kernel-package linux-image-amd64
git clone https://github.com/torvalds/linux.git 
cp /boot/config* linux/.config
cd linux
yes '' | make oldconfig
