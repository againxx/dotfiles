#!/bin/sh

i3lock -i /home/ustc-1314/Pictures/lockscreen.png -F --clock \
    --ring-color=BAE67E --inside-color=1F2430 \
    --keyhl-color=86B300 --bshl-color=4CBF99 \
    --ringver-color=399EE6 --insidever-color=73D0FF \
    --ringwrong-color=FF3333 --insidewrong-color=F28779
sleep 10
systemctl suspend
