#!/bin/bash

BLUE="\e[34m"
RESET_FMT="\e[0m"

grep -q ^flags.*\ hypervisor /proc/cpuinfo
if [ $? -eq 0 ]; then
    echo -e "=> ${BLUE}Running in VM, applying tweaks${RESET_FMT}"
    echo " - Remapping keyboard"
    swaymsg input "*" xkb_options caps:super
    echo " - Switching to gnome-terminal"
    # alacritty is really laggy inside a VM
    swaymsg set '$term' dbus-launch gnome-terminal
else
    echo -e " => ${BLUE}Not running in vm${RESET_FMT}"
    echo " - Adding gestures"
    libinput-gestures-setup restart

    # only start up these apps when in actual computer
    systemd-cat -t keepassxc keepassxc &
fi

# start mapping tap capslock to escape, and other fancy things
pgrep "evscript"
if [ $? -ne 0 ]; then
    evscript -f ~/.config/bin/evscript_map -d /dev/input/event2 /dev/input/event3 > /tmp/evscript_log
fi
