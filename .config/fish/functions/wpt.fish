function wpt --description 'Sets premade themes instead of single wallpapers.'
    argparse 'h/help' 't/theme=?' -- $argv
    or return
    
    if set -q _flag_h
        printf "usage: wpt [-h / --help] [-t[theme] / --theme=[theme]]"
        printf "\n\n\n"
        printf "options:\n\t-h / --help \t show this help message\n\t-t / --theme \t set theme to use"
    end
    if set -q _flag_t
        set -l color_src $_flag_t-1.jpg
        set -l secondary_image $_flag_t-2.jpg
        
        pywalhue -i /usr/share/wallpapers/themes/$_flag_t/$color_src --backend $PYWAL_BACKEND -b $TERM_BACKGROUND -n # 2&>/dev/null
        set CURRENT_WALLPAPER (cat ~/.cache/wal/wal) &
        
        nitrogen --head=0 --set-centered /usr/share/wallpapers/themes/$_flag_t/$color_src 
        nitrogen --head=1 --set-centered /usr/share/wallpapers/themes/$_flag_t/$secondary_image

        qtile_restart
        
        if [ (dunstctl is-paused) = "true" ]
            restart_dunst &
            dunstctl set-paused true
        else
            restart_dunst &
        end
            
        lockrender &
    end
end
