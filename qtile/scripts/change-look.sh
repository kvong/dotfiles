#!/bin/bash
# change-look.sh — rofi menu to change wallpaper or color scheme
# Presents two options and dispatches to the appropriate script.

set -euo pipefail

home_dir="$HOME"
dotfiles="$home_dir/dotfiles"

# Rofi config for a compact menu
ROFI_CONFIG="$dotfiles/rofi/config-change-look.rasi"

# Build the menu
selected=$(printf '  Change Wallpaper\n  Change Color Scheme\n' | \
    rofi -dmenu -replace -i -p "Look" \
    -config "$ROFI_CONFIG" \
    -l 2 2>/dev/null || true)

if [[ -z "$selected" ]]; then
    exit 0
fi

# Small delay to let the mouse button fully release
# before the next dmenu window opens
sleep 0.2

case "$selected" in
    *"Change Wallpaper"*)
        # Change Wallpaper
        "$dotfiles/qtile/scripts/wallpaper.sh" select
        ;;
    *"Change Color Scheme"*)
        # Change Color Scheme
        "$dotfiles/scripts/pick-colorscheme.sh"
        ;;
esac
