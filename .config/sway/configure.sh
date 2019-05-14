#!/bin/bash

grep -q ^flags.*\ hypervisor /proc/cpuinfo
if [ $? -eq 0 ]; then
    echo "Running in VM, applying tweaks"
    swaymsg input "*" xkb_options caps:super
    # alacritty is really laggy inside a VM
    swaymsg set '$term' dbus-launch gnome-terminal
else
    echo "Not running in vm"
fi

# start mapping tap capslock to escape, and other fancy things
pgrep "evscript"
if [ $? -ne 0 ]; then
    evscript -f ~/.config/bin/evscript_map -d /dev/input/event2 /dev/input/event3 > /tmp/evscript_log
fi
