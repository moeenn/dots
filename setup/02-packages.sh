#!/bin/bash

install_cmd="sudo apt-get install -y"

declare -a packages=(
	"libx11-dev"
	"libfontconfig1-dev"
	"libxft-dev"
	"libxinerama-dev"
  "mypy"
  "python3-mypy"
  "python3-autopep8"
  "python3-venv"
  "feh"
  "make"
	"cmake"
	"clang"
	"clangd"
	"clang-format"
  "fonts-roboto"
  "acpi"
	"git"
	"htop"
	"tmux"
	"neovim"
	"hsetroot"
	"fish"
	"yaru-theme-gtk"
	"yaru-theme-icon"
	"engrampa"
	"p7zip"
	"p7zip-full"
	"p7zip-rar"
	"xbacklight"
	"remmina"
	"filezilla"
	"flatpak"
)

packages_str=""
for pkg in ${packages[@]}; do
	packages_str="${packages_str}${pkg} "
done

eval "$install_cmd $packages_str"
