#!/bin/bash

#run xfsettingsd
flameshot &
xfce4-power-manager &
exec /usr/lib/polkit-1/polkit-agent-helper-1 &
exec touchpad-indicator &
sleep .2 && exec /home/zegu/.config/xrandr/mySet.sh &
exec nitrogen --restore &
sleep .2  && pgrep -u $USER -x conky || nohup conky &
exec kdeconnect-indicator &
#exec /usr/lib/gsd-xsettings &

