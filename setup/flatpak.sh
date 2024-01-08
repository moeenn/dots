#! /bin/bash

declare -a packages=(
	"com.github.tchx84.Flatseal"
#	"rest.insomnia.Insomnia"
	"com.bitwarden.desktop"
	"md.obsidian.Obsidian"
#	"io.beekeeperstudio.Studio"
)


install_cmd="sudo flatpak install flathub -y "
for pkg in ${packages[@]}; do
  install_cmd="${install_cmd} ${pkg} "
done

sudo apt-get install -y flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
eval $install_cmd
