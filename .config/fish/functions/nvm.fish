function nvm --wraps=nvim --description 'open nvim with a markdown file and convert it to pdf after closing'
    
    cp $argv T$argv
    nvim T$argv

    #NOTE: Currently, the file won't be converted if it has not been edited by this script the first time. So currently you need to edit a file once, to convert it
    
    if test -z (diff -q $argv T$argv)
        echo 'No changes made, not converting.'
        mv T$argv $argv
    else if test -z (diff -q $argv $HOME/Documents/defaults/Markdown/default.md)
    else 
        echo Changes were made, compiling now, $USER.
        mv T$argv $argv
        md2pdf $argv
    end
end
