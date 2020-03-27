#! /bin/sh

# pull the latest dots
echo "\033[32mGetting the latest configuration dot files ...\033[0m";
wget "https://github.com/moeenn/dots/archive/master.zip";

# unzip the fetched archive
echo "\033[32mUnzipping Dots Archive\033[0m";
unzip master.zip;

# remove downloaded dots archive
echo "\033[33mRemoving Dots Archive\033[0m";
rm -vf master.zip;

# place the core dots folder
ln -srf ./dots-master/ $HOME/.dots/;

# link the conf_dir content
ln -srf $HOME/.dots/configs/config $HOME/.config;

# link home folder dots
ln -srf $HOME/.dots/configs/home/.* $HOME/;

# copy xorg configs
echo "\033[32mXorg Tear-free Configs need to be installed System-wide. Please provide authentication\033[0m";
sudo ln -srf $HOME/.dots/configs/others/Xorg/xorg.conf.d /etc/X11/;

# diplay command for installation of common packages
echo "\033[32mCommon applications and utilities can be installed using following command\033[0m";
echo "sudo apt-get install \$(cat $HOME/.dots/configs/packages)"
