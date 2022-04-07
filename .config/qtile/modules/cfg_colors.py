# -*- coding: utf-8 -*-
'''
Config Module for Colors
'''
import json, os


def getColordict():
    colors_json = os.path.expanduser('~/.cache/wal/colors.json')
    colordict = json.load(open(colors_json))
    return colordict


colordict = getColordict()

clr_bg_main = '#000000'
clr_bg_sec = '#202020'
clr_fg_main = colordict['colors']['color1']
clr_fg_sec = colordict['colors']['color4']

# Grey
clr_grey_dark = '#141414'
clr_grey_light = '#898989'

# White
clr_white_dimmed = '#dfdfdf'

# 
