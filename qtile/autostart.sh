#!/bin/bash

rm ~/dotfiles/eww/images/qtile-scrot/*
scrot -q 10 ~/dotfiles/eww/images/qtile-scrot/q.jpg
cp ~/dotfiles/eww/images/qtile-scrot/q.jpg ~/dotfiles/eww/images/qtile-scrot/w.jpg
cp ~/dotfiles/eww/images/qtile-scrot/q.jpg ~/dotfiles/eww/images/qtile-scrot/e.jpg
cp ~/dotfiles/eww/images/qtile-scrot/q.jpg ~/dotfiles/eww/images/qtile-scrot/r.jpg
cp ~/dotfiles/eww/images/qtile-scrot/q.jpg ~/dotfiles/eww/images/qtile-scrot/a.jpg
cp ~/dotfiles/eww/images/qtile-scrot/q.jpg ~/dotfiles/eww/images/qtile-scrot/s.jpg
cp ~/dotfiles/eww/images/qtile-scrot/q.jpg ~/dotfiles/eww/images/qtile-scrot/z.jpg

dunst &
keychain &
alacritty &
brave-browser &
picom &
