# Things To Install For Ubuntu 18.04 

## Core packages
...

sudo apt-get install rofi

sudo apt-get install compton

sudo apt-get install i3

sudo apt-get install i3blocks

sudo apt-get install lxappearance

sudo apt-get install vim

sudo apt-get install thunar

sudo apt install screenfetch

...

## i3 gaps dependencies
...

sudo apt-get install libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm0 libxcb-xrm-dev automake libxcb-shape0-dev

...

## Install i3 gaps
...

git clone https://www.github.com/Airblader/i3 i3-gaps

cd i3-gaps

autoreconf --force --install

rm -rf build/
mkdir -p build && cd build/

../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers

make 

sudo make install

...


## Change ubuntu theme
...

/usr/share/gnome-shell/theme/ubuntu.css

...

## Install powerline
...

sudo apt-get install python-pip

pip install git+git://github.com/Lokaltog/powerline

wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf

wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf

mv PowerlineSymbols.otf /usr/share/fonts/

fc-cache -vf /usr/share/fonts/

mv 10-powerline-symbols.conf /etc/fonts/conf.d/

pip show powerline-status

...

## Change login screen background
...

sudo vi /usr/share/gnome-shell/theme/ubuntu.css

\#lockDialogGroup {

background: #2c001e url(file:///home/blankstr13/Pictures/background/background.jpg);

background-position: center;

background-repeat: no-repeat;

background-size: cover; }

...


