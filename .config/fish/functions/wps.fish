function wps
    pywalhue -i /usr/share/wallpapers/$argv[1]/$argv[2].* --backend $PYWAL_BACKEND -b $TERM_BACKGROUND 2&>/dev/null
    set CURRENT_WALLPAPER (cat ~/.cache/wal/wal)
    
    qtile_restart
    
    if [ (dunstctl is-paused) = "true" ]
        restart_dunst &
        dunstctl set-paused true
    else
        restart_dunst &
    end
        
    lockrender &

    # HACK: This is only done in wp / wps while there is not other way to get the current monitor count in a short time critical way. 
    # NOTE: Only important if new monitors are plugged in and the laptop is not relogged in.
    
    set -u MONITOR_COUNT (xrandr -q | grep -c " connected") 2&>/dev/null &
    echo $MONITOR_COUNT > ~/.scripts/display/CONNECTED_MONITORS 
end
