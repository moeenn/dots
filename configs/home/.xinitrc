xrdb ~/.Xresources &

# set typing repeat rate
xset r rate 300 50 &

# enable compositor
picom &
xset b off &
#pulseaudio -D &

# wallpaper
hsetroot -solid "#305065" &		 	

# set warn screen colors.
# redshift -O 5500 &

# start bar script.
# cwmbar &

# start wm.
exec cwm

