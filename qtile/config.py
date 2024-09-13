#   ___ _____ ___ _     _____    ____             __ _       
#  / _ \_   _|_ _| |   | ____|  / ___|___  _ __  / _(_) __ _ 
# | | | || |  | || |   |  _|   | |   / _ \| '_ \| |_| |/ _` |
# | |_| || |  | || |___| |___  | |__| (_) | | | |  _| | (_| |
#  \__\_\|_| |___|_____|_____|  \____\___/|_| |_|_| |_|\__, |
#                                                      |___/ 

# Icons: https://fontawesome.com/search?o=r&m=free

import os
import re
import socket
import subprocess
import psutil
import json
from libqtile import hook
from libqtile import qtile
from typing import List  
from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen, ScratchPad, DropDown, KeyChord
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile.widget import Spacer, Backlight
from libqtile.widget.image import Image
from libqtile.dgroups import simple_key_binder
from pathlib import Path
from libqtile.log_utils import logger

from qtile_extras import widget
from qtile_extras.widget.decorations import RectDecoration
from qtile_extras.widget.decorations import PowerLineDecoration

# --------------------------------------------------------
# Your configuration
# --------------------------------------------------------

# Keyboard layout in autostart.sh

# Show wlan status bar widget (set to False if wired network)
# show_wlan = True
show_wlan = False

# Show bluetooth status bar widget
# show_bluetooth = True
show_bluetooth = False

# --------------------------------------------------------
# General Variables
# --------------------------------------------------------

# Get home path
home = str(Path.home())

# --------------------------------------------------------
# Check for Desktop/Laptop
# --------------------------------------------------------

# 3 = Desktop
platform = int(os.popen("cat /sys/class/dmi/id/chassis_type").read())

# --------------------------------------------------------
# Set default apps
# --------------------------------------------------------

terminal = "terminator"        

# --------------------------------------------------------
# Keybindings
# --------------------------------------------------------

