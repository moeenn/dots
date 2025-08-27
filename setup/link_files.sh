#! /bin/bash

function link_home_files() {
  declare -a files=(
    ".bin"
    ".ssh"
    ".bashrc"
    ".gitconfig"
    ".profile"
    ".tmux.conf"
    ".vimrc"
  )

  PREFIX="../configs/base/home"
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
    "fish"
    "helix"
    "htop"
    "mpv"
  )

  PREFIX="../configs/base/config"
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
