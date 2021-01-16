#!/bin/sh
# vim:set filetype=sh:

TIMER=0

xsetroot -solid '#172634' &

while true
do
    if $(mpc | grep -q 'playing')
    then
        MPCSTATUS="$(mpc | sed -n '1p')"
    else
        MPCSTATUS="stopped"
    fi
    if [ $TIMER -eq 0 ]
    then
        if [ -e /sys/class/power_supply/BAT0 ]
        then
            BATTERY="$(expr `cat /sys/class/power_supply/BAT0/charge_now` \* 100 / `cat /sys/class/power_supply/BAT0/charge_full`)%"
        else
            BATTERY=0
        fi
        OUTTEMP="$(curl -s https://www.timeanddate.com/weather/russia/saint-peterburg | sed -n 's/.*Now.*h2>\(-\?[0-9]\+\)\&nbsp;°C.*/\1/p')°C"
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
