# -*- coding: utf-8 -*-
import json
import os
import re
import socket
import subprocess
from typing import List  # noqa: F401from typing import List  # noqa: F401

from libqtile import bar, hook, layout, qtile, widget
from libqtile.command import lazy
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen
from libqtile.dgroups import simple_key_binder
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

mod = "mod1"  # Sets mod key to SUPER/WINDOWS
alt_mod = "mod4"
term = "alacritty"  # My terminal of choice
browser = "brave"

keys = [
    ### The essentials
    Key([mod], "Return", lazy.spawn(term), desc='Launches My Terminal'),
    Key([mod], "b", lazy.spawn(browser), desc=browser),
    Key([mod], "Tab", lazy.next_layout(), desc='Toggle through layouts'),
    Key([mod, "shift"], "q", lazy.window.kill(), desc='Kill active window'),
    Key([mod, "shift"], "r", lazy.reload_config(), desc='Restart Qtile'),
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
    ## Misc
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume 49 -5%")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume 49 +5%")),
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute 49 toggle")),
    Key([], "XF86MonBrightnessUp", lazy.spawn("xbacklight -inc 10")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("xbacklight -dec 10")),
    Key([alt_mod], "l", lazy.spawn("i3lock-fancy-dualmonitor")),
    Key([alt_mod, "shift"], "l", lazy.spawn("fish -c 'sus'")),
    Key([alt_mod, "shift"], "s", lazy.spawn("fish -c 'speakers on'")),
    Key([alt_mod, "shift", "control"], "s",
        lazy.spawn("fish -c 'speakers off'")),
    ## Programs
    Key([mod], "s", lazy.spawn("rofi -show run")),
    Key([mod], "e", lazy.spawn("rofi -show emoji -modi emoji -theme arthur")),
    Key([mod], "a", lazy.spawn("rofi -show calc -modi calc -theme arthur")),
    ## huepywal
    KeyChord([mod], "c", [
        KeyChord([], "r", [
            Key([], "n", lazy.spawn("huepywal -r -l -n"),
                lazy.spawn("fish -c qtile_reload")),
            Key([], "m", lazy.spawn("huepywal -r -l -m"),
                lazy.spawn("fish -c qtile_reload")),
            Key([], "o", lazy.spawn("huepywal -r -l -o"),
                lazy.spawn("fish -c qtile_reload"))
        ]),
        KeyChord([], "s", [
            Key([], "1", lazy.spawn("huepywal -s 0003 -l -n"),
                lazy.spawn("fish -c qtile_reload")),
            Key([], "2", lazy.spawn("huepywal -s 0002 -l -m"),
                lazy.spawn("fish -c qtile_reload")),
            Key([], "3", lazy.spawn("huepywal -s 0004 -l -n"),
                lazy.spawn("fish -c qtile_reload")),
            Key([], "4", lazy.spawn("huepywal -s 0006 -l -n"),
                lazy.spawn("fish -c qtile_reload")),
            Key([], "5", lazy.spawn("huepywal -s 0008 -l -n"),
                lazy.spawn("fish -c qtile_reload")),
            Key([], "6", lazy.spawn("huepywal -s 0010 -l -n"),
                lazy.spawn("fish -c qtile_reload")),
            Key([], "7", lazy.spawn("huepywal -s 0014 -l -n"),
                lazy.spawn("fish -c qtile_reload")),
            Key([], "8", lazy.spawn("huepywal -s 0018 -l -n"),
                lazy.spawn("fish -c qtile_reload")),
            Key([], "9", lazy.spawn("huepywal -s 0017 -l -n"),
                lazy.spawn("fish -c qtile_reload")),
        ])
    ]),
    Key([mod], "t", lazy.spawn("todoist"))
]

#Pywal Colors
colors_json = os.path.expanduser('~/.cache/wal/colors.json')
colordict = json.load(open(colors_json))

groups = [
    Group("DEV", layout='monadtall'),
    Group("WWW", layout='monadtall'),
    Group("TRM", layout='monadtall'),
    Group("SYS", layout='monadtall'),
    Group("DOC", layout='monadtall'),
    Group("VBOX", layout='monadtall'),
    Group("CHAT", layout='monadtall'),
    Group("VID", layout='monadtall'),
    Group("MUS", layout='monadtall'),
    Group("VIS", layout='floating')
]

dgroups_key_binder = simple_key_binder("mod1")

