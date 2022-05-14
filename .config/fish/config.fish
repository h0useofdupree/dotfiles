# Custom variables
set -U CURRENT_WALLPAPER (cat ~/.cache/wal/wal)
set CONNECTED_MONITORS (cat ~/.scripts/display/CONNECTED_MONITORS)
set EDITOR nvim
set BROWSER qutebrowser
set SHELL /bin/fish
set TERM_BACKGROUND 000000
set PYWAL_BACKEND 'wal'

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

# HACK: Execute commands based on current setup
# NOTE: This is only needed when a US-Keeb is used on a german-localized system and for umlauts
if [ $CONNECTED_MONITORS = 1 ] # Mobile Setup
    setxkbmap de # Sets keyboard layout to de if laptop is used on the go
# else if [ $CONNECTED_MONITORS > 1 ] # Home Setup
end
