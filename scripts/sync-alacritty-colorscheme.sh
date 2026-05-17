#!/bin/bash
# sync-alacritty-colorscheme.sh — apply the active rofi scheme to Alacritty
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
python3 "$DIR/alacritty/update_alacritty_colors.py"
