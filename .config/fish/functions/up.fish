function up --wraps=pacman --description 'Simple shorthand for updating everything and closing terminal'
    colorscript -e 7
    echo
    sudo pacman -Syu --noconfirm
    echo "Done."
    qtile_reload &
end
