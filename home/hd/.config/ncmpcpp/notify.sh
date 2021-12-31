#!/bin/bash

notify-send -t 6000 "MPD" "$(mpc -f %title% | head -n1)"
