function dnd --description 'Toggles Dunst Do Not Disturb'
    if [ (dunstctl is-paused) = "true" ]
        dunstctl set-paused false
        notify-send "Dunst" "turned DnD off"
    else
        notify-send "Dunst" "turned DnD on"
        sleep 3
        dunstctl set-paused true
    end
end
