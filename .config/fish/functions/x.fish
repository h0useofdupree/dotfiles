function x --description 'Starts X clean'
clear
colorscript -e 7
echo "Starting X-Server, $USER"
startx 2&>/dev/null
end
