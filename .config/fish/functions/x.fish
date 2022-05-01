function x --description 'Starts X clean'
    argparse 'spk/speakers' 'up/update' 'md/note' -- $argv
    or return
    # TODO: Per Parameter von Fkt. Argumente für:
    # NOTE: 'startx'-Helperscript - Nimmt Argumente für opt. Startup Einstellungen. Startet am Ende X.
    
    echo "Starting X-Server"
    clear
    colorscript -e 7
    startx 2&>~/.scripts/xorg-startup.log
end
