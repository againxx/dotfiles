#!/usr/bin/python3

# import necessary objects
import gi
gi.require_version('Wnck', '3.0') # specify Wnck version
from gi.repository import Wnck

from gi.repository import Gtk

# the script itself
screen = Wnck.Screen.get_default()

while Gtk.events_pending():
    Gtk.main_iteration()

windows = screen.get_windows()
active = screen.get_active_window()
active_workspace = screen.get_active_workspace()

for w in windows:
    if w.get_workspace() == active_workspace and w != active:
        w.minimize()
