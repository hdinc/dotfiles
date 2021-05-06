#!/bin/bash

printTime() {
    while test 1
    do
        date +%R
        sleep 5
    done
}

printTime &

while read line
do
    if [[ $line -eq "1" ]]
    then
        gsimplecal &
    fi
done

trap 'kill $(jobs -p)' EXIT
