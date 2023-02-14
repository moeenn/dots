#!/bin/sh

src_dir=../configs
target_dir=$HOME

home_files=$(ls -a $HOME)

for f in $home_files; do
	echo $f
done