layout_theme = {
    "border_width": 1,
    "margin": 15,
    "border_focus": colordict['colors']['color2'],
    "border_normal": colordict['colors']['color0']
}

layouts = [
    #layout.MonadWide(**layout_theme),
    # layout.Bsp(**layout_theme),
    #layout.Stack(stacks=2, **layout_theme),
    #layout.RatioTile(**layout_theme),
    # layout.Tile(shift_windows=True, **layout_theme),
    #layout.VerticalTile(**layout_theme),
    # layout.Matrix(**layout_theme),
    # layout.Zoomy(**layout_theme),
    # layout.Columns(**layout_theme),
    layout.MonadTall(**layout_theme),
    # layout.Max(**layout_theme),
    # layout.Stack(num_stacks=2),
    layout.RatioTile(**layout_theme),
    # layout.TreeTab(
    # font = "Ubuntu Mono",
    # fontsize = 10,
    # sections = ["FIRST", "SECOND", "THIRD", "FOURTH"],
    # section_fontsize = 10,
    # border_width = 2,
    # bg_color = "1c1f24",
    # active_bg = "c678dd",
    # active_fg = "000000",
    # inactive_bg = "a9a1e1",
    # inactive_fg = "1c1f24",
    # padding_left = 0,
    # padding_x = 0,
    # padding_y = 5,
    # section_top = 10,
    # section_bottom = 20,
    # level_shift = 8,
    # vspace = 3,
    # panel_width = 200
    # ),
    layout.Floating(**layout_theme)
]

# prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

##### DEFAULT WIDGET SETTINGS #####
widget_defaults = dict(font="Ubuntu Mono",
                       fontsize=14,
                       padding=3,
                       background=colordict['colors']['color2'],
                       foreground='#FFFFFF')
extension_defaults = widget_defaults.copy()


def init_widgets_list():
    this_widgets_list = [
        widget.Sep(linewidth=0,
                   padding=9,
                   foreground='#FFFFFF',
                   background=colordict['colors']['color0']),
        # widget.Image(
        # filename="~/.config/qtile/icons/python-white.png",
        # scale="False",
        # mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(term)}),
        widget.Sep(linewidth=0,
                   padding=9,
                   foreground='#FFFFFF',
                   background=colordict['colors']['color0']),
        widget.GroupBox(
            font="Ubuntu Mono Bold",
            fontsize=13,
            margin_y=3,
            margin_x=0,
            padding_y=5,
            padding_x=3,
            borderwidth=3,
            active=colordict['colors']['color1'],
            # active=colordict['colors']['color1''],
            inactive=colordict['colors']['color7'],
            rounded=True,
            highlight_color='#0f0f0f',
            highlight_method="line",
            this_current_screen_border=colordict['colors']['color6'],
            this_screen_border=colordict['colors']['color4'],
            other_current_screen_border=colordict['colors']['color6'],
            other_screen_border=colordict['colors']['color4'],
            foreground='#FFFFFF',
            background=colordict['colors']['color0']),
        widget.TextBox(text='|',
                       font="Ubuntu Mono",
                       background=colordict['colors']['color0'],
                       foreground='474747',
                       padding=2,
                       fontsize=14),
        widget.CurrentLayoutIcon(
            custom_icon_paths=[os.path.expanduser("~/.config/qtile/icons")],
            foreground='#FFFFFF',
            background=colordict['colors']['color0'],
            padding=0,
            scale=0.7),
        widget.CurrentLayout(foreground='#FFFFFF',
                             background=colordict['colors']['color0'],
                             padding=0),
        widget.TextBox(text='|',
                       font="Ubuntu Mono",
                       background=colordict['colors']['color0'],
                       foreground='474747',
                       padding=2,
                       fontsize=14),
        widget.WindowName(foreground='#FFFFFF',
                          background=colordict['colors']['color0'],
                          padding=0),
        widget.TextBox(text=' ',
                       font="Ubuntu Mono",
                       background=colordict['colors']['color0'],
                       foreground=colordict['colors']['color2'],
                       padding=0,
                       fontsize=45),
        widget.Systray(background=colordict['colors']['color2'], padding=0),
        widget.TextBox(text=' ',
                       font="Ubuntu Mono",
                       background=colordict['colors']['color2'],
                       foreground=colordict['colors']['color3'],
                       padding=0,
                       fontsize=45),
        widget.Battery(background=colordict['colors']['color3'],
                       foreground='#000000',
                       battery=0),
        widget.TextBox(text=' ',
                       font="Ubuntu Mono",
                       background=colordict['colors']['color3'],
                       foreground=colordict['colors']['color4'],
                       padding=0,
                       fontsize=45),
        widget.ThermalSensor(foreground='#000000',
                             background=colordict['colors']['color4'],
                             threshold=90,
                             fmt='🌡️ {}',
                             padding=2),
        widget.TextBox(text=' ',
                       font="Ubuntu Mono",
                       background=colordict['colors']['color4'],
                       foreground=colordict['colors']['color5'],
                       padding=0,
                       fontsize=45),
        widget.CheckUpdates(update_interval=1800,
                            distro="Arch_checkupdates",
                            display_format="⬆ {updates} ",
                            foreground='#000000',
                            colour_have_updates='#000000',
                            colour_no_updates='#000000',
                            mouse_callbacks={
                                'Button1':
                                lambda: qtile.cmd_spawn(
                                    term + ' -e sudo pacman -Syu --noconfirm')
                            },
                            padding=0,
                            background=colordict['colors']['color5']),
        widget.TextBox(text=' ',
                       font="Ubuntu Mono",
                       background=colordict['colors']['color5'],
                       foreground=colordict['colors']['color6'],
                       padding=0,
                       fontsize=45),
        widget.Memory(foreground='#000000',
                      background=colordict['colors']['color6'],
                      mouse_callbacks={
                          'Button1': lambda: qtile.cmd_spawn(term + ' -e htop')
                      },
                      fmt='🧮 {}',
                      padding=0),
        # widget.TextBox(text=' ',
                       # font="Ubuntu Mono",
                       # background=colordict['colors']['color6'],
                       # foreground=colordict['colors']['color7'],
                       # padding=0,
                       # fontsize=45),
        # widget.PulseVolume(foreground='#000000',
                           # background=colordict['colors']['color7'],
                           # fmt='🔉 {}',
                           # padding=0),
        widget.TextBox(text=' ',
                       font="Ubuntu Mono",
                       background=colordict['colors']['color6'],
                       foreground=colordict['colors']['color8'],
                       padding=0,
                       fontsize=45),
        widget.KeyboardLayout(foreground='#000000',
                              background=colordict['colors']['color8'],
                              fmt='⌨️ {}',
                              padding=0),
        widget.TextBox(text=' ',
                       font="Ubuntu Mono",
                       background=colordict['colors']['color8'],
                       foreground=colordict['colors']['color9'],
                       padding=0,
                       fontsize=45),
        widget.Clock(foreground='#000000',
                     background=colordict['colors']['color9'],
                     format="%A, %B %d - %H:%M "),
    ]
    return this_widgets_list


