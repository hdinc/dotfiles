#!/bin/bash
mpc current;
while true;
do
    mpc current --wait;
    [ $? -eq 0 ] || { echo ""; sleep 10; }
done
