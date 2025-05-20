#! /bin/bash

USER=$(whoami)

sudo dnf install -y docker-cli docker-compose
sudo groupadd docker
sudo usermod -aG docker $USER
