#!/bin/bash
apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y git
git clone https://github.com/mokibit/debian-for-crun-1.21.git
cd debian-for-crun-1.21
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y make git gcc build-essential pkgconf libtool libsystemd-dev libprotobuf-c-dev libcap-dev libseccomp-dev libyajl-dev go-md2man autoconf python3 automake gperf golang-github-opencontainers-image-spec-dev
./autogen.sh
./configure
make
cd ..
tar -czvf crun_1.21.orig.tar.gz debian-for-crun-1.21/
DEBIAN_FRONTEND=noninteractive apt-get install -y devscripts build-essential debhelper dpkg-dev
cd debian-for-crun-1.21
DEB_BUILD_OPTIONS=nocheck debuild -us -uc
