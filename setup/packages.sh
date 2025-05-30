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
	"jetbrains-mono-fonts"
	"mozilla-fira-sans-fonts"
	"mpv"
  "gcolor3"
)

install_cmd="sudo dnf install -y "
for pkg in ${packages[@]}; do
  install_cmd="${install_cmd} ${pkg} "
done

eval $install_cmd
