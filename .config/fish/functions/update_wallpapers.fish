function update_wallpapers --description 'Move all downloaded wallpapers to folder given in argument. Default ist /usr/share/wallapapers/*'
    sudo mv ~/Walls/*.* /usr/share/wallpapers/$argv
    echo "Moved following wallpapers to /usr/share/wallpapers/$argv"
    ls /usr/share/wallpapers/$argv
end
