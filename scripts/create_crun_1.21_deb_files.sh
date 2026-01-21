#!/bin/bash
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y git build-essential pkg-config libsystemd-dev libprotobuf-c-dev libcap-dev libseccomp-dev libyajl-dev devscripts debhelper dpkg-dev go-md2man golang-github-opencontainers-image-spec-dev gperf autoconf automake libtool
git clone https://github.com/mokibit/debian-for-crun-1.21.git
cd debian-for-crun-1.21
./autogen.sh
./configure
make
cd ..
tar -czvf crun_1.21.orig.tar.gz debian-for-crun-1.21/
cd debian-for-crun-1.21
DEB_BUILD_OPTIONS=nocheck debuild -us -uc
