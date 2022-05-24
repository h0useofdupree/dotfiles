function md
    argparse 'd/dir=?' 'h/help' -- $argv
    or return
    
    if set -q _flag_h 
        printf '\nmd will create a Markdown File with the given preset in ~/Documents/defaults/Markdown/default.md. Optionally the parametere d/dir can be used to create a dir with the name of the file and cd into it.'
    end
    if set -q _flag_d
        # Create folder for file and cd into it if flag is given
        mkdir $argv
        cd $argv
    end
    cp ~/Documents/defaults/Markdown/default.md ./$argv.md
end
