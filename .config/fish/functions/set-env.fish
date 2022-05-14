function set-env --description 'Sets all Fish-Only Env Variables'
    # This function will set all env variables for scripts and stuff inside the fish shell 
    # This is done in an attempt to improve shell startup speed.

    set --path EDITOR nvim
    set --path BROWSER qutebrowser
    set --path SHELL /bin/fish
    set --path TERM_BACKGROUND 000000
    set --path PYWAL_BACKEND 'wal'
    # set ACTIVE_MONITORS (xrandr --listactivemonitors | grep "Monitors: " | awk '{print $2}')
    # set ACTIVE_SINK (pactl list short sinks | grep RUNNING | awk {'print $1'})
end
