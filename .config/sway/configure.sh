#!/bin/bash

grep -q ^flags.*\ hypervisor /proc/cpuinfo 
if [ $? -eq 0 ]; then
    echo "Running in VM, applying tweaks"
    swaymsg input "*" xkb_options caps:super
    # alacritty is really laggy inside a VM
    swaymsg set '$term' gnome-terminal
else
    echo "Not running in vm"
fi
