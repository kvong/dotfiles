# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
import subprocess
import time

from typing import List, Dict  # noqa: F401

from libqtile import bar, layout, widget, hook, qtile
from libqtile.config import Click, Drag, Group, Key, Match, Screen, ScratchPad, DropDown, Match
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile.widget.generic_poll_text import GenPollUrl
from libqtile.widget import base
from urllib.parse import urlencode
from datetime import datetime
import locale
import finnhub
import json

# MOD1 = ALT
mod = "mod1"

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.shrink(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.shrink(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn("urxvt"), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "Escape", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    #Key([mod], "d", lazy.spawn('/home/blank/Scripts/dmenu-launcher'), desc="Spawn a command using a dmenu launcher"),
    Key([mod], "d", lazy.spawn('rofi -show run -config ~/.config/qtile/rofi/config'), desc="Spawn a command using a rofi launcher"),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating and tilling"),

    # Open Scratchpads
    Key([mod], 'g', lazy.group['scratchpad'].dropdown_toggle('gedit')),
    Key([mod], 'i', lazy.group['scratchpad'].dropdown_toggle('urxvt')),
]

workspaces = [
    # Main Workspaces
    {"name": "TERM", "key": "1", "matches": [Match(wm_class="urxvt")]},
    {"name": "WEB", "key": "2", "matches": [Match(wm_class="Firefox")]},
    {"name": "CODE", "key": "3", "matches": [
        Match(wm_class="jetbrains-phpstorm"),
        Match(wm_class="code"),
        ]
    },
    # Temporary Workspaces
    {"name": "FILE", "key": "4", "matches": [Match(wm_class="Thunar")]},
    {"name": "TEMP-Q", "key": "q"},
    {"name": "TEMP-W", "key": "w"},
    {"name": "TEMP-E", "key": "e"},
    {"name": "TEMP-R", "key": "r"},
]

# ScratchPad
groups = [ScratchPad("scratchpad", [
    DropDown("gedit", "gedit", height=0.5, width=.5, y=0.25, x=.25, opacity=1),
    DropDown("urxvt", "urxvt -name Scratchpad", height=0.5, width=.5, y=0.25, x=.25, opacity=1),
])]


# Add workspaces to groups
for workspace in workspaces:
    matches = workspace["matches"] if "matches" in workspace else None
    groups.append(Group(workspace["name"], matches=matches))
    keys.append(
        Key(
            [mod],
            workspace["key"],
            lazy.group[workspace["name"]].toscreen(),
            desc="Focus this desktop",
        )
    )
    keys.append(
        Key(
            [mod, "shift"],
            workspace["key"],
            lazy.window.togroup(workspace["name"]),
            desc="Move focused window to another group",
        )
    )

layouts = [
    # Try more layouts by unleashing below layouts.
    # layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
     layout.MonadTall( ratio=.60, margin=5),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
     layout.TreeTab(),
     layout.Max(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

colors = {
    'red' : ['#cc6666','#cc6666'],
    'violet' : ['#b294bb','#b294bb'],
    'blue' : ['#81a2be','#81a2be'],
    'teal' : ['#8abeb7','#8abeb7'],
    'green' : ['#b5bd68','#b5bd68'],
    'yellow' : ['#f0c674','#f0c674'],
    'orange' : ['#FF9966','#FF9966'],
    'white' : ['#ffffff','#ffffff'],
    'black' : ['#000000','#000000'],
    'active': ["#ecf0c1", "#ecf0c1"],  # ACTIVE WORKSPACES
    'inactive' : ["#686f9a", "#686f9a"],  # INACTIVE WORKSPACES
    'background': ["#0e131a", "#0e131a"],  # BAR BACKGROUND
    'background-active': ["#808088", "#808088"],  # ACTIVE WORKSPACE BACKGROUND 
}


widget_defaults = dict(
    font="Hack Nerd Font",
    fontsize=16,
    background=colors['background']
)

extension_defaults = widget_defaults.copy()

# Defautl group settings
group_box_settings = {
    "padding" : 15,
    "borderwidth" : 3,
    "active" : colors['active'],
    "inactive" : colors['inactive'],
    "disable_drag" : True,
    "rounded" : True,
    "margin_y" : 3,
    "margin_x" : 2,
    "padding_y" : 5,
    "padding_x" : 8,
    #"hide_unused" :True,
    "highlight_color" : colors['background-active'],
    "highlight_method" : "block",
    "this_current_screen_border" : colors['background-active'],
    "this_screen_border" : colors['background-active'],
    "foreground" : colors['white'],
    "background" : colors['background'],
}

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

@hook.subscribe.startup_once
def autostart():
    """Start the applications at Qtile startup."""
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])

# Widget to cycle through a list of ticker symbols
class StockTickerNew(base.ThreadPoolText):
    ticker_length = 0
    ticker_counter = -1

    # Save some API calls in afterhours and weekend by adding caching
    ticker_table: Dict[str, str] = {}

    defaults = [
        ("symbols", ["AAPL"], "Symbols for quote lookup"),
        ("token", "", "API key for Finnhub"),
        ("update_interval", 10.0, "Update interval for ticker refresh"),
        ("format", "{symbol}: {sign}{price}", "Update interval for ticker refresh"),
    ]
    def __init__( self, **config):
        super().__init__("", **config)
        self.sign = locale.localeconv()["currency_symbol"]
        self.add_defaults(StockTickerNew.defaults)
        StockTickerNew.ticker_length = len(self.symbols)

    # Cycle throught list of tickers
    @staticmethod
    def cycle_tickers():
        StockTickerNew.ticker_counter = ( StockTickerNew.ticker_counter + 1 ) % StockTickerNew.ticker_length
        
    def poll(self):
        StockTickerNew.cycle_tickers()

        day_int = datetime.today().isoweekday()
        current_hour = int(datetime.now().strftime("%H"))
        ticker=self.symbols[StockTickerNew.ticker_counter]

        # Disable api calls on afterhour or weekends, only make api call if cache is empty
        if day_int < 5 or (current_hour < 15 and current_hour > 8) or len(StockTickerNew.ticker_table) < StockTickerNew.ticker_length:
            finnhub_client = finnhub.Client(api_key=self.token)
            response = finnhub_client.quote(self.symbols[StockTickerNew.ticker_counter])
            str_response = str(response).replace("'", '"')
            data = json.loads(str_response)
            price = str(data['c'])
            StockTickerNew.ticker_table[ticker] = price # Add ticker:price to cache table
            return self.format.format(symbol=ticker, sign=self.sign, price=price)
        price = StockTickerNew.ticker_table[ticker] 
        return "望 " + self.format.format(symbol=ticker, sign=self.sign, price=price)

# For security purposes put api key in local .env file
f_env = open(str(os.path.expanduser("~")) + "/.config/qtile/.env", "r")
finnhub_api_key = f_env.readline().strip()
alphavan_api_key = f_env.readline().strip()
f_env.close()

screens = [
    Screen(
        wallpaper="~/Pictures/bg.jpg",
        wallpaper_mode="stretch",
        bottom=bar.Bar(
            [
                widget.CurrentLayout(),
                # Use multiple GroupBox to categorize primary and secondary goups
                widget.GroupBox(
                    visible_groups=["TERM", "WEB", "CODE", "FILES"],
                    **group_box_settings,
                ),
                widget.GroupBox(
                    visible_groups=["TEMP-Q","TEMP-W","TEMP-E","TEMP-R"],
                    hide_unused=True,
                    **group_box_settings,
                ),
                widget.Spacer(),

                # STOCK TICKER NEW
                widget.TextBox(text="", foreground=colors['orange'], background=colors['background'], padding=0, fontsize=35),
                StockTickerNew(token=api_key, symbols=["AMZN", "FB", "AAPL"], background=colors['orange'], foreground=colors['background'] ),
                widget.TextBox(text="", foreground=colors['background'], background=colors['orange'], padding=0, fontsize=28),
                
                # STOCK TICKER
                widget.TextBox(text="", foreground=colors['yellow'], background=colors['background'], padding=0, fontsize=35),
                widget.StockTicker(apikey=alphavan_api_key, symbol="ETH", interval="5min", function="CRYPTO_INTRADAY", market="USD", background=colors['yellow'], foreground=colors['background'] ),
                widget.TextBox(text="", foreground=colors['background'], background=colors['yellow'], padding=0, fontsize=28),

                # CPU
                widget.TextBox(text="", foreground=colors['green'], background=colors['background'], padding=0, fontsize=35),
                widget.CPU( background=colors['green'], foreground=colors['background'] ),
                widget.TextBox(text="", foreground=colors['background'], background=colors['green'], padding=0, fontsize=28),

                # MEMORY
                widget.TextBox(text="", foreground=colors['teal'], background=colors['background'], padding=0, fontsize=35),
                widget.Memory( format="RAM: {MemUsed: .0f}/{MemTotal: .0f}{mm}", measure_mem="G", background=colors['teal'], foreground=colors['background'] ),
                widget.TextBox(text="", foreground=colors['background'], background=colors['teal'], padding=0, fontsize=28),

                # NETWORK
                widget.TextBox(text="", foreground=colors['blue'], background=colors['background'], padding=0, fontsize=35),
                widget.Net(interface="enp0s31f6", background=colors['blue'], foreground=colors['background'], format="{down} ↓↑ {up}" ),
                widget.TextBox(text="", foreground=colors['background'], background=colors['blue'], padding=0, fontsize=28),

                # DATE
                widget.TextBox(text="", foreground=colors['violet'], background=colors['background'], padding=0, fontsize=35),
                widget.Clock(format="%a %I:%M %p", background=colors['violet'], foreground=colors['background'] ),
                widget.TextBox(text="", foreground=colors['background'], background=colors['violet'], padding=0, fontsize=28),

                # LOGOUT
                widget.TextBox(text="", foreground=colors['red'], background=colors['background'], padding=0, fontsize=35),
                widget.QuickExit( default_text="Logout ", background=colors['red'], foreground=colors['background'] ),
                widget.TextBox(text="", foreground=colors['background'], background=colors['red'], padding=0, fontsize=28),
            ],
            26,
            border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            border_color=colors['background'][0],  # Borders are magenta
            margin=[5,10,10,10],
        ),
        left=bar.Gap(10),
        right=bar.Gap(10),
        top=bar.Gap(10),
    ),
]
