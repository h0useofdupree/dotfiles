function clr
    # Parse arguments
    argparse r/random s/select f/folder -- $argv
    or exit 1
    # Path to Wallpapers
    set pathToWallpapers "/usr/share/wallpapers"

    function setFolder
        if $_flag_folder
            switch $flag_folder
                case 'n'
                    set fol 'neo/'
                    return
                case 'm'
                    set fol 'maller/'
                    return
                case 'o'
                    set fol ''
                    return
            end
        else
            set fol 'neo/'
        end
    end

    function setImage
        if $_flag_select
            set img '$_flag_s.jpg'
        end
    end
    
    function setSelector
        if $_flag_random
            set path "$pathToWallpapers/$fol"
        else if $_flag_select
            set path "$pathToWallpapers/$fol$img"
        else
            set path "$pathToWallpapers/$fol"
        end
    end

    setFolder
    setImage
    setSelector

    pywalhue -i $path
end
