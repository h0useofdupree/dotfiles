#!/bin/bash

startxfce4 &

if pgrep -x "xfwm4" > /dev/null
then
	killall xfwm4
fi


sxhkd &
autostart &
#polybar example &
. "${HOME}/.config/bspwm/colors.sh"
