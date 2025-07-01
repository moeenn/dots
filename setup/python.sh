#! /bin/bash

sudo apt-get install -y python3-pip python3.12-venv
pip3 install --user pyright pyright-langserver ruff mypy invoke
