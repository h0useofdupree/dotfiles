# -*- coding: utf-8 -*-
'''
Config Module for Layouts
'''
from libqtile import layout
from .cfg_colors import clr_fg_main, clr_fg_sec


def getLayouts():
    layout_theme = {
        "border_width": 4,
        "margin": 20,
        "border_focus": clr_fg_main,
        "border_normal": clr_fg_sec,
    }
    # HACK: Changing margin on the fly
    layout_theme_2 = { 
        "border_width": 1,
        "margin": 1,
        "border_focus": clr_fg_main,
        "border_normal": clr_fg_sec,
    }
    layouts = [
        # layout.MonadWide(**layout_theme),
        # layout.Bsp(**layout_theme),
        # layout.Stack(stacks=2, **layout_theme),
        layout.RatioTile(**layout_theme),
        layout.RatioTile(**layout_theme_2),
        # layout.Tile(shift_windows=True, **layout_theme),
        # layout.VerticalTile(**layout_theme),
        # layout.Matrix(**layout_theme_2),
        # layout.Zoomy(**layout_theme),
        # layout.Columns(**layout_theme),
        # layout.Floating(**layout_theme),
        layout.MonadTall(**layout_theme),
        layout.MonadTall(**layout_theme_2),
        # layout.Max(**layout_theme),
        # layout.Stack(num_stacks=2),
        # layout.RatioTile(**layout_theme),
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
