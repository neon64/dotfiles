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

with open(f"{home}/.config/colors/base16-wofi/themes/{theme}.css") as colors, open(f"{home}/.config/wofi/style.template.css") as source, open(f"{home}/.config/wofi/style.css", "w") as dest:
        color_scheme = colors.read()
        template = source.read()
        result = template.replace("{{color_scheme}}", color_scheme)
        dest.write(result)
