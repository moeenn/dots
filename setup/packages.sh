#! /bin/bash

declare -a packages=(
  "vim"
	"make"
	"net-tools"
	"bwm-ng"
	"jq"
	"axel"
	"gparted"
	"git"
  "htop"
	"dfc"
	"tmux"
	"acpi"
	"p7zip"
	"fonts-jetbrains-mono"
	"fonts-go"
	"mpv"
  "gcolor3"
)

install_cmd="sudo apt-get install -y "
for pkg in ${packages[@]}; do
  install_cmd="${install_cmd} ${pkg} "
done

eval $install_cmd
