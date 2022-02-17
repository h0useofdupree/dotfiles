'''
This is my QTile Configuration based on DTs config. Twas outdated and I was just too sleep deprived to build yet another config file. So here I am, at 3 AM. Still in pain, nothing in brain.
'''
# -*- coding: utf-8 -*-
import os
import socket
import subprocess
import json
from typing import List  # noqa: F401
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile import layout, bar, widget, hook
from libqtile.lazy import lazy
from libqtile.dgroups import simple_key_binder
from libqtile.command import lazy
from libqtile import qtile


mod = "mod1"              # Sets mod key to SUPER/WINDOWS
alt_mod = "mod4"
term = "alacritty"      # My terminal of choice
browser = "brave"



keys = [
         ### The essentials
         Key([mod], "Return",
             lazy.spawn(term),
             desc='Launches My Terminal'
             ),
         Key([mod], "b",
             lazy.spawn(browser),
             desc=browser
             ),
         Key([mod], "Tab",
             lazy.next_layout(),
             desc='Toggle through layouts'
             ),
         Key([mod, "shift"], "q",
             lazy.window.kill(),
             desc='Kill active window'
             ),
         Key([mod, "shift"], "r",
             lazy.restart(),
             desc='Restart Qtile'
             ),
         Key([mod, "shift"], "c",
             lazy.shutdown(),
             desc='Shutdown Qtile'
             ),
         ### Switch focus of monitors
         Key([mod], "period",
             lazy.next_screen(),
             desc='Move focus to next monitor'
             ),
         Key([mod], "comma",
             lazy.prev_screen(),
             desc='Move focus to prev monitor'
             ),
         ### Treetab controls
          Key([mod, "shift"], "h",
             lazy.layout.move_left(),
             desc='Move up a section in treetab'
             ),
         Key([mod, "shift"], "l",
             lazy.layout.move_right(),
             desc='Move down a section in treetab'
             ),
         ### Window controls
         Key([mod], "j",
             lazy.layout.down(),
             desc='Move focus down in current stack pane'
             ),
         Key([mod], "k",
             lazy.layout.up(),
             desc='Move focus up in current stack pane'
             ),
         Key([mod, "shift"], "j",
             lazy.layout.shuffle_down(),
             lazy.layout.section_down(),
             desc='Move windows down in current stack'
             ),
         Key([mod, "shift"], "k",
             lazy.layout.shuffle_up(),
             lazy.layout.section_up(),
             desc='Move windows up in current stack'
             ),
         Key([mod], "h",
             lazy.layout.left(),
             desc='Move focus left in current stack'
             ),
         Key([mod], "l",
             lazy.layout.right(),
             desc='Move focus right in current stack'
             ),
         Key([mod, "shift"], "h",
             lazy.layout.shuffle_left(),
             lazy.layout.section_left(),
             desc='Move window left in current stack'
             ),
         Key([mod, "shift"], "l",
             lazy.layout.shuffle_right(),
             lazy.layout.section_right(),
             desc='Move window right in current stack'
             ),
         Key([alt_mod], "j",
             lazy.layout.grow_left(),
             lazy.layout.increase_nmaster(),
             lazy.layout.grow(),
             desc='Shrink window (MonadTall), decrease number in master pane (Tile)'
             ),
         Key([alt_mod], "k",
             lazy.layout.grow_right(),
             lazy.layout.decrease_nmaster(),
             lazy.layout.shrink(),
             desc='Expand window (MonadTall), increase number in master pane (Tile)'
             ),
         Key([mod], "n",
             lazy.layout.normalize(),
             desc='normalize window size ratios'
             ),
         Key([mod], "m",
             lazy.layout.maximize(),
             desc='toggle window between minimum and maximum sizes'
             ),
         Key([mod, "shift"], "f",
             lazy.window.toggle_floating(),
             desc='toggle floating'
             ),
        Key([mod], "f",
             lazy.window.toggle_fullscreen(),
             desc='toggle fullscreen'
             ),
         ### Stack controls
         Key([mod, "shift"], "Tab",
             lazy.layout.rotate(),
             lazy.layout.flip(),
             desc='Switch which side main pane occupies (XmonadTall)'
             ),
          Key([mod], "space",
             lazy.layout.next(),
             desc='Switch window focus to other pane(s) of stack'
             ),
         Key([mod, "shift"], "space",
             lazy.layout.toggle_split(),
             desc='Toggle between split and unsplit sides of stack'
             ),
         Key([], "XF86AudioLowerVolume", lazy.spawn("amixer sset Master 5%-")),
         Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer sset Master 5%+")),
         Key([], "XF86MonBrightnessUp", lazy.spawn("xbacklight -inc 10")),
         Key([], "XF86MonBrightnessDown", lazy.spawn("xbacklight -dec 10")),
         Key([mod], "s", lazy.spawn("rofi -show run")),
         Key([mod], "e", lazy.spawn("rofi -show emoji -modi emoji -theme arthur")),
         Key([mod], "c", lazy.spawn("rofi -show calc -modi calc -theme arthur")),
         Key([alt_mod], "l", lazy.spawn("i3lock-fancy-dualmonitor")),
         Key([alt_mod, "shift"], "l", lazy.spawn("fish -c 'sus'"))
]


