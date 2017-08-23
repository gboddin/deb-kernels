#!/bin/bash
set -x
set -e
REVISION=$(date +%s)
[ ! -z "$1" ] && REVISION=$1
apt-get update
apt-get install --no-install-recommends -y ca-certificates wget build-essential kernel-package linux-image-amd64
wget https://github.com/torvalds/linux/archive/master.tar.gz -O -|tar -xz
mv linux-master linux
cp /boot/config* linux/.config
cd linux
yes '' | make oldconfig
make-kpkg -j$(cat /proc/cpuinfo|grep -i bogo|wc -l) buildpackage modules --append-to-version -master --revision ${REVISION} --initrd
