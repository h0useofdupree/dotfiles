function __dynamic_wallpaper_times
    for h in (seq 0 23)
        for m in 0 15 30 45
            printf '%02d:%02d\n' $h $m
        end
    end
end


function __dynamic_wallpaper_groups
    echo -e Alps\t19 images 5120x2880
    echo -e AnimeCity\t96 images 5120x2880
    echo -e Atacama\t9 images 5120x3406
    echo -e Beach\t9 images 6016x6016
    echo -e Burnaby\t8 images 5120x2880
    echo -e Catalina\t9 images 6016x6016
    echo -e Colors\t23 images 5760x4096
    echo -e Dome\t2 images 6016x6016
    echo -e Earth\t16 images 5120x2880
    echo -e Exodus\t4 images 5120x2880
    echo -e Fletschhorn\t6 images 5174x3266
    echo -e Fuji\t7 images 5719x3720
    echo -e Hachioji\t13 images 6000x4000
    echo -e MinimalForest\t4 images 3840x2160
    echo -e Mojave\t16 images 5120x2880
    echo -e Monterey\t16 images 6048x3402
    echo -e Ocean\t2 images 4096x2621
    echo -e PangongTso\t5 images 5519x3104
    echo -e Plants\t3 images 3840x2160
    echo -e SillyWalker\t17 images 5120x2880
    echo -e Sur\t8 images 6016x6016
    echo -e TechFactory\t5 images 5120x2880
    echo -e Tropics\t18 images 5120x2880
    echo -e WaterHill\t2 images 4096x2621
    echo -e ZorinMountain\t5 images 5760x3600
end

complete -c dynamic-wallpaper -s g -l group -r -d 'Wallpaper group' -a '(__dynamic_wallpaper_groups)' -f
complete -c dynamic-wallpaper -s d -l dir -r -d 'Directory containing wallpapers' -a '(__fish_complete_directories)'
complete -c dynamic-wallpaper -l light -d 'Always use the lightest wallpaper'
complete -c dynamic-wallpaper -l auto-light -d 'Use the lightest wallpaper when GNOME is in light mode'
complete -c dynamic-wallpaper -l start -r -d 'Start time for the cycle (HH:MM)' -a '(__dynamic_wallpaper_times)' -f
complete -c dynamic-wallpaper -l end -r -d 'End time for the cycle (HH:MM)' -a '(__dynamic_wallpaper_times)' -f
complete -c dynamic-wallpaper -l time -r -d 'Use fake current time (HH:MM)' -a '(__dynamic_wallpaper_times)' -f
complete -c dynamic-wallpaper -l shuffle-mode -r -d 'Shuffle behavior for shuffle_ groups' -a 'random fixed' -f
complete -c dynamic-wallpaper -l image -r -d 'Image when --shuffle-mode fixed' -a '(__fish_complete_files)'
complete -c dynamic-wallpaper -s l -l log -r -d 'Write log output to FILE' -a '(__fish_complete_files)'
complete -c dynamic-wallpaper -s h -l help -d 'Show help text'
