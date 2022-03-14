#!/usr/bin/env python
import sys
import os
from os.path import expanduser
home = expanduser("~")

files = ["alacritty", "alacritty_big"]

colors = open(f"{home}/.cache/wal/colors-alacritty.yml")
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

print("Build alacritty config")