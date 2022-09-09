#!/bin/bash

# xautolock -time 1 -locker lock.sh

maim /tmp/sc1.png

convert /tmp/sc1.png -scale 10% -scale 1000% /tmp/sc.png
# convert /tmp/sc1.png  -blur 0x6 /tmp/sc.png
rm /tmp/sc1.png

i3lock -i /tmp/sc.png

# Turn the screen off after a delay.
# sleep 60; pgrep i3lock && xset dpms force off