groups = [
    Group("DEV", layout='columns'),
    Group("WWW", layout='columns'),
    Group("SYS", layout='columns'),
    Group("TRM", layout='columns'),
    Group("DOC", layout='columns'),
    Group("VBOX", layout='columns'),
    Group("CHAT", layout='columns'),
    Group("MUS", layout='columns'),
    Group("VID", layout='columns'),
    Group("VIS", layout='floating')
]

dgroups_key_binder = simple_key_binder("mod1")

layout_theme = {
    "border_width": 1,
    "margin": 15,
    "border_focus": "e1acff",
    "border_normal": "1D2330"
}

layouts = [
    #layout.MonadWide(**layout_theme),
    #layout.Bsp(**layout_theme),
    #layout.Stack(stacks=2, **layout_theme),
    #layout.RatioTile(**layout_theme),
    #layout.Tile(shift_windows=True, **layout_theme),
    #layout.VerticalTile(**layout_theme),
    #layout.Matrix(**layout_theme),
    #layout.Zoomy(**layout_theme),
    layout.Columns(**layout_theme),
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
    layout.Stack(num_stacks=2),
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

# colors = [["#282c34", "#282c34"],
# ["#1c1f24", "#1c1f24"],
# ["#dfdfdf", "#dfdfdf"],
# ["#ff6c6b", "#ff6c6b"],
# ["#98be65", "#98be65"],
# ["#da8548", "#da8548"],
# ["#51afef", "#51afef"],
# ["#c678dd", "#c678dd"],
# ["#46d9ff", "#46d9ff"],
# ["#a9a1e1", "#a9a1e1"]]

#Pywal Colors
colors_json = os.path.expanduser('~/.cache/wal/colors.json')
colordict = json.load(open(colors_json))
colors = [[colordict['colors']['color0'], colordict['colors']['color0']],
          [colordict['colors']['color1'], colordict['colors']['color1']],
          [colordict['colors']['color2'], colordict['colors']['color2']],
          [colordict['colors']['color4'], colordict['colors']['color4']],
          [colordict['colors']['color5'], colordict['colors']['color5']],
          [colordict['colors']['color6'], colordict['colors']['color6']],
          [colordict['colors']['color7'], colordict['colors']['color7']],
          [colordict['colors']['color8'], colordict['colors']['color8']],
          [colordict['colors']['color9'], colordict['colors']['color9']]]

#prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

##### DEFAULT WIDGET SETTINGS #####
widget_defaults = dict(font="Ubuntu Mono",
                       fontsize=10,
                       padding=2,
                       background=colors[2])
extension_defaults = widget_defaults.copy()


def init_widgets_list():
    this_widgets_list = [
        widget.Sep(linewidth=0,
                   padding=6,
                   foreground='#FFFFFF',
                   background=colors[0]),
        widget.Image(
            filename="~/.config/qtile/icons/python-white.png",
            scale="False",
            mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(term)}),
        widget.Sep(linewidth=0,
                   padding=6,
                   foreground='#FFFFFF',
                   background=colors[0]),
        widget.GroupBox(font="Ubuntu Mono",
                        fontsize=9,
                        margin_y=3,
                        margin_x=0,
                        padding_y=5,
                        padding_x=3,
                        borderwidth=3,
                        active=colors[2],
                        inactive=colors[7],
                        rounded=False,
                        highlight_color=colors[1],
                        highlight_method="line",
                        this_current_screen_border=colors[6],
                        this_screen_border=colors[4],
                        other_current_screen_border=colors[6],
                        other_screen_border=colors[4],
                        foreground='#FFFFFF',
                        background=colors[0]),
        widget.TextBox(text='|',
                       font="Ubuntu Mono",
                       background=colors[0],
                       foreground='474747',
                       padding=2,
                       fontsize=14),
        widget.CurrentLayoutIcon(
            custom_icon_paths=[os.path.expanduser("~/.config/qtile/icons")],
            foreground='#FFFFFF',
            background=colors[0],
            padding=0,
            scale=0.7),
        widget.CurrentLayout(foreground='#FFFFFF',
                             background=colors[0],
                             padding=5),
        widget.TextBox(text='|',
                       font="Ubuntu Mono",
                       background=colors[0],
                       foreground='474747',
                       padding=2,
                       fontsize=14),
        widget.WindowName(foreground='#FFFFFF',
                          background=colors[0],
                          padding=0),
        # widget.Systray(background=colors[0], padding=5),
        # widget.Sep(
        # linewidth = 0,
        # padding = 6,
        # foreground = '#FFFFFF',
        # background = colors[0]
        # ),
        # widget.TextBox(
        # text = '   ',
        # font = "Ubuntu Mono",
        # background = colors[0],
        # foreground = '#FFFFFF',
        # padding = 0,
        # fontsize = 60
        # ),
        widget.Net(
            interface="wlp0s20f3",
            format='Net: {down} ↓↑ {up}',
            foreground='#FFFFFF',
            background=colors[3],
            padding=5,
        ),
        widget.TextBox(text='   ',
                       font="Ubuntu Mono",
                       background=colors[3],
                       foreground='#FFFFFF',
                       padding=0,
                       fontsize=37),
        widget.ThermalSensor(foreground='#FFFFFF',
                             background=colors[4],
                             threshold=90,
                             fmt='Temp: {}',
                             padding=5),
        widget.TextBox(text='   ',
                       font="Ubuntu Mono",
                       background=colors[4],
                       foreground='#FFFFFF',
                       padding=0,
                       fontsize=37),
        widget.CheckUpdates(
            update_interval=1800,
            distro="Arch_checkupdates",
            display_format="Updates: {updates} ",
            foreground='#FFFFFF',
            colour_have_updates=colors[1],
            colour_no_updates=colors[1],
            mouse_callbacks={
                'Button1':
                lambda: qtile.cmd_spawn(term + ' -e sudo pacman -Syu')
            },
            padding=5,
            background=colors[5]),
        widget.TextBox(text='   ',
                       font="Ubuntu Mono",
                       background=colors[5],
                       foreground='#FFFFFF',
                       padding=0,
                       fontsize=37),
        widget.Memory(foreground='#FFFFFF',
                      background=colors[6],
                      mouse_callbacks={
                          'Button1':
                          lambda: qtile.cmd_spawn(term + ' -e htop')
                      },
                      fmt='Mem: {}',
                      padding=5),
        widget.TextBox(text='   ',
                       font="Ubuntu Mono",
                       background=colors[6],
                       foreground='#FFFFFF',
                       padding=0,
                       fontsize=37),
        widget.Volume(foreground='#FFFFFF',
                      background=colors[7],
                      fmt='Vol: {}',
                      padding=5),
        widget.TextBox(text='   ',
                       font="Ubuntu Mono",
                       background=colors[7],
                       foreground='#FFFFFF',
                       padding=0,
                       fontsize=37),
        widget.KeyboardLayout(foreground='#FFFFFF',
                              background=colors[8],
                              fmt='Keyboard: {}',
                              padding=5),
        widget.TextBox(text='   ',
                       font="Ubuntu Mono",
                       background=colors[8],
                       foreground='#FFFFFF',
                       padding=0,
                       fontsize=37),
        widget.Clock(foreground='#FFFFFF',
                     background=colors[9],
                     format="%A, %B %d - %H:%M "),
    ]
    return this_widgets_list


def init_widgets_screen1():
    this_widgets_screen1 = init_widgets_list()
    return this_widgets_screen1


def init_widgets_screen2():
    this_widgets_screen2 = init_widgets_list()
    del this_widgets_screen2[9:10]
    return this_widgets_screen2


def init_screens():
    return [
        Screen(top=bar.Bar(widgets=init_widgets_screen1(),
                           opacity=1.0,
                           size=25,
                           margin=[5, 10, 0, 10])),
        Screen(top=bar.Bar(widgets=init_widgets_screen2(),
                           opacity=1.0,
                           size=25,
                           margin=[5, 10, 0, 10]))
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
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
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

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True


@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])


# Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
