#!/usr/bin/env bash
# TODO: Improve spontaneous monitor hotplugging capabilities 

# Start compositor
picom --experimental-backends &

# Applets
pasystray &
nm-applet &
optimus-manager-qt &
flameshot &

# Input device Config 
# NOTE: Only important if libinput-gestures is not autostarted.
libinput-gestures-setup start &
fish -c "uml_startup" &

# Audio
playerctld daemon &

# Notifications
launch_dunst &

# Render Effects for 'betterlockscreen'
betterlockscreen -u $CURRENT_WALLPAPER &

# Policy Kit Authentication GUI
# TODO: Switch to different polkit agent with better UI
lxqt-policykit-agent &

# Set DPMS and Screen Timeout
xset -dpms &
xset s 7200 & # 2h

# KDE Connect
# HACK: Need to start kdeconnectd manually for kdeconnect to work
/usr/lib/kdeconnectd &
kdeconnect-cli -l &

#### Variables
### Misc
MONITOR_COUNT=$(xrandr -q | grep -c " connected")
DATE=$(date) &
### Wallpaper Favorites
## Pastel 
## Old
## Maller
INV_MOUNT=wallhaven-k7v83q
CLOUDS=wallhaven-6q2le6
TRIAD=wallhaven-j3qeyq
RED_SUNSET=wallhaven-k7v9yq
PURPLE_DROP=wallhaven-k761p6

## Neo
ROBOT=robot
FLOWERS=wallhaven-mpo33m

# Fractal
BLACKBROWNWHITE=wallhaven-xld8rd
##############################

# Set screen layout based on monitor config
autorandr -c

# Random wallpaper from folder wp <folder>
# fish -c "wp pastel" &
# Select specific wallpaper with variables set above wps <folder> <name>
fish -c "wps fractal $BLACKBROWNWHITE" &

# NOTE: Actions for home setup
if [[ $MONITOR_COUNT -gt 1 ]]; then
	echo "$DATE - Detected home setup" >> ~/.scripts/display/startup.log
    xmodmap ~/.Xmodmap &
# NOTE: Actions for mobile setup
elif [[ $MONITOR_COUNT -eq 1 ]]; then
	echo "$DATE - Detected mobile setup" >> ~/.scripts/display/startup.log
fi
