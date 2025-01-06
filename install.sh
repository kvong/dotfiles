#!/bin/bash

sudo apt-add-repository ppa:fish-shell/release-3

echo Updating repo
sudo apt-get update -y
sudo apt-get upgrade -y

# Install base apps
echo Installing base apps
sudo apt-get -y install neovim htop keychain fzf vim rofi picom lxappearance vim thunar terminator dunst neofetch vifm conky-all rsync xclip fd-find ripgrep eza scrot tmux bat zoxide fish golang-go

# Install fisher - fish shell plugin manager
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

# Install batcat
mkdir -p ~/.local/bin
cp /usr/bin/batcat ~/.local/bin/bat

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install starship
curl -sS https://starship.rs/install.sh | sh

# Installing .tmux
rm -rf ~/.config/tmux/tmux.conf "${HOME}/.config/tmux/oh-my-tmux"
mkdir -p "${HOME}/.config/tmux"
git clone https://github.com/gpakosz/.tmux.git "${HOME}/.config/tmux/oh-my-tmux"
ln -s "${HOME}/.config/tmux/oh-my-tmux/.tmux.conf" ~/.config/tmux/tmux.conf

echo "Creating Symlinks"

rm -rf ~/.vimrc
rm -rf ~/.bashrc
rm -rf ~/.xinitrc
rm -rf ~/.tmux.conf
rm -rf ~/.config/tmux/tmux.conf.local
rm -rf ~/.config/dunst
rm -rf ~/scripts
rm -rf ~/.config/qtile
rm -rf ~/.config/rofi
rm -rf ~/.config/nvim
rm -rf ~/.config/terminator
rm -rf ~/.config/alacritty
rm -rf ~/.config/fish
rm -rf ~/wallpapers

dir=$(pwd)

cp -r ${dir} ~/

ln -s "${HOME}/dotfiles/general/vimrc" ~/.vimrc
ln -s "${HOME}/dotfiles/general/bashrc" ~/.bashrc
ln -s "${HOME}/dotfiles/general/xinitrc" ~/.xinitrc
ln -s "${HOME}/dotfiles/tmux/tmux.conf" ~/.config/tmux/tmux.conf.local
ln -s "${HOME}/dotfiles/dunst" ~/.config/dunst
ln -s "${HOME}/dotfiles/scripts" ~/scripts
ln -s "${HOME}/dotfiles/qtile" ~/.config/qtile
ln -s "${HOME}/dotfiles/rofi" ~/.config/rofi
ln -s "${HOME}/dotfiles/nvim" ~/.config/nvim
ln -s "${HOME}/dotfiles/terminator" ~/.config/terminator
ln -s "${HOME}/dotfiles/alacritty" ~/.config/alacritty
ln -s "${HOME}/dotfiles/wallpapers" ~/wallpapers
ln -s "${HOME}/dotfiles/fish" ~/.config/fish

source ~/.bashrc

# Install Fabric directly from the repo
go install github.com/danielmiessler/fabric@latest

# Set fish shell as default shell
sudo chsh -s $(which fish)

echo "Installation Completed"
echo "Don't forget to run 'fabric --setup' to setup fabric."
fish

