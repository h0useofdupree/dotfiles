function update_wallpapers --description 'Move all downloaded wallpapers to folder given in argument. Default is /usr/share/wallapapers/*'
    set -l walls (ls ~/Walls/ | awk {'print $8'} | cut -f1 -d '.')
    
    # Check wether the mentionend folder exists or not
    if not test -e /usr/share/wallpapers/$argv
        # Create the folder
        sudo mkdir /usr/share/wallpapers/$argv 
    end 
    set -l folder /usr/share/wallpapers/$argv
    # Move wallpapers to the desired location
    sudo mv ~/Walls/*.* $folder
    echo "Moved following wallpapers to $folder :"
    echo
    echo $walls
end
