from libqtile.extension.window_list import WindowList
from libqtile.command.client import InteractiveCommandClient

def print_windows():
    c = InteractiveCommandClient()
    for window in c.windows():
        print( window['name'] )

print_windows()