def init_widgets_screen1():
    this_widgets_screen1 = init_widgets_list()
    return this_widgets_screen1


def init_widgets_screen2():
    this_widgets_screen2 = init_widgets_list()
    # Remove systray widget due to limit of 1 tray
    # this_widgets_screen2[9] = widget.Net(format="↓{down}↑{up}", max_chars=16)
    this_widgets_screen2[9] = widget.NetGraph(
        border_color=colordict['colors']['color9'],
        border_width=1,
        fill_color=colordict['colors']['color8'],
        graph_color=colordict['colors']['color7'])
    return this_widgets_screen2


def init_screens():
    return [
        Screen(
            top=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=25)),
        Screen(
            top=bar.Bar(widgets=init_widgets_screen2(), opacity=1.0, size=25))
    ]


if __name__ in ["config", "__main__"]:
    screens = init_screens()
    widgets_list = init_widgets_list()
    widgets_screen1 = init_widgets_screen1()
    widgets_screen2 = init_widgets_screen2()


def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)


def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)


def window_to_previous_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group)


def window_to_next_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group)


def switch_screens(qtile):
    i = qtile.screens.index(qtile.current_screen)
    group = qtile.screens[i - 1].group
    qtile.current_screen.set_group(group)


mouse = [
    Drag([mod],
         "Button1",
         lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod],
         "Button3",
         lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = True

floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    # default_float_rules include: utility, notification, toolbar, splash, dialog,
    # file_progress, confirm, download and error.
    *layout.Floating.default_float_rules,
    Match(title='Confirmation'),  # tastyworks exit box
    Match(title='Qalculate!'),  # qalculate-gtk
    Match(wm_class='kdenlive'),  # kdenlive
    Match(wm_class='pinentry-gtk-2'),  # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True


@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])


wmname = "LG3D"
