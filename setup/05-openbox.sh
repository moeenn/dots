#!/bin/bash

install_cmd="sudo apt-get install -y"

declare -a packages=(
	"obconf"
	"lxappearance"
	"lxappearance-obconf"
	"rxvt-unicode"
	"viewnior"
	"thunar"
	"thunar-archive-plugin"
	"pavucontrol"
	"lxrandr"
	"libnotify-bin"
	"notify-osd"
	"i3lock"
	"compton"
	"openbox"
)

packages_str=""
for pkg in ${packages[@]}; do
	packages_str="${packages_str}${pkg} "
done

eval "$install_cmd $packages_str"