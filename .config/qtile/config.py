# -*- coding: utf-8 -*-
import os
import subprocess
from typing import List  # noqa: F401
from libqtile import bar, hook, layout
from libqtile.command import lazy
from libqtile.config import Click, Drag, Match, Screen
from libqtile.lazy import lazy
from modules.cfg_keybinds import mod, getKeys
from modules.cfg_groups import getGroups, setGroupBindings
from modules.cfg_layout import getLayouts
from modules.cfg_widgets import init_widgets_list, init_widgets_screen1, init_widgets_screen2
from modules.cfg_colors import clr_bg_sec


keys = getKeys()
groups = getGroups()
dgroups_key_binder = setGroupBindings()
layouts = getLayouts()

##### DEFAULT WIDGET SETTINGS #####
widget_defaults = dict(font="Arimo Nerd Font",
                       fontsize=14,
                       padding=3,
                       background=clr_bg_sec,
                       foreground='#FFFFFF')
extension_defaults = widget_defaults.copy()


def init_screens():
    return [
        Screen(
            top=bar.Bar(widgets=init_widgets_screen1(), opacity=.9, size=32, margin=[10,20,-10,20])),
        Screen(
            top=bar.Bar(widgets=init_widgets_screen2(), opacity=.9, size=32, margin=[10,20,-10,20])),
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

# Misc
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True

# Autostart
@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])

# Compatibility
wmname = "LG3D"
