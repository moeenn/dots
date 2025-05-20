#! /bin/bash

sudo dnf install -y fish

USER=$(whoami)
LOCATION=$(which fish)

sudo usermod -s $LOCATION $USER
