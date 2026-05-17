#!/bin/bash
# pick-colorscheme.sh — rofi-based color scheme picker
# Lists all available schemes in ~/.cache/rofi/colorschemes/
# and the built-in catppuccin-mocha.
# Selected scheme is copied to ~/.cache/colorscheme.rasi

set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CACHE_DIR="$HOME/.cache/rofi/colorschemes"
CACHE_FILE="$HOME/.cache/colorscheme.rasi"
ROFI_CONFIG="$DIR/rofi/config-colorscheme.rasi"
DEFAULT_SCHEME="$DIR/.settings/colorschemes/catppuccin-mocha.rasi"

mkdir -p "$CACHE_DIR"

# Ensure catppuccin-mocha is always available in the picker
if [[ ! -f "$CACHE_DIR/catppuccin-mocha.rasi" ]]; then
    cp "$DEFAULT_SCHEME" "$CACHE_DIR/catppuccin-mocha.rasi"
fi

# Bootstrap the active cache file if it doesn't exist
if [[ ! -f "$CACHE_FILE" ]]; then
    cp "$DEFAULT_SCHEME" "$CACHE_FILE"
fi

# Build menu: list scheme name ⏎ preview (first few colors)
selected=$( (
    for scheme in "$CACHE_DIR"/*.rasi; do
        name=$(basename "$scheme" .rasi)
        # Extract foreground and accent for a mini preview label
        fg=$(grep 'foreground:' "$scheme" | sed 's/.*#\([0-9A-Fa-f]*\).*/\1/')
        accent=$(grep 'color11:' "$scheme" | sed 's/.*#\([0-9A-Fa-f]*\).*/\1/')
        echo -en "${name}\0info\x1f#${fg}\n"
    done
) | rofi -dmenu -replace -i -p "🎨  Scheme" \
    -config "$ROFI_CONFIG" -format 'i s' 2>/dev/null || true)

if [[ -z "$selected" ]]; then
    exit 0
fi

# Parse the selected index
idx=$(echo "$selected" | awk '{print $1}')
schemes=("$CACHE_DIR"/*.rasi)
chosen="${schemes[$idx]}"

# Apply: copy to cache and notify
cp "$chosen" "$CACHE_FILE"

name=$(basename "$chosen" .rasi)
notify-send -i "/usr/share/icons/kora/actions/24/color-picker.svg" \
    "Color Scheme" "Switched to ${name}"
echo "Applied scheme: ${name}"

# Reload rofi-dependent UIs if possible
if pgrep -x qtile >/dev/null 2>&1; then
    qtile cmd-obj -o cmd -f reload_config 2>/dev/null || true
fi
