# -*- coding: utf-8 -*-
'''
Keybindings for Qtile
'''
from libqtile.command import lazy
from libqtile.config import Key
from libqtile.lazy import lazy


mod = "mod1"  # Sets mod key to SUPER/WINDOWS
alt_mod = "mod4"
term = "kitty"  # My terminal of choice
browser = "qutebrowser"
wp_folder = "pastel"

def getKeys():
    keys = [
        ### The essentials
        Key([mod], "Return", lazy.spawn(term), desc=f'Launches {term}'),
        Key([mod], "b", lazy.spawn(browser), desc=f'Launches {browser}'),
        Key([mod], "Tab", lazy.next_layout(), desc='Toggle through layouts'),
        Key([mod, "shift"], "q", lazy.window.kill(), desc='Kill active window'),
        Key([mod, "shift"], "r", lazy.restart(), desc='Restart Qtile'),
        Key([mod, "shift"], "c", lazy.shutdown(), desc='Shutdown Qtile'),
        ### Switch focus of monitors
        Key([mod], "period", lazy.next_screen(),
            desc='Move focus to next monitor'),
        Key([mod], "comma", lazy.prev_screen(), desc='Move focus to prev monitor'),
        ### Treetab controls
        Key([mod, "shift"],
            "h",
            lazy.layout.move_left(),
            desc='Move up a section in treetab'),
        Key([mod, "shift"],
            "l",
            lazy.layout.move_right(),
            desc='Move down a section in treetab'),
        ### Window controls
        Key([mod],
            "j",
            lazy.layout.down(),
            desc='Move focus down in current stack pane'),
        Key([mod],
            "k",
            lazy.layout.up(),
            desc='Move focus up in current stack pane'),
        Key([mod, "shift"],
            "j",
            lazy.layout.shuffle_down(),
            lazy.layout.section_down(),
            desc='Move windows down in current stack'),
        Key([mod, "shift"],
            "k",
            lazy.layout.shuffle_up(),
            lazy.layout.section_up(),
            desc='Move windows up in current stack'),
        Key([mod],
            "h",
            lazy.layout.left(),
            desc='Move focus left in current stack'),
        Key([mod],
            "l",
            lazy.layout.right(),
            desc='Move focus right in current stack'),
        Key([mod, "shift"],
            "h",
            lazy.layout.shuffle_left(),
            lazy.layout.section_left(),
            desc='Move window left in current stack'),
        Key([mod, "shift"],
            "l",
            lazy.layout.shuffle_right(),
            lazy.layout.section_right(),
            desc='Move window right in current stack'),
        Key([alt_mod],
            "j",
            lazy.layout.grow_left(),
            lazy.layout.increase_nmaster(),
            lazy.layout.grow(),
            desc='Shrink window (MonadTall), decrease number in master pane (Tile)'
            ),
        Key([alt_mod],
            "k",
            lazy.layout.grow_right(),
            lazy.layout.decrease_nmaster(),
            lazy.layout.shrink(),
            desc='Expand window (MonadTall), increase number in master pane (Tile)'
            ),
        Key([mod],
            "n",
            lazy.layout.normalize(),
            desc='normalize window size ratios'),
        Key([mod],
            "m",
            lazy.layout.maximize(),
            desc='toggle window between minimum and maximum sizes'),
        Key([mod, "shift"],
            "f",
            lazy.window.toggle_floating(),
            desc='toggle floating'),
        Key([mod], "f", lazy.window.toggle_fullscreen(), desc='toggle fullscreen'),
        #Key([mod, "shift"], ".", lazy.window_to_next_screen()),
        #Key([mod, "shift"], ",", lazy.window_to_previous_screen()),
        ### Stack controls
        Key([mod, "shift"],
            "Tab",
            lazy.layout.rotate(),
            lazy.layout.flip(),
            desc='Switch which side main pane occupies (XmonadTall)'),
        Key([mod],
            "space",
            lazy.layout.next(),
            desc='Switch window focus to other pane(s) of stack'),
        Key([mod, "shift"],
            "space",
            lazy.layout.toggle_split(),
            desc='Toggle between split and unsplit sides of stack'),

        # Fn-Keys
        Key([], "XF86AudioLowerVolume", lazy.spawn("amixer sset -M Master 1%-")),
        Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer sset -M Master 1%+")),
        Key([], "XF86AudioMute", lazy.spawn("amixer set -M Master toggle")),
        Key([], "XF86MonBrightnessUp", lazy.spawn("xbacklight -inc 10")),
        Key([], "XF86MonBrightnessDown", lazy.spawn("xbacklight -dec 10")),
        Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
        Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
        Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
        Key([alt_mod], "e", lazy.spawn("fish -c 'uml'")),

        # Lock / Suspend
        Key([alt_mod], "l", lazy.spawn("betterlockscreen -l dim")),
        Key([alt_mod, "shift"], "l", lazy.spawn("systemctl suspend")),

        # Smart Home
        Key([alt_mod, "shift"], "s", lazy.spawn("fish -c 'speakers on'")),
        Key([alt_mod, "shift", "control"], "s",
            lazy.spawn("fish -c 'speakers off'")),

        ## Rofi: Launcher / Calculator / Emoji
        Key([mod], "s", lazy.spawn("fish -c 'rofi_ribbon'")),
        Key([mod], "e", lazy.spawn("rofi -show emoji -modi emoji -theme ~/.config/rofi/launchers/colorful/style_2.rasi")),
        Key([mod], "a", lazy.spawn("rofi -show calc -modi calc -theme ~/.config/rofi/powermenu/message.rasi")),

        # ## huepywal
        # KeyChord([mod], "c", [
        #     KeyChord([], "r", [
        #         Key([], "n", lazy.spawn("huepywal -r -l -n"),
        #             lazy.spawn("fish -c qtile_reload")),
        #         Key([], "m", lazy.spawn("huepywal -r -l -m"),
        #             lazy.spawn("fish -c qtile_reload")),
        #         Key([], "o", lazy.spawn("huepywal -r -l -o"),
        #             lazy.spawn("fish -c qtile_reload"))
        #     ]),
        #     KeyChord([], "s", [
        #         Key([], "1", lazy.spawn("huepywal -s 0003 -l -n"),
        #             lazy.spawn("fish -c qtile_reload")),
        #         Key([], "2", lazy.spawn("huepywal -s 0002 -l -m"),
        #             lazy.spawn("fish -c qtile_reload")),
        #         Key([], "3", lazy.spawn("huepywal -s 0004 -l -n"),
        #             lazy.spawn("fish -c qtile_reload")),
        #         Key([], "4", lazy.spawn("huepywal -s 0006 -l -n"),
        #             lazy.spawn("fish -c qtile_reload")),
        #         Key([], "5", lazy.spawn("huepywal -s 0008 -l -n"),
        #             lazy.spawn("fish -c qtile_reload")),
        #         Key([], "6", lazy.spawn("huepywal -s 0010 -l -n"),
        #             lazy.spawn("fish -c qtile_reload")),
        #         Key([], "7", lazy.spawn("huepywal -s 0014 -l -n"),
        #             lazy.spawn("fish -c qtile_reload")),
        #         Key([], "8", lazy.spawn("huepywal -s 0018 -l -n"),
        #             lazy.spawn("fish -c qtile_reload")),
        #         Key([], "9", lazy.spawn("huepywal -s 0017 -l -n"),
        #             lazy.spawn("fish -c qtile_reload")),
        #     ])
        # ]),
        # Temp Wallpaper Changer
        Key([mod, "shift"], "w", lazy.spawn(f"fish -c 'wp {wp_folder}'")),
        Key([mod], "t", lazy.spawn("todoist"))
    ]
    return keys
keys = getKeys
