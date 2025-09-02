#! /bin/bash

declare -a packages=(
	"vim"
	"make"
	"net-tools"
	"bwm-ng"
	"jq"
	"curl"
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
	"zoxide"
	"pkg-config"
	"ccache"
	"aria2"
	"axel"
	"redshift"
)

install_cmd="sudo apt-get install -y "
for pkg in ${packages[@]}; do
  install_cmd="${install_cmd} ${pkg} "
done

eval $install_cmd
