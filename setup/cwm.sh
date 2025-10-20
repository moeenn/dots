#! /bin/bash

declare -a packages=(
	"cwm"
	"lxappearance"
	"alacritty"
	"thunar"
	"feh"
	"viewnior"
	"i3lock"
	"gmrun"
	"picom"
	"yaru-theme-icon"
	"yaru-theme-gtk"
)

install_cmd="sudo apt-get install -y "
for pkg in ${packages[@]}; do
  install_cmd="${install_cmd} ${pkg} "
done

eval $install_cmd
