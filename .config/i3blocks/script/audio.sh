#!/bin/bash
set -e

MUTE=$(pactl list sinks | grep '^[[:space:]]Mute:' | awk '{print $2}')

case "${BLOCK_BUTTON}" in
    1)
        if [ "${MUTE}" = "yes" ]; then
            pactl set-sink-mute 0 0
        else
            pactl set-sink-mute 0 1
        fi
        ;;
    3)
        i3-msg exec pavucontrol > /dev/null
        ;;
    4)
        pactl set-sink-volume 0 +5%
        ;;
    5)
        pactl set-sink-volume 0 -5%
        ;;
    *)
esac

VOL=$(pactl list sinks | grep '^[[:space:]]Volume:' | awk '{print $5}')
VOL_PCT=${VOL%%%*}

if [ "${MUTE}" = "yes" ]; then
    echo " muted"
else
    echo " ${VOL_PCT}%"
fi
