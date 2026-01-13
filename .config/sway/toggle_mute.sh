#!/bin/sh

pamixer -t
if pamixer --get-mute | grep -q "false"; then
    pamixer --get-volume >> $SWAYSOCK.wob
else
    echo 0 >> $SWAYSOCK.wob
fi