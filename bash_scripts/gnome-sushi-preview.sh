#!/bin/bash
# run GNOME sushi to preview pdf in zotero

PDF_FILE=$(/usr/bin/realpath "$*")

dbus-send --print-reply --dest=org.gnome.NautilusPreviewer /org/gnome/NautilusPreviewer org.gnome.NautilusPreviewer.ShowFile string:"file://$PDF_FILE" int32:0 boolean:false
