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
    echo "- Adding gestures"
    libinput-gestures-setup restart

    sleep 1
    echo "- Starting up startup apps"
    # only start up these apps when running on an actual system
    pgrep "keepassxc" || systemd-cat -t keepassxc keepassxc &
    pgrep "blueman-applet" || systemd-cat -t blueman-applet blueman-applet &
    pgrep "syncthing-gtk" ||  systemd-cat -t syncthing syncthing-gtk &
fi

# start mapping tap capslock to escape, and other fancy things
# if ! pgrep "evscript"; then
#     evscript -f ~/.config/bin/evscript_map.dyon -d /dev/input/event5
# fi
