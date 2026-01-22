#!/bin/bash
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y git lintian go-md2man protobuf-compiler dh-cargo devscripts build-essential debhelper dpkg-dev
git clone https://github.com/mokibit/debian-for-netavark-1.14
cd debian-for-netavark-1.14/
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | RUSTUP_INIT_SKIP_PROMPT=1 sh -s -- -y
. "$HOME/.cargo/env"
dpkg-buildpackage -b -us -uc
