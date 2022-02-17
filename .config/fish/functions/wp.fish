function wp
    pywalhue -i /usr/share/wallpapers/neo/ --backend colorz 2&>/dev/null
    qtile_reload
    clear
    colorscript -e 7
end
