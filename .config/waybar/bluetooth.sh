#!/bin/bash

# inspired by:
# https://github.com/tardypad/dotfiles/blob/484131edf98517b3a95df8fdb39ef980cdfc95a4/files/scripts/i3blocks/i3blocks-bluetooth

if rfkill -ro Soft list bluetooth | grep -q "^blocked"; then
    TEXT='blocked'
elif ! systemctl is-active --quiet bluetooth; then
    TEXT='disabled'
else
    CONNECTED_DEVICES=$(
    bluetoothctl paired-devices \
        | cut -d' ' -f2 \
        | xargs -I{} bluetoothctl info {} \
        | sed -n -e 's/.*Alias: \(.*\)/\1/p' -e 's/.*Connected: \(.*\)/\1/p' \
        | paste - - \
        | sed -n 's/\(.*\)\tyes$/\1/p' \
        | paste -sd,
    )

    if [ -z "${CONNECTED_DEVICES}" ]; then
        TEXT='none'
    else
        TEXT="${CONNECTED_DEVICES}"
    fi
fi


printf '%s\n' "${TEXT}"