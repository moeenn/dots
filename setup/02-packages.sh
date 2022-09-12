#!/bin/bash

install_cmd="sudo apt-get install -y"

declare -a packages=(
	"git"
	"htop"
	"tmux"
	"neovim"
	"openbox"
	"hsetroot"
	"fish"
	"yaru-theme-gtk"
	"yaru-theme-icon"
	"lxappearance"
	"obconf"
	"lxappearance-obconf"
	"rxvt-unicode"
	"thunar"
	"engrampa"
	"p7zip"
	"p7zip-full"
	"p7zip-rar"
	"viewnior"
	"thunar-archive-plugin"
	"pavucontrol"
	"xbacklight"
	"lxrandr"
	"remmina"
	"filezilla"
	"flatpak"
)

packages_str=""
for pkg in ${packages[@]}; do
	packages_str="${packages_str}${pkg} "
done

eval "$install_cmd $packages_str"