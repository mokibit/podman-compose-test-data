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
