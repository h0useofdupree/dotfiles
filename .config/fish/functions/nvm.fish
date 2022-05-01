function nvm --wraps=nvim --description 'open nvim with a markdown file and convert it to pdf after closing'
    set -l usrnm $USER
    cp $argv T$argv
    nvim T$argv
    if test -z (diff -q $argv T$argv)
        echo 'No changes made, not converting.'
        mv T$argv $argv
    else 
        echo Changes were made, compiling now, $USER.
        mv T$argv $argv
        md2pdf $argv
    end
end
