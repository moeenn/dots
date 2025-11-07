#! /bin/bash

sudo apt-get install -y flatpak;
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo;

sudo flatpak install flathub -y org.chromium.Chromium \
								com.bitwarden.desktop #\
								# md.obsidian.Obsidian \
								#io.beekeeperstudio.Studio \
								#com.usebruno.Bruno;
