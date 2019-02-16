# dotfiles

Description:
    Backup for existing linux(UBUNTU 16.04) configurations. My i3 configurations closely follows Alex Booker's youtube video at https://www.youtube.com/watch?v=j1I63wGcvU4&list=PL5ze0DjYv5DbCv9vNEzFmP6sU7ZmkGzcf 

Things to install:
    -To change background
    sudo apt-get install feh

    -Replace dmenu with rofi
    sudo apt-get rofi

    -For transparency and fade effect
    sudo apt-get compton

    -Replace i3 bar with i3blocks
    sudo apt-get install i3blocks

    -Get theme changer
    sudo apt-get install lxappearance


Things to do:
   -lxappearance: change into undetected fonts
    1. Change random setting and hit apply
        -gtk file will be created on home dir named ".gtkrc-2.0"
        -gtk dir will also be created in .config file
    2. Manually change font in ".gtkrc-2.0" and "/home/.config/gtkrc-3.0/settings.ini"
        -Replace font with name of desired font in "~/.font" directory
    3. If done correctly, undetected fonts should now appear in lxappearance

Note:
    Changing lights: 
        -xbacklight did not work
        -light script was created instead to control the brightness
            light script:
                -Takes 0-1 argument
                -change brightness to numerical argument given
            *light script writes to /sys/class/backlight/intel_backlight/brightness
                -Unless you are root user, you will have to gain root access 
                 and give yourself executable permission.
            Add following to /etc/rc.local
                chmod 666 /sys/class/backlight/intel_backlight/brightness

    
