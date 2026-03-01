#!/bin/bash
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y git
git clone --depth 1 --branch debian-5.7.1 https://github.com/p12tic/podman-compose-test-podman.git podman-5.7.1
cd podman-5.7.1
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends devscripts bash-completion conmon build-essential libsubid-dev dh-golang go-md2man golang-go libapparmor-dev libbtrfs-dev libdevmapper-dev debhelper pkg-config libsystemd-dev libgpgme-dev libseccomp-dev libglib2.0-dev golang-dbus-dev
DEB_BUILD_OPTIONS=nocheck debuild -us -uc -b
