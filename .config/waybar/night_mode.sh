#!/bin/sh

if pgrep wlsunset > /dev/null; then
    echo '{"text": "", "tooltip": "Click to deactivate night mode", "class": "activated"}'
else
    echo '{"text": "", "tooltip": "Click to activate night mode" }'
fi