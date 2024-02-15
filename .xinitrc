#!/bin/bash

xsetroot -solid '#c8c3ad' &

if command -v clipmenud 1>/dev/null 2>&1
then
    clipmenud 1>/dev/null 2>&1 &
fi

while true
do
    if [ -e /sys/class/power_supply/BAT0 ]
    then
        BATTERY=" $(expr `cat /sys/class/power_supply/BAT0/energy_now` \* 100 / `cat /sys/class/power_supply/BAT0/energy_full`)%"
    fi

    xsetroot -name "$BATTERY"
    sleep 600
done &

if [ -x /usr/bin/dwm-start ]
then
    /usr/bin/dwm-start
else
    /usr/bin/dwm
fi
