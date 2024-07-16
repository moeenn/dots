#!/bin/bash

GO_VERSION="1.22.0"
CURRENT_DIR=$(pwd)

cd /tmp/

FILENAME="go${GO_VERSION}.linux-amd64.tar.gz"
URL="https://go.dev/dl/${FILENAME}"
wget $URL
tar -xvf $FILENAME
sudo mv go /usr/local

cd $CURRENT_DIR

# install necessary tools
sudo apt-get install -y golang-honnef-go-tools-dev

# lsp tools
go install golang.org/x/tools/gopls@latest
go install github.com/nametake/golangci-lint-langserver@latest
go install github.com/go-delve/delve/cmd/dlv@latest

# linting tools
go install honnef.co/go/tools/cmd/staticcheck@latest
go install github.com/kisielk/errcheck@latest

# optional listers
go install github.com/jgautheron/goconst/cmd/goconst@latest

# live reload tools
go install github.com/air-verse/air@latest
