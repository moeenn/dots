#! /bin/bash

function link_home_files() {
  declare -a files=(
    ".bin"
    ".ssh"
    ".bashrc"
    ".compton.conf"     
    ".cwmrc"
    ".gitconfig"
    ".profile"
    ".tmux.conf"
    ".vimrc"
    ".Xresources"
    ".xinitrc"
  )

  PREFIX="../configs/home"
  for file in ${files[@]}; do
    path=~/$file

    if ! [ -e $path ]; then
      echo "linking: $path"
      ln -sr $PREFIX/$file $path
    else
      old="$path.old"
      mv -v $path $old
      ln -sr $PREFIX/$file $path
    fi
  done  
}

function link_config_files() {
  declare -a files=(
  	"alacritty"
    "fish"
    "helix"
    "htop"
    "mpv"
    "sway"
    "xdg-desktop-portal"
  )

  PREFIX="../configs/config"
  for file in ${files[@]}; do
    path=~/.config/$file

    if ! [ -e $path ]; then
      echo "linking: $path"
      ln -sr $PREFIX/$file $path
    else
      old="$path.old"
      mv -v $path $old
      ln -sr $PREFIX/$file $path
    fi
  done
}

link_home_files
link_config_files
