# -*- coding: utf-8 -*-
'''
Group configuration for Qtile
'''
from libqtile.config import Group, ScratchPad, DropDown
from libqtile.dgroups import simple_key_binder
from .cfg_keybinds import term

def getGroups():
    new_groups = [
        ScratchPad("ScratchPad", [
            DropDown("term", term, opacity=.8),
            DropDown("qtile shell", f"{term} --hold -e qtile shell",
                      x=.05, y=.4, width=.9, height=.6, opacity=.8, on_focus_lost_hide=True)
            ]),
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
    return new_groups

new_groups = getGroups()

def setGroupBindings():
    new_dgroups_key_binder = simple_key_binder("mod1")
    return new_dgroups_key_binder

new_dgroups_key_binder = setGroupBindings()
