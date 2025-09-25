#!/bin/bash
apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y git
git clone https://github.com/p12tic/podman-compose-test-podman.git
cd podman-compose-test-podman/
apt update -y
git fetch https://github.com/p12tic/podman-compose-test-podman.git
git checkout debian-5.4.2
apt update -y
DEBIAN_FRONTEND=noninteractive apt -y install dpkg-dev devscripts libgpgme-dev libseccomp-dev build-essential
DEBIAN_FRONTEND=noninteractive apt-get install -y libsystemd-dev bash-completion conmon dh-golang go-md2man golang-dbus-dev golang-go libapparmor-dev libbtrfs-dev libdevmapper-dev libglib2.0-dev libsubid-dev
echo "deb http://deb.debian.org/debian bookworm-backports main" > /etc/apt/sources.list.d/backports.list
apt update -y
DEBIAN_FRONTEND=noninteractive apt install -y golang-1.22/bookworm-backports
DEBIAN_FRONTEND=noninteractive apt-get install -y golang-1.22/bookworm-backports
rm /usr/bin/go
ln -s /usr/lib/go-1.22/bin/go /usr/bin/go
DEBIAN_FRONTEND=noninteractive apt remove -y golang-1.19
go mod tidy
git archive --worktree-attributes --prefix=podman-5.4.2+composetest/ HEAD --format=tar.gz -o ../podman_5.4.2+composetest.orig.tar.gz
go install -trimpath -v -p 8 -tags "apparmor seccomp selinux systemd libsubid" -ldflags "-X github.com/containers/podman/libpod/define.buildInfo=1753462038                     -X github.com/containers/podman/libpod/define.buildOrigin=Debian" github.com/containers/podman/cmd/podman github.com/containers/podman/cmd/rootlessport github.com/containers/podman/cmd/quadlet
DEB_BUILD_OPTIONS=nocheck debuild -us -uc
cd ..
git clone https://github.com/mokibit/debian-for-crun-1.21.git
cd debian-for-crun-1.21
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y make git gcc build-essential \
    pkgconf libtool libsystemd-dev libprotobuf-c-dev libcap-dev \
    libseccomp-dev libyajl-dev go-md2man autoconf python3 automake \
    gperf golang-github-opencontainers-image-spec-dev
./autogen.sh
./configure
make
cd ..
tar -czvf crun_1.21.orig.tar.gz debian-for-crun-1.21/
DEBIAN_FRONTEND=noninteractive apt-get install -y devscripts build-essential debhelper dpkg-dev
cd debian-for-crun-1.21
DEB_BUILD_OPTIONS=nocheck debuild -us -uc
