#! /bin/bash

declare -a packages=(
  "hsetroot"
  "xbacklight"
  "lxrandr"
  "libnotify-bin"
  "notify-osd"
  "pavucontrol"
  "feh"
  "lxappearance"
  "lxappearance-obconf"
  "thunar"
  "thunar-archive-plugin"
  "i3lock"
  "compton"
  "xbindkeys"
  "openbox"
  "obconf"
  "polybar"
  "rofi"
)

install_cmd="sudo apt-get install -y "
for pkg in ${packages[@]}; do
  install_cmd="${install_cmd} ${pkg} "
done

eval $install_cmd
