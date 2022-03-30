# -*- coding: utf-8 -*-
'''
Config Module for Layouts
'''
from libqtile import layout
from .cfg_colors import colordict

def getLayouts():
    layout_theme = {
        "border_width": 7,
        "margin": 20,
        "border_focus": colordict['colors']['color1'],
        "border_normal": colordict['colors']['color5']
    }
    layouts = [
        # layout.MonadWide(**layout_theme),
        # layout.Bsp(**layout_theme),
        # layout.Stack(stacks=2, **layout_theme),
        # layout.RatioTile(**layout_theme),
        # layout.Tile(shift_windows=True, **layout_theme),
        # layout.VerticalTile(**layout_theme),
        # layout.Matrix(**layout_theme),
        # layout.Zoomy(**layout_theme),
        # layout.Columns(**layout_theme),
        layout.Floating(**layout_theme),
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
    ]
    return layouts
