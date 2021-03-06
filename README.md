# Things To Install For Ubuntu 18.10 
## Screenshot
![](./screenshots/sample.png)
## Core packages
```
sudo apt-get install rofi
sudo apt-get install compton
sudo apt-get install i3
sudo apt-get install i3blocks
sudo apt-get install lxappearance
sudo apt-get install vim
sudo apt-get install thunar
sudo apt-get install terminator
sudo apt install screenfetch
```
## i3 gaps dependencies
```
sudo apt-get install libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm0 libxcb-xrm-dev automake libxcb-shape0-dev
```
## Install i3 gaps
```
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps
autoreconf --force --install
rm -rf build/
mkdir -p build && cd build/
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make 
sudo make install
```
## Vim plugins
```
git clone https://github.com/jiangmiao/auto-pairs.git ~/.vim/bundle/auto-pairs
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
git clone https://github.com/SirVer/ultisnips.git ~/.vim/bundle/ultilsnips
git clone https://github.com/honza/vim-snippets.git ~/.vim/bundle/vim-snippets
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/morhetz/gruvbox.git ~/.vim/bundle/gruvbox
vim +PluginInstall +qall
```
## Change ubuntu theme
```
/usr/share/gnome-shell/theme/ubuntu.css
```
## Install powerline ( tecmint's instructions )
```
sudo apt-get install python-pip
sudo pip install git+git://github.com/Lokaltog/powerline
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
mv PowerlineSymbols.otf /usr/share/fonts/
fc-cache -vf /usr/share/fonts/
mv 10-powerline-symbols.conf /etc/fonts/conf.d/
pip show powerline-status
```
## Change login screen background  (NOTE: Seems to break the system; Advised against trying)
```
sudo vi /usr/share/gnome-shell/theme/ubuntu.css
\#lockDialogGroup {
background: #2c001e url(file:///home/blankstr13/Pictures/background/background.jpg);
background-position: center;
background-repeat: no-repeat;
background-size: cover; }
```
## Set root password
```
sudo passwd root
```
## Set up rc.local
```
su
echo chmod o+rw /sys/class/backlight/brightness >> rc.local
```
## Natural scroll
```
sudo apt install xinput
- Configuration file located: /usr/share/X11/xorg.conf.d/
- Libinput approach:
    Add { Option "NaturalScrolling" "true" } to /usr/share/X11/xorg.conf.d/40-libinput.conf in the correct InputClass touchpad section
- Synaptics approach:
    Add {Option "VertScrollDelta" "-26"}, and {Option "HorizScrollDelta" "-26"} to {Identifier "touchpad catchall"}.
    - Number represent scroll speed. Lower=faster, Higher=slower.
    - Positive = Inverted Scrolling.
    - Negative = Natural Scrolling.

```

### Setting a static IP
[Guide on how to configure static IP address.](https://linuxize.com/post/how-to-configure-static-ip-address-on-ubuntu-18-04/)

