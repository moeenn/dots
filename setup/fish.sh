#! /bin/bash

sudo apt-get install -y fish;

USER=$(whoami)
LOCATION=$(which fish)

sudo usermod -s $LOCATION $USER;
