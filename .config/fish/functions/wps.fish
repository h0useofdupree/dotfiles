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
end
