#!/bin/bash

GO_VERSION="1.23.2"
CURRENT_DIR=$(pwd)

cd /tmp/

FILENAME="go${GO_VERSION}.linux-amd64.tar.gz"
URL="https://go.dev/dl/${FILENAME}"
wget $URL
tar -xvf $FILENAME
sudo mv go /usr/local
cd $CURRENT_DIR

# install tools and lsp
go install -v golang.org/x/tools/gopls@latest
go install -v github.com/nametake/golangci-lint-langserver@latest
go install -v github.com/go-delve/delve/cmd/dlv@latest
go install -v github.com/golangci/golangci-lint/cmd/golangci-lint@latest
go install -v github.com/go-task/task/v3/cmd/task@latest
