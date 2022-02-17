#!/usr/bin/env bash

# Keymap
setxkbmap de &

# Start compositor
picom &

# Applets
nm-applet &
pasystray &
optimus-manager-qt &

# KDE Connect (TODO: Remake as failsafe since some apps kill kdeconnect)
kdeconnect-cli -l &

sleep 1

# Both Autorandr Configs for docked. (TODO: To be done dynamically) #FIXME
autorandr docked 

# Reload Config for Colors to reload
fish -c clr &
