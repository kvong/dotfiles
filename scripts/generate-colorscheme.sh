#!/bin/bash
# generate-colorscheme.sh — extract a 16-color palette from an image
# Usage: ./generate-colorscheme.sh <image-path> [output-name]
#
# Writes a .rasi color scheme file to ~/.config/rofi/colorschemes/
# Falls back to catppuccin-mocha if no image or extraction fails.

set -euo pipefail

DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi

SCHEMES_DIR="$HOME/.cache/rofi/colorschemes"
CACHE_FILE="$HOME/.cache/colorscheme.rasi"
mkdir -p "$SCHEMES_DIR"

# Default fallback
catppuccin_file="${DIR}/../.settings/colorschemes/catppuccin-mocha.rasi"

image="${1:-}"
name="${2:-}"

if [[ -z "$image" || ! -f "$image" ]]; then
    echo "No image provided — copying default Catppuccin Mocha"
    cp "$catppuccin_file" "$CACHE_FILE"
    echo "$CACHE_FILE"
    exit 0
fi

if [[ -z "$name" ]]; then
    name=$(basename "$image")
    name="${name%.*}"
fi

output="$SCHEMES_DIR/${name}.rasi"

# --- Extract color palette using ImageMagick ---
# Resize to 200px for speed, then extract 16 most representative colors
mapfile -t hex_colors < <(
    convert "$image" -resize 200x200 -colors 16 -depth 8 +dither \
        -format '%c' histogram:info:- 2>/dev/null | \
        sort -rn | head -16 | \
        sed -n 's/.*#\([0-9A-Fa-f]\{6\}\).*/\1/p'
)

if [[ ${#hex_colors[@]} -lt 16 ]]; then
    echo "Warning: only ${#hex_colors[@]} colors extracted, padding with defaults"
    # Pad with greys if we got fewer than 16
    fallback_colors=( "#313244" "#45475a" "#585b70" "#6c7086" "#7f849c" "#9399b2" "#a6adc8" "#bac2de" )
    idx=0
    while [[ ${#hex_colors[@]} -lt 16 ]]; do
        hex_colors+=( "${fallback_colors[$idx]}" )
        idx=$(( (idx + 1) % ${#fallback_colors[@]} ))
    done
fi

# Sort colors by luminance (darkest first) for a coherent palette
sorted=()
for hex in "${hex_colors[@]}"; do
    r=$((16#${hex:0:2}))
    g=$((16#${hex:2:2}))
    b=$((16#${hex:4:2}))
    # Perceived luminance
    lum=$(echo "0.299*$r + 0.587*$g + 0.114*$b" | bc)
    sorted+=("$lum|$hex")
done

IFS=$'\n' sorted=($(printf "%s\n" "${sorted[@]}" | sort -t'|' -k1 -n))
unset IFS

colors=()
for entry in "${sorted[@]}"; do
    colors+=("${entry##*|}")
done

bg="${colors[0]}"
fg="${colors[15]}"

# Pick accent from mid-range (most saturated color in the middle 8)
accent="${colors[8]}"
best_sat=0
for i in $(seq 4 11); do
    hex="${colors[$i]}"
    r=$((16#${hex:0:2}))
    g=$((16#${hex:2:2}))
    b=$((16#${hex:4:2}))
    max=$r; min=$r
    [[ $g -gt $max ]] && max=$g; [[ $g -lt $min ]] && min=$g
    [[ $b -gt $max ]] && max=$b; [[ $b -lt $min ]] && min=$b
    sat=$(( (max - min) * 100 / (max + 1) ))
    if [[ $sat -gt $best_sat ]]; then
        best_sat=$sat
        accent="$hex"
    fi
done

# Write the .rasi file (both to scheme dir for future use, and to cache for immediate effect)
cat > "$output" << EOF
/* Auto-generated scheme from ${image} */
* {
    background: rgba($((16#${bg:0:2})),$((16#${bg:2:2})),$((16#${bg:4:2})),0.92);
    foreground: #${fg};

    color0:     #${colors[0]};
    color1:     #${colors[8]};
    color2:     #${colors[4]};
    color3:     #${colors[6]};
    color4:     #${colors[10]};
    color5:     #${colors[12]};
    color6:     #${colors[14]};
    color7:     #${fg};
    color8:     #${colors[1]};
    color9:     #${colors[9]};
    color10:    #${colors[5]};
    color11:    #${accent};
    color12:    #${colors[11]};
    color13:    #${colors[13]};
    color14:    #${colors[7]};
    color15:    #${fg};
}
EOF

# Also update the active cache file (in case this was called directly)
cp "$output" "$CACHE_FILE"

# Sync to Alacritty
"$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/sync-alacritty-colorscheme.sh" 2>/dev/null || true

echo "$output"
