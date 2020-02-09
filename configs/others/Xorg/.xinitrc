#!/bin/sh

xrdb ~/.Xresources &					# set the font and colors
#compton &								# compositing
xrandr --output DP1 --rotate left --left-of HDMI3 &	# dispay settings
redshift -o 3500k &						# color temperature
pulseaudio -D &							# enable if system uses pulseaudio
dwmstatus &								# Statusbar
exec dwm								# WM (Fallback)