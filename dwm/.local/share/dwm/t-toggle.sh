#!/bin/sh

if pgrep stalonetray; then
    killall stalonetray
else
    stalonetray &
    until xdotool search --name stalonetray; do
        :
    done
    xdotool keydown Super key s keyup Super
fi
