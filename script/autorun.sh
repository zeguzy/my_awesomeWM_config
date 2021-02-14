#!/usr/bin/env bash

## run (only once) processes which spawn with the same name
function run {
   if (command -v $1 && ! pgrep $1); then
     $@&
   fi
}

## run (only once) processes which spawn with different name
if (command -v gnome-keyring-daemon && ! pgrep gnome-keyring-d); then
    gnome-keyring-daemon --daemonize --login &
fi
if (command -v start-pulseaudio-x11 && ! pgrep pulseaudio); then
    start-pulseaudio-x11 &
fi
if (command -v /usr/lib/mate-polkit/polkit-mate-authentication-agent-1 && ! pgrep polkit-mate-aut) ; then
    /usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &
fi

~/.config/awesome/arandr.sh
run nitrogen --restore 
run nm-applet
run light-locker
#run xcape -e 'Super_L=Super_L|Control_L|Escape'
run thunar --daemon
run pamac-tray
run flameshot
#run compton --shadow-exclude '!focused'
run compton
run blueman-applet
run msm_notifier
run conky
run mate-power-manager
run fcitx5
run pa-applet
run ppet
run utools
run touchpad-indicator
#run indicator-china-weather
## The following are not included in minimal edition by default
## but autorun.sh will pick them up if you install them

if (command -v system-config-printer-applet && ! pgrep applet.py ); then
  system-config-printer-applet &
fi
