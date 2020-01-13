## Installation
```
Execute ./install
```
## Set up rc.local (To ensure the ./Scripts/light works properly)
```
su
echo chmod o+rw /sys/class/backlight/brightness >> rc.local
```
## Natural scroll
```
Add { Option "NaturalScrolling" "true" } to /usr/share/X11/xorg.conf.d/40-libinput.conf in the correct InputClass touchpad section
```


