#for nvidia driver
# xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
xrandr --dpi 96

xrdb ~/.Xresources

setxkbmap -option 'caps:super' && xcape -e 'Super_L=Escape' &
xset r rate 300 30
# synclient MaxSpeed=1 MinSpeed=1

# xcompmgr &
picom --config /dev/null --backend=glx --vsync -b &

if pgrep -x "urxvtd" > /dev/null
then
    :
else
    urxvtd -q -f -o
fi

exec dbus-launch --exit-with-session i3
# exec startplasma-x11
