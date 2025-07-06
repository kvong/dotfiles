#!/bin/bash

rm ~/dotfiles/eww/images/*
scrot -q 10 ~/dotfiles/eww/images/q.jpg
cp ~/dotfiles/eww/images/q.jpg ~/dotfiles/eww/images/w.jpg
cp ~/dotfiles/eww/images/q.jpg ~/dotfiles/eww/images/e.jpg
cp ~/dotfiles/eww/images/q.jpg ~/dotfiles/eww/images/a.jpg
cp ~/dotfiles/eww/images/q.jpg ~/dotfiles/eww/images/s.jpg
cp ~/dotfiles/eww/images/q.jpg ~/dotfiles/eww/images/z.jpg
dunst &
keychain &
alacritty &
brave-browser &
picom &
scrot -q 10 ~/dotfiles/eww/images/q.jpg
