function wp --description 'Sets random wallpaper, applies colors with wal (colorz) and renders wallpaper for lockscreen'
    pywalhue -n -i /usr/share/wallpapers/$argv/ --backend $PYWAL_BACKEND -b $TERM_BACKGROUND 2&>/dev/null
    set CURRENT_WALLPAPER (cat ~/.cache/wal/wal)
    
    feh --bg-fill $CURRENT_WALLPAPER
    echo 'Test'
    
    # Restart to apply colors rendered by pywal
    # sleep 2
    qtile_restart
    
    # Check if Do Not Disturb was turned on
    if [ (dunstctl is-paused) = "true" ]
        restart_dunst &
        dunstctl set-paused true
    else
        restart_dunst &
    end
        
    # Render lockscreen for 'betterlockscreen'
    lockrender &
end
