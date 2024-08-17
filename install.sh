#!/bin/bash

echo "Creating Symlinks"

rm -rf ~/.vimrc
rm -rf ~/.bashrc
rm -rf ~/.config/dunst
rm -rf ~/scripts

dir=$(pwd)

ln -s "${dir}/general/.vimrc" ~/.vimrc
ln -s "${dir}/general/.bashrc" ~/.bashrc
ln -s "${dir}/dunst" ~/.config/dunst
ln -s "${dir}/scripts" ~/scripts

source ~/.bashrc

echo Updating repo
sudo apt-get update -y
sudo apt-get upgrade -y

# Install base apps
echo Installing base apps
sudo apt-get -y install neovim htop keychain fzf vim rofi picom lxappearance vim thunar terminator dunst neofetch vifm conky-all rsync xclip

echo "Installation Completed"

