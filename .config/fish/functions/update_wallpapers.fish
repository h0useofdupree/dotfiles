function update_wallpapers --description 'Move all downloaded wallpapers to folder given in argument. Default is /usr/share/wallapapers/*'
    set -l walls (ls ~/Walls/ | awk {'print $8'} | cut -f1 -d '.')
    sudo mv ~/Walls/*.* /usr/share/wallpapers/$argv
    echo "Moved following wallpapers to /usr/share/wallpapers/$argv :"
    echo
    echo $walls
end
