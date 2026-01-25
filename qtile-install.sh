#!/bin/bash

# This is how I install Qtile on Ubuntu
# Putting Qtile in it's own environment 
# Source: https://whatacold.io/blog/2019-09-29-how-to-run-the-bleeding-edge-code-of-qtile/

# Install Python
sudo apt-get install xserver-xorg xinit libpangocairo-1.0-0 python3 python3-pip python3-venv python3-xcffib python3-cairocffi python3-tkinter

# Install dependencies for EWW
sudo apt install libglib2.0-dev
sudo apt install libcairo2-dev
sudo apt install libdbusmenu-glib-dev
sudo apt install libatk1.0-dev
sudo apt install libpango1.0-dev
sudo apt install libgdk-pixbuf2.0-dev
sudo apt install libgtk-3-dev
sudo apt install libdbusmenu-gtk3-dev

git clone https://github.com/dylanaraps/pywal
cd pywal
pip3 install .

# Get qtile
mkdir -p ~/Apps/
cd ~/Apps
git clone https://github.com/qtile/qtile.git

cd ~/Apps
git clone https://github.com/elkowar/eww
cargo build --release --no-default-features --features x11
mkdir -p ~/.config/eww
# If building for wayland instead of x11
#cargo build --release --no-default-features --features=wayland
rm -rf ~/.config/eww
ln -s "${HOME}/dotfiles/eww/" ~/.config/eww


# Create and enter python environment
python3 -m venv ~/Apps/qtile/qtile-env/
source ~/Apps/qtile/qtile-env/bin/activate

# Install dependencies
python3 -m pip install xcffib psutil finnhub-python tomlkit
python3 -m pip install --no-cache-dir cairocffi qtile qtile-extras Pillow

# Cache file for holding the current wallpaper
cache_file="$HOME/.cache/current_wallpaper"
rasi_file="$HOME/.cache/current_wallpaper.rasi"
qtile_scrot_dir="$HOME/dotfiles/eww/images/qtile-scrot"

# Create cache file if not exists
if [ ! -f $cache_file ] ;then
    touch $cache_file
    echo "$HOME/wallpapers/default.jpg" > "$cache_file"
fi

# Create rasi file if not exists
if [ ! -f $rasi_file ] ;then
    touch $rasi_file
    echo "* { current-image: url(\"$HOME/wallpapers/default.jpg\", height); }" > "$rasi_file"
fi

# Create qtile-scrot cache dir if not exist
if [ ! -f $qtile_scrot_dir ] ;then
    mkdir -p $qtile_scrot_dir
fi

rm -rf ~/.config/wal
ln -s "${HOME}/dotfiles/wal/" ~/.config/wal
wal -i ~/wallpapers/default.jpg
