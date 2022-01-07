#!/bin/bash

mpc current;

printMpd(){
    while true
    do
        mpc idle player > /dev/null
        mpc current
        [ $? -eq 0 ] || { echo ""; sleep 10; }
    done
}

printMpd &

while read line
do
    case $line in
        "1")
            mpc prev > /dev/null
        ;;
        "2")
            mpc toggle > /dev/null
        ;;
        "3")
            mpc next > /dev/null
        ;;
        "4")
            mpc seek +10 > /dev/null
        ;;
        "5")
            mpc seek -10 > /dev/null
        ;;
    esac
done

trap 'kill $(jobs -p)' EXIT
