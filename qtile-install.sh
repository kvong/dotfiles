#!/bin/bash

# This is how I install Qtile on Ubuntu
# Putting Qtile in it's own environment 
# Source: https://whatacold.io/blog/2019-09-29-how-to-run-the-bleeding-edge-code-of-qtile/

# Install Python
sudo apt-get install xserver-xorg xinit libpangocairo python3 python3-pip python3-venv python3-xcffib python3-cairocffi

# Install dependencies
python3 -m pip install xcffib psutil finnhub-python
python3 -m pip install --no-cache-dir cairocffi

# Get qtile
mkdir -p ~/Apps/
cd ~/Apps
git clone https://github.com/qtile/qtile.git

# Create and enter python environment
python3 -m venv ~/Apps/qtile/qtile-env/
source ~/Apps/qtile/qtile-env/bin/activate
