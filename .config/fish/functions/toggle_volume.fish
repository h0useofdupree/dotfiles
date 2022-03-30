function toggle_volume
pactl set-sink-mute $ACTIVE_SINK toggle
end
