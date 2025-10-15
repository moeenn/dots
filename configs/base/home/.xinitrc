xrdb ~/.Xresources &

# set typing repeat rate
xset r rate 300 50 &

# enable compositor
compton &
#xrandr --output DP1 --rotate left --left-of HDMI3 &
xset b off &
#pulseaudio -D &

# wallpaper
hsetroot -solid "#305065" &		 	

# set warn screen colors.
redshift -O 5500 &

# start wm.
exec cwm

