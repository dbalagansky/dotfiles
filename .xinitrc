#!/bin/sh
# vim:set filetype=sh:

xsetroot -solid '#172634' &

while true
do
    if $(mpc | grep -q 'playing')
    then
        MPCSTATUS="$(mpc | sed -n '1p')"
    else
        MPCSTATUS="stopped"
    fi
    if [[ $TIMER -eq 0 ]]
    then
        BATTERY="$(expr `cat /sys/class/power_supply/BAT0/charge_now` \* 100 / `cat /sys/class/power_supply/BAT0/charge_full`)%"
        OUTTEMP="$(curl -s https://www.timeanddate.com/weather/russia/saint-peterburg | sed -n 's/.*Now.*h2>\(-\?[0-9]\+\)\&nbsp;°C.*/\1/p')°C"
        TIMER=600
    else
        TIMER=$(expr $TIMER - 60)
    fi

    xsetroot -name "mpd: $MPCSTATUS | battery: $BATTERY | outtemp: $OUTTEMP | $(date '+%b %d %a %H:%M')"
    sleep 60
done &
dwm-start
