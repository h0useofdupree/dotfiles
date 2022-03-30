function restart_dunst
  if pgrep -l dunst 2&>/dev/null
    killall dunst
  end
  launch_dunst
  set -l current_wallpaper (cat .cache/wal/wal | cut -d "/" -f6 | cut -f1 -d ".")
  notify-send "Current Wallpaper" "$current_wallpaper"
end
