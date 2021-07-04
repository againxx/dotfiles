#!/bin/bash

if [[ $# -lt 1 ]]; then
    echo "Usage: $0 wallpaper_image"
    exit 1
fi

selected_image="$1"
if pgrep convert; then
    killall convert
fi
convert "$selected_image" -resize 1440 -quality 100 -brightness-contrast -10x-15 -blur 0x20 ~/Pictures/lockscreen.png
feh --bg-fill "$selected_image"
