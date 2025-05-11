#! /bin/bash

declare -a files=(
  ".bin"
  ".ssh"
  ".axelrc"
  ".bashrc"
  ".gitconfig"
  ".profile"
  ".tmux.conf"
  ".vimrc"
  ".Xresources"
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
