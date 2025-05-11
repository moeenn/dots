#! /bin/bash

USER=$(whoami)

sudo apt-get install -y docker.io docker-compose
sudo groupadd docker
sudo usermod -aG docker $USER
