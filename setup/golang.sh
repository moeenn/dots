#!/bin/bash

GO_VERSION="1.23.5"
CURRENT_DIR=$(pwd)

cd /tmp/

FILENAME="go${GO_VERSION}.linux-amd64.tar.gz"
URL="https://go.dev/dl/${FILENAME}"
wget $URL
tar -xvf $FILENAME
sudo mv go /usr/local
cd $CURRENT_DIR

# install tools and lsp
go install golang.org/x/tools/gopls@latest
go install github.com/nametake/golangci-lint-langserver@latest
go install github.com/go-delve/delve/cmd/dlv@latest
