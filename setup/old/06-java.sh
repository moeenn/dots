#!/bin/bash

install_cmd="sudo apt-get install -y"

declare -a packages=(
	"default-jdk"
	"libeclipse-jdt-core-java"
)

packages_str=""
for pkg in ${packages[@]}; do
	packages_str="${packages_str}${pkg} "
done

eval "$install_cmd $packages_str"