function nvconf --description 'AstroNvim config helper'
    argparse 'h/help' 'u/user=?' 'core=?' 'c/config=?' 'g/git=?' -- $argv
    or return

    if set -q _flag_h
        printf "usage: nvconf [-h / --help] [-c / --config] [--core] [-u / --user] [-g / --git]"
        printf "\n\n\n"
        printf "options:\n\t-h / --help \t show this help message\n\n\t-c / --config \t cd and ls lua/config/\n\n\t--core \t\t cd and ls lua/core/ (Do not edit!)\n\n\t-g / --git \t Add, commit and push the userconfig /lua/user/*\n\n\t"
        echo "-u / --user      (=<config ID>) cd and ls lua/user/(<config ID>)"
    end

    if set -q _flag_c
        cd ~/.config/nvim/lua/configs/
        lt -L2 
    else if set -q _flag_core
        echo "!!!WARNING!!!"
        echo "DO NOT EDIT THESE FILES! CONTINUE AT YOUR OWN RISK."
        echo "Edited files will result in update compat failing."
        echo "Continue?"
        read answ
        if test $answ = 'y' -o $answ = 'Y'
            cd ~/.config/nvim/lua/core/ 
            lt -L2
        else
            exit 0
        end
    else if set -q _flag_u
        set -l path '~/.config/nvim/lua/user/'
        if [ $_flag_u = '1' ]
            nvim ~/.config/nvim/lua/user/init.lua
        end
    else 
        cd ~/.config/nvim/ 
        lt -L1 
    end
    
    # NOTE: Implement this function if possible
    # function moveIfNotThereYet
    #     set -l dir (pwd)
    #     if [ $dir = $path ]
    #         cd $path
    #         lt -L2
    #     end 
    # end
end
