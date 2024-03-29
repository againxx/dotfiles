#!/bin/sh
# dmenu_kdeconnect.sh is a script based off of these scripts
# [polybar-kdeconnect] https://github.com/HackeSta/polybar-kdeconnect 
# [polybar-kdeconnect-scripts] https://github.com/witty91/polybar-kdeconnect-scripts
# Added features
# - Removed polybar as a Dependencies (since I use dwm)
# - Integration with a variety of file managers
# - Implementation as one simplified shell script
# - utilize sh instead of bash

# TODO
# 1. Allow different dmenu colors based on the battery percentage
# 2. Make the script no sh complaint
# 3. Implement a contacts list to make sms messaging easier

# Dependancies
# -dmenu
# -kdeconnect
# -zenity, nnn, or ranger
# -qt5-tools
# -dbus
# -dunst

# Color Settings of dmenu
COLOR_DISCONNECTED='#000'       # Device Disconnected
COLOR_NEWDEVICE='#ff0'          # New Device
COLOR_BATTERY_90='#fff'         # Battery >= 90
COLOR_BATTERY_80='#ccc'         # Battery >= 80
COLOR_BATTERY_70='#aaa'         # Battery >= 70
COLOR_BATTERY_60='#888'         # Battery >= 60
COLOR_BATTERY_50='#666'         # Battery >= 50
COLOR_BATTERY_LOW='#f00'        # Battery <  50

# Icons shown in dmenu
ICON_SMARTPHONE=''
ICON_TABLET=''
SEPERATOR='|'

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

ping -q -c 1 1.1.1.1 > /dev/null || (notify-send "check internet connection" && exit)

show_devices (){
    devices=""
    # for all the devices avalable
    for device_id in $(qdbus org.kde.kdeconnect /modules/kdeconnect org.kde.kdeconnect.daemon.devices); do
        #get the device info
        device_name=$(qdbus org.kde.kdeconnect /modules/kdeconnect/devices/"$device_id" org.kde.kdeconnect.device.name)
        device_type=$(qdbus org.kde.kdeconnect /modules/kdeconnect/devices/"$device_id" org.kde.kdeconnect.device.type)
        is_reachable="$(qdbus org.kde.kdeconnect /modules/kdeconnect/devices/"$device_id" org.kde.kdeconnect.device.isReachable)"
        is_trusted="$(qdbus org.kde.kdeconnect /modules/kdeconnect/devices/"$device_id" org.kde.kdeconnect.device.isTrusted)"
        if [ "$is_reachable" = "true" ] && [ "$is_trusted" = "true" ]; then
            #is connected
            battery="$(qdbus org.kde.kdeconnect /modules/kdeconnect/devices/"$device_id"/battery org.kde.kdeconnect.device.battery.charge)%"
            icon=$(get_icon "$battery" "$device_type")
            # colors="$(get_colors $battery)"
            # echo "$colors"
            show_menu "$device_name | $battery $icon" "$device_id" "$battery"
            devices+="$device_name $battery $icon $SEPERATOR"
        elif [ "$is_reachable" = "false" ] && [ "$is_trusted" = "true" ]; then
            #nothing is found
            devices+="$(get_icon -1 $device_type)$SEPERATOR"
        else
            #found but not yet paired
            icon=$(get_icon -2 $device_type)
            # show_pmenu $device_name $device_id
            devices+="$device_name $icon $SEPERATOR"
        fi
    done
}

SendKeys(){
    output="?"
    TEMPFILE=/tmp/VimFloat
    > $TEMPFILE
    st -t "vim-anywhere" -n 'popup' -e "${EDITOR:-vi}" -c 'startinsert' $TEMPFILE
    xsel -i < $TEMPFILE
    output=$(xsel -o)
    notify-send "$output"
    kdeconnect-cli --device "$*" -k "$output"
}

# displays a menu for the connected device
show_menu () {
    optionNum=5
    options=$(printf "Send File\\nBrowse device (ranger)\\nBrowse device (Files)\\nSend SMS\\nFind device\\nPing\\nUnpair\\nSend keys\\nRefresh\\n")
    menu=$(echo "$options" | rofi -dmenu -i -p "$1" -l $optionNum -theme dracula-grid)
    sftp_command="qdbus org.kde.kdeconnect /modules/kdeconnect/devices/$2/sftp org.kde.kdeconnect.device.sftp."
    case "$menu" in
        "Ping")
            message=$(rofi -dmenu -i -p "Msg to send" -theme dracula-input)
            kdeconnect-cli --ping-msg "$message" -d "$2" ;;
        "Find device")
            kdeconnect-cli --ring -d "$2" ;;
        "Send file")
            tmp_file="$(mktemp /tmp/ranger-send-file.XXXXXX)"
            ranger --choosefile="$tmp_file"
            kdeconnect-cli --share "file://$(cat "$tmp_file")" -d "$2"
            rm "$tmp_file" ;;
        "Browse device (ranger)")
            is_mounted="$(${sftp_command}isMounted)"
            if [ "$is_mounted" = false ]; then
                eval ${sftp_command}mountAndWait
            fi
            ranger "$(${sftp_command}mountPoint)" ;;
        "Browse device (Files)")
            ${sftp_command}startBrowsing ;;
        "Unpair")
            kdeconnect-cli --unpair -d "$2" ;;
        "Send SMS")
            message=$(echo 'OTW' | dmenu -i -p "Msg to send")
            recipient=$(echo '14039199518' | dmenu -i -p "Recipient's phone #")
            kdeconnect-cli --send-sms "$message" --destination "$recipient" -d "$2" ;;
        "Refresh")
            kdeconnect-cli --refresh ;;
        "Send keys")
            SendKeys "$2" ;;
    esac
}

show_pmenu () {
    menu="$(printf "Pair Device" | dmenu -i -p "$1"  )"
    case "$menu" in
	*'Pair Device') kdeconnect-cli --pair -d $2 ;;
    esac
}
#still a work in progress
# get_colors () {
# 	case $1 in
# 	"-1")     colors="-nb \"$COLOR_DISCONNECTED\" -nf \"#000\" " ;;   
# 	"-2")     colors="-nb \"$COLOR_NEWDEVICE\"	-nf \"#000\" ";;   
# 	5*)     	colors="-nb \"$COLOR_BATTERY_50\"	-nf \"#000\" ";;
# 	6*)		colors="-nb \"$COLOR_BATTERY_60\"	-nf \"#000\" ";;
# 	7*)    	colors="-nb \"$COLOR_BATTERY_70\"	-nf \"#000\" ";;
# 	8*)     	colors="-nb \"$COLOR_BATTERY_80\"	-nf \"#000\" ";;
# 	*)      	colors="-nb \"$COLOR_BATTERY_LOW\" -nf \"#000\" ";; 
# 	9*|100) 	colors="-nb \"$COLOR_BATTERY_90\"	-nf \"#000\" ";;
# 	esac
# 	echo $colors
# }

get_icon () {
    if [ "$2" = "tablet" ]; then
        ICON=$ICON_TABLET
    else
        ICON=$ICON_SMARTPHONE
    fi
    echo $ICON
}
show_devices
