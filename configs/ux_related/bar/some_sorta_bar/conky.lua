conky.config = {
    out_to_x = false,
    out_to_console = true,
    short_units = true,
    update_interval = 1
}

color1 = '\\#ffffff'
color2 = '\\#dcdcdc'

conky.text = [[\
&C \
&1 Battery: &2 $battery          \
&1 CPU: &2 $cpu%          \
&1 Ram: &2 $memperc%          \
&1 Uptime: &2 $uptime_short          \
&1 Up Speed: &2 ${upspeedf wlp2s0b1} kb/s          \
&1 Down Speed: &2 ${downspeedf wlp2s0b1} kb/s          \
&1 Time: &2 ${time %H . %M}
\
]]
