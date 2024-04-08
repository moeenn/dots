#! /bin/bash

declare -a packages=(
  "vim"
	"make"
	"libx11-dev"
	"libfontconfig1-dev"
	"libxft-dev"
	"libxinerama-dev"
	"net-tools"
	"bwm-ng"
	"git"
  "htop"
	"dfc"
	"tmux"
	"acpi"
	"p7zip"
	"p7zip-full"
	"p7zip-rar"
	"fonts-go"
	"fonts-jetbrains-mono"
  "fonts-firacode",
	"yaru-theme-gtk"
	"yaru-theme-icon"
	"paper-icon-theme"
	"mpv"
	"viewnior"
	"thunar-archive-plugin"
	"gnome-screenshot"
	"evince"
  "gcolor3"
)

install_cmd="sudo apt-get install -y "
for pkg in ${packages[@]}; do
  install_cmd="${install_cmd} ${pkg} "
done

eval $install_cmd
