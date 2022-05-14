#!/usr/bin/env bash

# Start compositor
picom &

# Applets
pasystray &
nm-applet &
optimus-manager-qt &
flameshot &

# Input device Config 
# NOTE: Only important if libinput-gestures is not autostarted.
libinput-gestures-setup start &
fish -c "uml_startup" &
playerctld daemon &

# Notifications
launch_dunst &

# Render Effects for betterlockscreen
betterlockscreen -u $CURRENT_WALLPAPER &

# Policy Kit Authentication GUI
lxqt-policykit-agent &

# Set DPMS and Screen Timeout
xset -dpms
xset s 7200

# KDE Connect
# HACK: Now starting kdeconnectd and kdeconnect-cli manually in that order
/usr/lib/kdeconnectd &
kdeconnect-cli -l &

# Screen Layout
MONITOR_COUNT=$(xrandr -q | grep -c " connected")
echo $MONITOR_COUNT > ~/.scripts/display/CONNECTED_MONITORS
DATE=$(date)
# TODO: Improve spontaneous monitor hotplugging capabilities 

# Favorites
INV_MOUNT=wallhaven-k7v83q
ROBOT=robot # NEO
CLOUDS=wallhaven-6q2le6
TRIAD=wallhaven-j3qeyq
RED_SUNSET=wallhaven-k7v9yq
PURPLE_DROP=wallhaven-k761p6
FLOWERS=wallhaven-mpo33m # NEO

autorandr -c

# Random wallpaper from folder wp <folder>
# fish -c "wp pastel" &
# Select specific wallpaper with variables set above wps <folder> <name>
fish -c "wps neo $FLOWERS"

# NOTE: Actions for home setup
if [[ $MONITOR_COUNT -gt 1 ]]; then
	echo "$DATE - Detected home setup" >> ~/.scripts/display/startup.log
    xmodmap ~/.Xmodmap &
# NOTE: Actions for mobile setup
elif [[ $MONITOR_COUNT -eq 1 ]]; then
	echo "$DATE - Detected mobile setup" >> ~/.scripts/display/startup.log
fi
