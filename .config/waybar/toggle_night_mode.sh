#!/bin/sh

if pgrep wlsunset > /dev/null; then
    pkill wlsunset
else
    wlsunset &
fi

sleep 0.05
pkill -SIGRTMIN+9 waybar