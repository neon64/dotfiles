# Sway configuration

## Getting Zoom whiteboard annotation to work

Doesn't.

## Getting Zoom screensharing to work

### "Contents of 2nd camera"

see contents of [~/.config/bin/share_screen](../bin/share_screen).

###

https://gitlab.com/jamedjo/gnome-dbus-emulation-wlr/-/issues/1

says you need to put

```
[AS]
showframewindow=false
```

in `~/.config/zoomus.conf`.

To start all the necessary services:

```
$ ~/code/gnome-dbus-emulation-wlr/gnome_dbus_emulation.rb ~/code/gnome-dbus-emulation-wlr/grim.sh
```

-- didn't work with these:
```
$ env XDG_CURRENT_DESKTOP=sway /usr/lib/xdg-desktop-portal -r
$ /usr/lib/xdg-desktop-portal-wlr -l TRACE
```

To launch Zoom:

```
$ env XDG_SESSION_TYPE=wayland XDG_CURRENT_DESKTOP=GNOME zoom
```