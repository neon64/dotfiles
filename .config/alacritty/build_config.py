#!/usr/bin/env python
import sys
import os
from os.path import expanduser
home = expanduser("~")

if len(sys.argv) < 2 or sys.argv[1] == '':
    theme_file = open(home + "/.config/colors/current-theme")
    theme = theme_file.read().strip()
    theme_file.close()
else:
    theme = sys.argv[1]

files = ["alacritty", "alacritty_big"]

colors = open(f"{home}/.config/colors/base16-alacritty/colors/{theme}.yml")
color_scheme = colors.read()

for file in files:
    source = open(f"{home}/.config/alacritty/{file}_template.yml")
    dest = open(f"{home}/.config/alacritty/{file}.yml", "w")
    template = source.read()
    result = template.replace("{{color_scheme}}", color_scheme)
    dest.write(result)
    source.close()
    dest.close()

colors.close()
