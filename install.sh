#! /bin/sh

# pull the latest dots
echo "\033[32mGetting the latest configuration dot files ...\033[0m";
git clone https://github.com/moeenn/dots

# place the core dots folder
mv -vrf ./dots/ $HOME/.dots/;

# link the conf_dir content
ln -srf $HOME/.dots/configs/config/* $HOME/.config;

# link home folder dots
ln -srf $HOME/.dots/configs/home/.* $HOME/;

# copy xorg configs
echo "\033[32mXorg Tear-free Configs need to be installed System-wide. Please provide authentication\033[0m";
sudo ln -srf $HOME/.dots/configs/others/Xorg/xorg.conf.d /etc/X11/;

# diplay command for installation of common packages
echo "\033[32mCommon applications and utilities can be installed using following command\033[0m";
echo "sudo apt-get install \$(cat $HOME/.dots/configs/packages)"
