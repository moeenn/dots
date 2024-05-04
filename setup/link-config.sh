#! /bin/bash

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
