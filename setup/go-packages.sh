#!/bin/bash

# install tools and lsp
go install -v golang.org/x/tools/gopls@latest
go install -v github.com/nametake/golangci-lint-langserver@latest
go install -v github.com/go-delve/delve/cmd/dlv@latest
go install -v github.com/golangci/golangci-lint/cmd/golangci-lint@latest
go install -v github.com/go-task/task/v3/cmd/task@latest
