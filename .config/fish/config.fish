# Custom variables
set EDITOR nvim
set BROWSER qutebrowser
set SHELL /bin/fish
set TERM_BACKGROUND 000000
set PYWAL_BACKEND 'wal'
# set ACTIVE_MONITORS (xrandr --listactivemonitors | grep "Monitors: " | awk '{print $2}')
set CONNECTED_MONITORS (xrandr -q | grep -c " connected")
set -U CURRENT_WALLPAPER (cat ~/.cache/wal/wal)
# set ACTIVE_SINK (pactl list short sinks | grep RUNNING | awk {'print $1'})

## Export Variables to .env 
echo -e "PATH=$PATH:~/.config/rofi/bin" > ~/.env
export (cat ~/.env)

if status is-interactive
    # function fish_prompt
    #     powerline-shell --shell bare $status
    # end
    source ("/usr/bin/starship" init fish --print-full-init | psub)
    # source (~/Git/pureline/pureline ~/.pureline.conf)
    cat ~/.cache/wal/sequences
    paleofetch
end

# NOTE: Execute commands based on current setup
if [ $CONNECTED_MONITORS = 1 ] # Mobile Setup
    setxkbmap de
# else if [ $CONNECTED_MONITORS > 1 ] # Home Setup
end
