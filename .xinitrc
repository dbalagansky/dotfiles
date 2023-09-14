#!/bin/bash

TIMER=0

xsetroot -solid '#172634' &

test -f ~/.Xresources && xrdb -merge -I$HOME ~/.Xresources

while true
do
    if [ $TIMER -eq 0 ]
    then
        if [ -e /sys/class/power_supply/BAT0 ]
        then
            BATTERY="$(expr `cat /sys/class/power_supply/BAT0/energy_now` \* 100 / `cat /sys/class/power_supply/BAT0/energy_full`)%"
        else
            BATTERY=0
        fi
        OUTTEMP="$(curl 'https://wttr.in/Saint-Petersburg?format=%t')"
        TIMER=600
    else
        TIMER=$(expr $TIMER - 60)
    fi

    xsetroot -name " mpd: $MPCSTATUS | battery: $BATTERY | outtemp: $OUTTEMP | $(date '+%b %d %a %H:%M')"
    sleep 60
done &

if [ -x /usr/bin/dwm-start ]
then
    /usr/bin/dwm-start
else
    /usr/bin/dwm
fi
