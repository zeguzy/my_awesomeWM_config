#!/bin/bash

#run xfsettingsd

pamac-tray &
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
fcitx & 
flameshot &
xfce4-power-manager &
exec /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
exec touchpad-indicator &
sleep .2 && exec /home/zegu/.config/xrandr/myset.sh &
exec nitrogen --restore &
sleep .2  && pgrep -u $USER -x conky || nohup conky &
exec kdeconnect-indicator &
#exec /usr/lib/gsd-xsettings &

