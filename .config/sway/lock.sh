#!/bin/sh -e

# Take a screenshot
swaygrab /tmp/screen_locked.png

# Pixellate it 10x
mogrify -scale 80% -blur 50 -modulate 50 -scale 120% /tmp/screen_locked.png

# Lock screen displaying this image.
swaylock -i /tmp/screen_locked.png

# Turn the screen off after a delay.
#pgrep i3lock && xset dpms force off
