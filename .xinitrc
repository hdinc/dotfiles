#for nvidia driver
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
xrandr --dpi 96

# Adds `~/.local/bin` to $PATH
export PATH="$PATH:$HOME/.local/bin/"

#some programs doesnt open without this.
export _JAVA_AWT_WM_NONREPARENTING=1

setxkbmap -option 'caps:super' && xcape -e 'Super_L=Escape' &
xset r rate 300 30
xcompmgr &
exec i3
