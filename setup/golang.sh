#!/bin/bash

GO_VERSION="1.21.0"
CURRENT_DIR=$(pwd)

cd /tmp/

FILENAME="go${GO_VERSION}.linux-amd64.tar.gz"
URL="https://go.dev/dl/${FILENAME}"
wget $URL
tar -xvf $FILENAME
sudo mv go /usr/local

cd $CURRENT_DIR
