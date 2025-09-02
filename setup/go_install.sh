#! /bin/bash

GO_VERSION="1.25.0"
CURRENT_DIR=$(pwd)
INSTALL_PREFIX="/usr/local"

cd /tmp/

FILENAME="go${GO_VERSION}.linux-amd64.tar.gz"
URL="https://go.dev/dl/${FILENAME}"
wget $URL
tar -xvf $FILENAME
sudo mv go $INSTALL_PREFIX
cd $CURRENT_DIR
