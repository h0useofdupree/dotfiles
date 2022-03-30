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
clr_bg_ter = colordict['colors']['color1']

# Grey
clr_dark_grey = '#141414'
clr_light_grey = '#898989'

# White
clr_dimmed_white = '#dfdfdf'

# 
