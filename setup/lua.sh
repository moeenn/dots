#! /bin/bash

VERSION='3.12.2'
FILENAME="luarocks-${VERSION}.tar.gz"
URL="https://luarocks.org/releases/${FILENAME}"

PWD=$(pwd)
cd /tmp/

if [ ! -e ./${FILENAME} ]; then
    wget "${URL}"    
fi

tar zxpf ./${FILENAME}
cd ./luarocks-${VERSION}
./configure
make
sudo make install
cd ${PWD}
