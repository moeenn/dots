xrdb ~/.Xresources &

# set typing repeat rate
xset r rate 300 50 &

# this stupid line is required for some reason
dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY

# start wm.
exec cwm

