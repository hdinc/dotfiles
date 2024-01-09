#!/bin/bash

read -r window < <(xdotool getwindowfocus)
read -r status < <(xprop -id "$window" 8c TAG_INVERT)
! [[ "$status" == *0 ]] && status=0 || status=1
xprop -id "$window" -format TAG_INVERT 8c -set TAG_INVERT "$status"
