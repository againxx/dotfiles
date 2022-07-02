#!/bin/sh

if pgrep --full "dwm_bar.sh --nodisk"; then
    killall dwm_bar.sh
    "$HOME"/Manually_Installed/dwm-bar/dwm_bar.sh --disk &
else
    killall dwm_bar.sh
    "$HOME"/Manually_Installed/dwm-bar/dwm_bar.sh --nodisk &
fi
