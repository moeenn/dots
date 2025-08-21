#! /bin/bash

sudo dnf install -y python3-pip python3-venv pipx
pipx install pyright venv pyright-langserver ruff
