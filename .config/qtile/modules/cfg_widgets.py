# -*- coding: utf-8 -*-
# vim:foldmethod=marker
'''
Config Module for Widgets
'''
import os
from libqtile import qtile, widget
from .cfg_colors import clr_bg_main, clr_bg_sec, clr_bg_ter, clr_dark_grey, clr_light_grey, clr_dimmed_white, colordict
from .cfg_keybinds import term

#{{{Widget List
def init_widgets_list():
    this_widgets_list = [
        #{{{Left
        widget.Sep(linewidth=0,
                   padding=9,
                   foreground='#FFFFFF',
                   background=clr_bg_main),
        # widget.Image(
        # filename="~/.config/qtile/icons/python-white.png",
        # scale="False",
        # mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(term)}),
        widget.Sep(linewidth=0,
                   padding=9,
                   foreground='#FFFFFF',
                   background=clr_bg_main),
        widget.GroupBox(
            font="Arimo Nerd Font",
            fontsize=13,
            margin_y=3,
            margin_x=0,
            padding_y=5,
            padding_x=3,
            borderwidth=3,
            active=clr_dimmed_white,
            inactive=clr_light_grey,
            rounded=True,
            highlight_color=clr_bg_ter,
            highlight_method="line",
            this_current_screen_border=colordict['colors']['color1'],
            this_screen_border=colordict['colors']['color1'],
            other_current_screen_border=colordict['colors']['color1'],
            other_screen_border=colordict['colors']['color5'],
            foreground='#FFFFFF',
            background=clr_bg_main),
        widget.TextBox(text='|',
                       font="Arimo Nerd Font",
                       background=clr_bg_main,
                       foreground='474747',
                       padding=2,
                       fontsize=14),
        widget.CurrentLayoutIcon(
            custom_icon_paths=[os.path.expanduser("~/.config/qtile/icons")],
            foreground='#FFFFFF',
            background=clr_bg_main,
            padding=0,
            scale=0.7),
        # widget.CurrentLayout(foreground='#FFFFFF',
        #                      background=clr_bg_main,
        #                      padding=0),
        widget.TextBox(text='|',
                       font="Arimo Nerd Font",
                       background=clr_bg_main,
                       foreground='474747',
                       padding=2,
                       fontsize=14),
        widget.WindowName(foreground='#FFFFFF',
                          background=clr_bg_main,
                          padding=0),
        #}}}
        #{{{Right
        # widget.TextBox(text='',
        #                font="Ubuntu Mono Nerd Font",
        #                background=clr_bg_main,
        #                foreground=clr_bg_ter,
        #                padding=4,
        #                fontsize=50),
        widget.Systray(background=clr_bg_ter, padding=15),
        widget.TextBox(text=' ',
                       font="Ubuntu Mono Nerd Font",
                       background=clr_bg_ter,
                       foreground=clr_bg_sec,
                       padding=0,
                       fontsize=30,
                       margin=0),
        widget.Battery(background=clr_bg_sec,
                       foreground='#ffffff',
                       battery=0,
                       padding=10),
        # widget.TextBox(text='',
        #                font="Ubuntu Mono Nerd Font",
        #                background=clr_bg_sec,
        #                foreground=clr_bg_main,
        #                padding=4,
        #                fontsize=50),
        widget.ThermalSensor(foreground='#ffffff',
                             background=clr_bg_main,
                             threshold=90,
                             fmt='🌡️ {}',
                             padding=10),
        # widget.TextBox(text='',
        #                font="Ubuntu Mono Nerd Font",
        #                background=clr_bg_main,
        #                foreground=clr_bg_sec,
        #                padding=4,
        #                fontsize=50),
        widget.CheckUpdates(update_interval=1800,
                            distro="Arch_checkupdates",
                            display_format="⬆ {updates} ",
                            foreground='#ffffff',
                            colour_have_updates='#ffffff',
                            colour_no_updates='#ffffff',
                            mouse_callbacks={
                                'Button1':
                                lambda: qtile.cmd_spawn(
                                    term + ' -e sudo up')
                            },
                            padding=10,
                            background=clr_bg_sec),
        # widget.TextBox(text='',
        #                font="Ubuntu Mono Nerd Font",
        #                background=clr_bg_sec,
        #                foreground=clr_bg_main,
        #                padding=4,
        #                fontsize=50),
        widget.Memory(foreground='#ffffff',
                      background=clr_bg_main,
                      mouse_callbacks={
                          'Button1': lambda: qtile.cmd_spawn(term + ' -e htop')
                      },
                      fmt='🧮 {}',
                      padding=10),
        # widget.TextBox(text='',
                       # font="Ubuntu Mono Nerd Font",
                       # background=colordict['colors']['color6'],
                       # foreground=colordict['colors']['color7'],
                       # padding=4,
                       # fontsize=50),
        # widget.PulseVolume(foreground='#000000',
                           # background=colordict['colors']['color7'],
                           # fmt='🔉 {}',
                           # padding=0),
        # widget.TextBox(text='',
        #                font="Ubuntu Mono Nerd Font",
        #                background=clr_bg_main,
        #                foreground=clr_bg_sec,
        #                padding=4,
        #                fontsize=50),
        widget.KeyboardLayout(foreground='#ffffff',
                              background=clr_bg_sec,
                              fmt='⌨️ {}',
                              padding=10),
        # widget.TextBox(text='',
        #                font="Ubuntu Mono Nerd Font",
        #                background=clr_bg_sec,
        #                foreground=clr_bg_main,
        #                padding=4,
        #                fontsize=50),
        widget.Clock(foreground='#ffffff',
                     background=clr_bg_main,
                     format="%A, %B %d - %H:%M "),
        #}}}
    ]
    return this_widgets_list
#}}}


def init_widgets_screen1():
    this_widgets_screen1 = init_widgets_list()
    return this_widgets_screen1


def init_widgets_screen2():
    this_widgets_screen2 = init_widgets_list()
    # Remove systray widget due to limit of 1 tray
    # this_widgets_screen2[9] = widget.Net(format="↓{down}↑{up}", max_chars=16)
    this_widgets_screen2[7] = widget.NetGraph(
        border_color=clr_bg_main,
        border_width=0,
        fill_color=clr_bg_main,
        graph_color=clr_bg_main,
        background=clr_bg_ter,
        padding=0,
    )
    return this_widgets_screen2
