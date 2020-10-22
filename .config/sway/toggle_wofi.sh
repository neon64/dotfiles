#!/bin/sh

if ! pkill wofi; then
    wofi --show drun --width=700 --prompt= --no-actions --height=300 --allow-images
fi