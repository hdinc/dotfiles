#for nvidia driver
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
xrandr --dpi 96

# [[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
xrdb ~/.Xresources

setxkbmap -option 'caps:super' && xcape -e 'Super_L=Escape' &
xset r rate 300 30
xcompmgr &
urxvtd -q &
exec dbus-launch --exit-with-session i3
