#!/bin/bash

VERSION="0.15.0"
ARCH="x86_64-linux"

CURRENT_DIR=$(pwd)
INSTALL_PREFIX="${HOME}/.local/bin"

ZIG_FILENAME="zig-${ARCH}-${VERSION}"
ZIG_FULLNAME="${ZIG_FILENAME}.tar.xz"
ZIG_URL="https://ziglang.org/download/${VERSION}/${ZIG_FULLNAME}"

ZLS_FILENAME="zls-${ARCH}-${VERSION}"
ZLS_FULLNAME="${ZLS_FILENAME}.tar.xz"
ZLS_URL="https://builds.zigtools.org/${ZLS_FULLNAME}"

cd /tmp/

wget $ZIG_URL
wget $ZLS_URL

tar -xvf ./$ZIG_FULLNAME
tar -xvf ./$ZLS_FULLNAME

cd ./$ZIG_FILENAME/
mv -v ./zig ${INSTALL_PREFIX}
rm -rvf ${INSTALL_PREFIX}/lib
mv -v ./lib ${INSTALL_PREFIX}

cd ..
mv -v ./zls ${INSTALL_PREFIX}
cd $CURRENT_DIR
