function x --description 'Starts X clean'
    echo "Starting X-Server"
    clear
    colorscript -e 7
    pipes &
    startx 2&>/dev/null
end
