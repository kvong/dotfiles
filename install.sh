#!/bin/bash

echo "Creating Symlinks"

rm -rf ~/.vimrc
rm -rf ~/.bashrc
rm -rf ~/.config/dunst
rm -rf ~/scripts
rm -rf ~/.config/qtile
rm -rf ~/.config/rofi
rm -rf ~/.config/nvim

dir=$(pwd)

cp -r ${dir} ~/

ln -s "${HOME}/dotfiles/general/.vimrc" ~/.vimrc
ln -s "${HOME}/dotfiles/general/.bashrc" ~/.bashrc
ln -s "${HOME}/dotfiles/dunst" ~/.config/dunst
ln -s "${HOME}/dotfiles/scripts" ~/scripts
ln -s "${HOME}/dotfiles/qtile" ~/.config/qtile
ln -s "${HOME}/dotfiles/rofi" ~/.config/rofi
ln -s "${HOME}/dotfiles/nvim" ~/.config/nvim

source ~/.bashrc

echo Updating repo
sudo apt-get update -y
sudo apt-get upgrade -y

# Install base apps
echo Installing base apps
sudo apt-get -y install neovim htop keychain fzf vim rofi picom lxappearance vim thunar terminator dunst neofetch vifm conky-all rsync xclip fd-find ripgrep eza

# Install starship
curl -sS https://starship.rs/install.sh | sh


echo "Installation Completed"

