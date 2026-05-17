#!/usr/bin/env python3
"""
Sync Alacritty colors from the active rofi color scheme (~/.cache/colorscheme.rasi).
Maps rasi CSS variables → Alacritty TOML config.
"""

import os
import re
import sys
from tomlkit import parse as parse_toml, dumps as dump_toml

RASI_CACHE = os.path.expanduser("~/.cache/colorscheme.rasi")
ALACRITTY_CONFIG = os.path.expanduser("~/.config/alacritty/alacritty.toml")

# Mapping: rasi variable → Alacritty TOML path
COLOR_MAP = {
    "foreground":  ("primary", "foreground"),
    "background":  ("primary", "background"),
    "dim_foreground": ("primary", "dim_foreground"),
    "bright_foreground": ("primary", "bright_foreground"),
    "color0":  ("normal", "black"),
    "color1":  ("normal", "red"),
    "color2":  ("normal", "green"),
    "color3":  ("normal", "yellow"),
    "color4":  ("normal", "blue"),
    "color5":  ("normal", "magenta"),
    "color6":  ("normal", "cyan"),
    "color7":  ("normal", "white"),
    "color8":  ("bright", "black"),
    "color9":  ("bright", "red"),
    "color10": ("bright", "green"),
    "color11": ("bright", "yellow"),
    "color12": ("bright", "blue"),
    "color13": ("bright", "magenta"),
    "color14": ("bright", "cyan"),
    "color15": ("bright", "white"),
}


def parse_rasi_colors(path):
    """Parse rasi CSS variables into {name: hex_color} dict."""
    if not os.path.exists(path):
        return None

    with open(path) as f:
        content = f.read()

    # Strip comments
    content = re.sub(r'/\*.*?\*/', '', content, flags=re.DOTALL)

    colors = {}
    # Match variable declarations like:  foreground: #cdd6f4;
    # Or: background: rgba(30,30,46,0.92);
    pattern = re.compile(
        r'(?P<name>\w[\w-]*)\s*:\s*(?P<value>#[0-9a-fA-F]{6,8}|rgba?\s*\([^)]+\))\s*;'
    )
    for m in pattern.finditer(content):
        name = m.group("name")
        value = m.group("value").strip()
        # Convert rgba to hex (strip alpha)
        hex_val = to_hex(value)
        if hex_val:
            colors[name] = hex_val

    return colors


def to_hex(value):
    """Convert a color value to 6-digit hex. Handles #rgb, #rrggbb, rgba()."""
    value = value.strip()
    if value.startswith("#"):
        v = value[1:]
        if len(v) == 3:
            return "#" + "".join(c * 2 for c in v)
        elif len(v) == 6:
            return "#" + v
        elif len(v) == 8:
            return "#" + v[:6]  # Strip alpha
    elif value.startswith("rgba") or value.startswith("rgb"):
        # Extract RGB components
        m = re.search(r'rgba?\s*\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)', value)
        if m:
            r, g, b = int(m.group(1)), int(m.group(2)), int(m.group(3))
            return f"#{r:02x}{g:02x}{b:02x}"
    return None


def update_alacritty_config(colors):
    """Write colors into alacritty.toml, preserving all other settings."""
    if not os.path.exists(ALACRITTY_CONFIG):
        print(f"Alacritty config not found: {ALACRITTY_CONFIG}")
        return False

    with open(ALACRITTY_CONFIG) as f:
        config = parse_toml(f.read())

    # Ensure [colors] section exists
    if "colors" not in config:
        config["colors"] = {}

    # Apply mapped colors
    for rasi_name, (section, key) in COLOR_MAP.items():
        if rasi_name in colors:
            if section not in config["colors"]:
                config["colors"][section] = {}
            config["colors"][section][key] = colors[rasi_name]

    # Set cursor colors using background/foreground
    bg = colors.get("background", "#1e1e2e")
    fg = colors.get("foreground", "#cdd6f4")
    if "cursor" not in config["colors"]:
        config["colors"]["cursor"] = {}
    config["colors"]["cursor"]["cursor"] = fg
    config["colors"]["cursor"]["text"] = bg

    # Set selection colors
    if "selection" not in config["colors"]:
        config["colors"]["selection"] = {}
    config["colors"]["selection"]["background"] = fg
    config["colors"]["selection"]["text"] = bg

    with open(ALACRITTY_CONFIG, "w") as f:
        f.write(dump_toml(config))

    return True


def main():
    colors = parse_rasi_colors(RASI_CACHE)
    if not colors:
        print(f"Could not parse colors from {RASI_CACHE}")
        sys.exit(1)

    if update_alacritty_config(colors):
        print(f"Alacritty colors updated from {os.path.basename(RASI_CACHE)}")
    else:
        sys.exit(1)


if __name__ == "__main__":
    main()
