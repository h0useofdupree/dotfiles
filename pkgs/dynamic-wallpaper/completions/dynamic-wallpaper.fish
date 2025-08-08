function __dynamic_wallpaper_times
    for h in (seq 0 23)
        for m in 0 15 30 45
            printf '%02d:%02d\n' $h $m
        end
    end
end

complete -c dynamic-wallpaper -s d -l dir -r -d 'Directory containing wallpapers' -a '(__fish_complete_directories)'
complete -c dynamic-wallpaper -l light -d 'Always use the lightest wallpaper'
complete -c dynamic-wallpaper -l auto-light -d 'Use the lightest wallpaper when GNOME is in light mode'
complete -c dynamic-wallpaper -l start -r -d 'Start time for the cycle (HH:MM)' -a '(__dynamic_wallpaper_times)'
complete -c dynamic-wallpaper -l end -r -d 'End time for the cycle (HH:MM)' -a '(__dynamic_wallpaper_times)'
complete -c dynamic-wallpaper -l time -r -d 'Use fake current time (HH:MM)' -a '(__dynamic_wallpaper_times)'
complete -c dynamic-wallpaper -s l -l log -r -d 'Write log output to FILE' -a '(__fish_complete_files)'
complete -c dynamic-wallpaper -s h -l help -d 'Show help text'
