#!/bin/bash

base_install_cmd="sudo apt-get install flatpak -y"
repo_add_cmd="flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo"
install_cmd="flatpak install flathub -y"

declare -a flatpaks=(
	"com.github.tchx84.Flatseal"
	"org.mozilla.firefox"
	"com.google.Chrome"
	"rest.insomnia.Insomnia"
	"com.sublimetext.three"
	"com.bitwarden.desktop"
)

flatpaks_str=""
for pkg in ${flatpaks[@]}; do
	flatpaks_str="${flatpaks_str}${pkg} "
done

eval "$base_install_cmd && $repo_add_cmd"
eval "$install_cmd $flatpaks_str"