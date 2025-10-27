#! /bin/bash
sudo apt-get install -y python3-pip \
						python3-venv \
						pipx;

pipx install pyright \
			 ruff \
			 mypy;