mod = "mod4" # SUPER KEY

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html

    # Navigate
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    
    # Arrange
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    
    # Size
    Key([mod, "control"], "h", lazy.layout.shrink(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.shrink(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Hide bar for emersive experience
    Key([mod], "f", lazy.hide_show_bar("bottom"), desc="Toggle hide bar"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),

    #System
    Key([mod], "Escape", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    #Key([mod, "control"], "q", lazy.spawn(home + "/dotfiles/qtile/scripts/powermenu.sh"), desc="Open Powermenu"),
    Key([mod], "d", lazy.spawn('rofi -show run'), desc="Spawn a command using a rofi launcher"),

    # Float
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating and tilling"),

    # Apps
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "b", lazy.spawn("sh " + home + "/dotfiles/.settings/browser.sh"), desc="Launch Browser"),
    #Key([mod, "shift"], "w", lazy.spawn(home + "/dotfiles/qtile/scripts/wallpaper.sh"), desc="Update Theme and Wallpaper"),
    Key([mod, "control"], "w", lazy.spawn(home + "/dotfiles/qtile/scripts/wallpaper.sh select"), desc="Select Theme and Wallpaper"),
]

# --------------------------------------------------------
# Workspaces
# --------------------------------------------------------
workspaces = [
    # Main Workspaces
    {"name": "TERM", "key": "1", "matches": [Match(wm_class="Terminator")]},
    {"name": "WEB", "key": "2", "matches": [Match(wm_class="firefox")]},
    {"name": "CODE", "key": "3"},
    {"name": "FILES", "key": "4", "matches": [Match(wm_class="Thunar"),Match(wm_class="Filezilla")]},
    # Temporary Workspaces
    {"name": "TEMP-Q", "key": "q"},
    {"name": "TEMP-W", "key": "w"},
    {"name": "TEMP-E", "key": "e"},
]


# --------------------------------------------------------
# Groups
# --------------------------------------------------------

group_keys = ['1','2','3','4','q','w','e','a']
groups = [Group(f"{group_keys[i]}", label="") for i in range(len(group_keys))]


for i, g in enumerate(groups):
    keys.extend(
            [
                Key(
                    [mod],
                    g.name,
                    lazy.group[g.name].toscreen(),
                    desc="Switch to group {}".format(g.name),
                    ),
                Key(
                    [mod, "shift"],
                    g.name,
                    lazy.window.togroup(g.name, switch_group=True),
                    desc="Switch to & move focused window to group {}".format(g.name),
                    ),
                ]
            )


# --------------------------------------------------------
# Scratchpads
# --------------------------------------------------------

groups.append(ScratchPad("6", [
    DropDown("chatgpt", "chromium --app=https://chat.openai.com", x=0.3, y=0.1, width=0.40, height=0.4, on_focus_lost_hide=False ),
    DropDown("mousepad", "mousepad", x=0.3, y=0.1, width=0.40, height=0.4, on_focus_lost_hide=False ),
    DropDown("terminal", "terminator", x=0.3, y=0.1, width=0.40, height=0.4, on_focus_lost_hide=False ),
    DropDown("scrcpy", "scrcpy -d", x=0.8, y=0.05, width=0.15, height=0.6, on_focus_lost_hide=False )
]))

keys.extend([
    Key([mod], 'F10', lazy.group["6"].dropdown_toggle("chatgpt")),
    Key([mod], 'F11', lazy.group["6"].dropdown_toggle("mousepad")),
    Key([mod], 'F12', lazy.group["6"].dropdown_toggle("terminal")),
    Key([mod], 'F9', lazy.group["6"].dropdown_toggle("scrcpy"))
])

# --------------------------------------------------------
# Pywal Colors
# --------------------------------------------------------

colors = []

cache = os.path.expanduser('~/.cache/wal/colors')
def load_colors(cache):
    with open(cache, 'r') as file:
        for i in range(16):
            colors.append(file.readline().strip())
    colors.append('#ffffff')
    lazy.reload()
load_colors(cache)


Color0=colors[0]
Color1=colors[1]
Color2=colors[2]
Color3=colors[3]
Color4=colors[4]
Color5=colors[5]
Color6=colors[6]
Color7=colors[7]
Color8=colors[8]
Color9=colors[9]
Color10=colors[10]
Color11=colors[11]
Color12=colors[12]
Color13=colors[13]
Color14=colors[14]
Color15=colors[15]

# --------------------------------------------------------
# Setup Layout Theme
# --------------------------------------------------------

layout_theme = { 
    "border_width": 3,
    "margin": 15,
    "border_focus": Color2,
    "border_normal": "FFFFFF",
    "single_border_width": 3
}

# --------------------------------------------------------
# Layouts
# --------------------------------------------------------

layouts = [
    layout.MonadThreeCol(**layout_theme),
    layout.Max(**layout_theme),
]

# --------------------------------------------------------
# Setup Widget Defaults
# --------------------------------------------------------

widget_defaults = dict(
    font="FuraCode Nerd Font",
    fontsize=18,
    padding=3
)
extension_defaults = widget_defaults.copy()

# --------------------------------------------------------
# Decorations
# https://qtile-extras.readthedocs.io/en/stable/manual/how_to/decorations.html
# --------------------------------------------------------

decor_left = {
    "decorations": [
        PowerLineDecoration(
            # path="arrow_left"
            path="rounded_left"
            # path="forward_slash"
            # path="back_slash"
        )
    ],
}

decor_right = {
    "decorations": [
        PowerLineDecoration(
            # path="arrow_right"
            path="rounded_right"
            # path="forward_slash"
            # path="back_slash"
        )
    ],
}

# --------------------------------------------------------
# Widgets
# --------------------------------------------------------

widget_list = [
    widget.TextBox(
        **decor_right,
        background=Color1+".0",
        text=' ',
        foreground='ffffff',
    ),
    #widget.TextBox(
    #    **decor_left,
    #    background=Color1+".4",
    #    text='',
    #    foreground='ffffff',
    #    desc='',
    #    padding=10,
    #    mouse_callbacks={"Button1": lambda: qtile.cmd_spawn("rofi -show drun")},
    #),
    widget.TextBox(
        **decor_left,
        background=Color1+".4",
        text="",
        fontsize=18,
        mouse_callbacks={"Button1": lambda: qtile.cmd_spawn(home + "/dotfiles/qtile/scripts/wallpaper.sh select")},
    ),
    widget.TextBox(
        **decor_right,
        background="#ffffff.0",
        text=' ',
        foreground='ffffff',
        desc='',
        padding=0,
    ),
    widget.GroupBox(
        **decor_left,
        background="#ffffff.7",
        highlight_method='block',
        highlight='ffffff',
        block_border='ffffff',
        highlight_color=['ffffff','ffffff'],
        block_highlight_text_color='000000',
        foreground='ffffff',
        rounded=False,
        this_current_screen_border='ffffff',
        active='ffffff'
    ),
    widget.TextBox(
        **decor_right,
        background="#ffffff.0",
        text=' ',
        foreground='ffffff',
        desc='',
        padding=0,
    ),
    widget.TextBox(
        **decor_left,
        background=Color3+".4",
        text="",
        fontsize=18,
        mouse_callbacks={"Button1": lambda: qtile.cmd_spawn("bash " + home + "/dotfiles/.settings/browser.sh")},
    ),
    widget.TextBox(
        **decor_left,
        background=Color3+".4",
        text="",
        fontsize=18,
        mouse_callbacks={"Button1": lambda: qtile.cmd_spawn("bash " + home + "/dotfiles/.settings/filemanager.sh")}
    ),
    widget.TextBox(
        **decor_right,
        background="#ffffff.0",
        text=' ',
        foreground='ffffff',
        desc='',
        padding=0,
    ),
    widget.Spacer(
        background="#ffffff.0"
    ),
    widget.Spacer(
        background="#ffffff.0"
    ),
    widget.TextBox(
        **decor_right,
        background="#ffffff.0",
        text=' ',
        foreground='ffffff',
        desc='',
        padding=0,
    ),    
    widget.Memory(
        **decor_left,
        background=Color10+".4",
        padding=10,        
        measure_mem='G',
        format=" {MemUsed:.0f}{mm} ({MemTotal:.0f}{mm})"
    ),
    widget.TextBox(
        **decor_right,
        background="#ffffff.0",
        text=' ',
        foreground='ffffff',
        desc='',
        padding=0,
    ),    
    # Not sure why this needs to be here but had to add this otherwize TextBox for decor_right after it wouldnt show up
    widget.TextBox(
        text='',
    ),    
    widget.TextBox(
        **decor_right,
        background="#ffffff.0",
        text=' ',
        foreground='ffffff',
        desc='',
        padding=0,
    ),    
    widget.DF(
        **decor_left,
        padding=10, 
        background=Color8+".4",        
        visible_on_warn=False,
        max_char=100,
        format=" {uf}{m} ({r:.0f}%)"
    ),
    widget.TextBox(
        **decor_right,
        background="#ffffff.0",
        text=' ',
        foreground='ffffff',
        desc='',
        padding=0,
    ),    
    widget.Clock(
        **decor_left,
        background=Color4+".4",   
        padding=10,      
        format=" %Y-%m-%d /  %I:%M %p",
    ),
    widget.TextBox(
        **decor_right,
        background="#ffffff.0",
        text=' ',
        foreground='ffffff',
        desc='',
        padding=0,
    ),    
]

# Hide Modules if not on laptop
if (show_wlan == False):
    del widget_list[13:14]

if (show_bluetooth == False):
    del widget_list[12:13]

# --------------------------------------------------------
# Screens
# --------------------------------------------------------

current_wallpaper_f = open(os.path.expanduser('~/.cache/current_wallpaper'))
current_wallpaper = current_wallpaper_f.read().strip()
current_wallpaper_f.close()

screens = [
    Screen(
        bottom=bar.Bar(
            widget_list,
            30,
            padding=20,
            opacity=0.7,
            border_width=[0, 0, 0, 0],
            margin=[0,0,5,0],
            background="#000000.0"
        ),
        wallpaper=current_wallpaper,
        wallpaper_mode='stretch',
    ),
]

# --------------------------------------------------------
# Drag floating layouts
# --------------------------------------------------------

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

# --------------------------------------------------------
# Define floating layouts
# --------------------------------------------------------

floating_layout = layout.Floating(
    border_width=3,
    border_focus=Color2,
    border_normal="FFFFFF",
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

# --------------------------------------------------------
# General Setup
# --------------------------------------------------------

dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
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

# --------------------------------------------------------
# Windows Manager Name
# --------------------------------------------------------

wmname = "QTILE"

# --------------------------------------------------------
# Hooks
# --------------------------------------------------------

# HOOK startup
@hook.subscribe.startup_once
def autostart():
    autostartscript = "~/.config/qtile/autostart.sh"
    home = os.path.expanduser(autostartscript)
    subprocess.Popen([home])
    bottom.show(False)

