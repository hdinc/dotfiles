#for nvidia driver
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
xrandr --dpi 96

#some programs wont open without this.
export _JAVA_AWT_WM_NONREPARENTING=1

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

setxkbmap -option 'caps:super' && xcape -e 'Super_L=Escape' &
xset r rate 300 30
xcompmgr &
exec dbus-launch --exit-with-session i3
