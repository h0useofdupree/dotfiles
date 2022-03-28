function wp --description 'Sets random wallpaper, applies colors with wal (colorz) and renders wallpaper for lockscreen'
    pywalhue -i /usr/share/wallpapers/neo/ --backend colorz -b $TERM_BACKGROUND 2&>/dev/null
    set CURRENT_WALLPAPER (cat ~/.cache/wal/wal)
    qtile_restart
    fish
    clear
    colorscript -e 7
    if [ (dunstctl is-paused) = "true" ]
        restart_dunst &
        dunstctl set-paused true
    else
        restart_dunst &
    end
    lockrender &
end
