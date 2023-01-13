#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap

[ -f $userresources ] && /usr/bin/xrdb -merge $userresources
[ -f $usermodmap ] && /usr/bin/xmodmap $usermodmap

# adjust keyboard
xkbcomp -I$HOME/.config/xkb ~/.config/xkb/map $DISPLAY

# adjust screen size
# XXX it works with sleep, but I don't like this solution
# XXX move to a script
sleep 2

PRIMARY="eDP-1"
PRIMARY_MODE="1920x1080"
SECONDARY_MODE="2560x1440"
SECONDARY=`xrandr --query | grep -v "$PRIMARY" | grep " connected" | cut -d" " -f1`

xrandr --output $PRIMARY --mode "$PRIMARY_MODE" --primary
if [ ! -z "$SECONDARY" ]
then
    xrandr --output $SECONDARY --mode "$SECONDARY_MODE" --above $PRIMARY
fi

# custom key bindings
xbindkeys

unset PINENTRY_USER_DATA

# init pipewire/wireplumber
/usr/bin/pipewire&
/usr/bin/pipewire-pulse&
/bin/wireplumber&

# run i3wm
exec dbus-run-session /usr/bin/i3
