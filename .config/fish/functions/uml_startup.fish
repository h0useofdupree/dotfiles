function uml_startup --description 'Temp fix for autostarting xmodmap - whick fucking sucks for whatever reason!'
    sleep 20
    xmodmap "$HOME/.Xmodmap" &
    echo "FEKING HELL MATE" > "$HOME/.scripts/xmodmap_curses.fucking.log"
end
