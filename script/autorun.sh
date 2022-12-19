#!/usr/bin/env bash

## run (only once) processes which spawn with the same name
function run {
   if (command -v $1 && ! pgrep  -u $USER $1); then
     $@&
   fi
}

## run (only once) processes which spawn with different name
# if (command -v gnome-keyring-daemon && ! pgrep gnome-keyring-d); then
#     gnome-keyring-daemon --daemonize --login &
# fi

if (command -v start-pulseaudio-x11 && ! pgrep pulseaudio); then
    start-pulseaudio-x11 &
fi
if (command -v /usr/lib/mate-polkit/polkit-mate-authentication-agent-1 && ! pgrep polkit-mate-aut) ; then
    /usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &
fi

run utools 
#~/.config/awesome/script/arandr.sh
#run nitrogen --restore 
run variety
run firewall-applet 
run nm-applet
# run light-locker
run pulseaudio -k
run pulseaudio --start -D
# run xcape -e 'Super_L=Super_L|Control_L|Escape'
run thunar --daemon
run pamac-tray
run flameshot
#run compton --shadow-exclude '!focused'
run picom
run blueman-applet
# run msm_notifier
run mate-power-manager
run fcitx
run pa-applet
run clipit
run xautolock -time 10 -locker blurlock
#run polybar
#run ppet
# run picom
# run  plank
run touchpad-indicator
# run conky
run xbindkeys -f ./xbindkeysrc
run libinput-gestures -c  ./gersturesrc
#run indicator-china-weather
## The following are not included in minimal edition by default
## but autorun.sh will pick them up if you install them

if (command -v system-config-printer-applet && ! pgrep applet.py ); then
  system-config-printer-applet &
fi

