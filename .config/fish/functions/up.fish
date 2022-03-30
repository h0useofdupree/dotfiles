function up --wraps=pacman --description 'Simple shorthand for updating everything and closing xterm-kitty'
    colorscript -e 7
    echo
    sudo pacman -Syu --noconfirm $argv
    echo "Done."
    qtile_reload &
    exit
end
