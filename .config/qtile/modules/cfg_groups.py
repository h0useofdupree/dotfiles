# -*- coding: utf-8 -*-
'''
Group configuration for Qtile
'''
from libqtile.config import Group
from libqtile.dgroups import simple_key_binder

def getGroups():
    new_groups = [
        Group("DEV", layout='floating'),
        Group("WWW", layout='monadtall'),
        Group("TRM", layout='floating'),
        Group("SYS", layout='floating'),
        Group("DOC", layout='floating'),
        Group("VBOX", layout='monadtall'),
        Group("CHAT", layout='floating'),
        Group("VID", layout='floating'),
        Group("MUS", layout='floating'),
        Group("VIS", layout='floating')
    ]
    return new_groups

new_groups = getGroups()

def setGroupBindings():
    new_dgroups_key_binder = simple_key_binder("mod1")
    return new_dgroups_key_binder

new_dgroups_key_binder = setGroupBindings()
