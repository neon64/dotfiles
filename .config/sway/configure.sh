#!/bin/sh

if grep -q "^flags.*\ hypervisor" /proc/cpuinfo; then
    echo "Running in VM, applying tweaks"
    echo " - Remapping keyboard"
    swaymsg input "*" xkb_options caps:super
    echo " - Switching to gnome-terminal"
    # alacritty is really laggy inside a VM
    swaymsg set '$term' dbus-launch gnome-terminal
else
    echo "Not running in vm"
    echo " - Adding gestures"
    libinput-gestures-setup restart

    # only start up these apps when in actual computer
    systemd-cat -t keepassxc keepassxc &
    systemd-cat -t blueman-applet blueman-applet &
    systemd-cat -t syncthing syncthing-gtk &
    systemd-cat -t kdeconnect /usr/lib/kdeconnectd &
fi

# start mapping tap capslock to escape, and other fancy things
if ! pgrep "evscript"; then
    evscript -f ~/.config/bin/evscript_map.dyon -d /dev/input/event5
fi
