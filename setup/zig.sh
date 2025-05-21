#! /bin/bash

PLATFORM="linux"  # options: linux, macos
ARCH="x86_64"     # options: x86_64, aarch64 
VERSION="0.14.0"

CURRENT_DIR=$(pwd)
INSTALL_PREFIX=$HOME/.local/bin
mkdir -p $INSTALL_PREFIX

ZIG_FILENAME="zig-${PLATFORM}-${ARCH}-${VERSION}.tar.xz"
ZIG_URL="https://ziglang.org/download/${VERSION}/${ZIG_FILENAME}"

ZLS_FILENAME="zls-${PLATFORM}-${ARCH}-${VERSION}.tar.xz"
ZLS_URL="https://builds.zigtools.org/${ZLS_FILENAME}"

cd /tmp/
wget $ZIG_URL
wget $ZLS_URL

tar -xvf $ZIG_FILENAME
mv -v zig-*/zig $INSTALL_PREFIX
mv -vr zig-*/lib $INSTALL_PREFIX

tar -xvf $ZLS_FILENAME
mv -v zls $INSTALL_PREFIX

cd $CURRENT_DIR
