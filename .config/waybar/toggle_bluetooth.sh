#!/bin/bash

if rfkill -ro Soft list bluetooth | grep -q "^blocked"; then
    rfkill unblock bluetooth
else
    rfkill block bluetooth
fi

sleep 0.05
pkill -SIGRTMIN+8 waybar

# pkill -SIGRTMIN+8 waybar