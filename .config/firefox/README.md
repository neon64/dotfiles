# Tabless Firefox!

Parts of this system:
- This [userChrome.css](./userChrome.css) which removes the tab bar and cleans up the address bar slightly (more to come)
- Tabless addon - forces any new tabs to be windows: https://addons.mozilla.org/en-US/firefox/addon/tab-less-addon/
- Script to patch firefox keybindings so that Ctrl+T is a new window instead of new tab (opens faster than opening tabs, and waiting for the tabless addon to convert that to a window.

Why?
- Works well in a tiling window manager, where you can just use the WM's own tab implementation.
- Allows to have a tab bar which contains different applications (e.g. Firefox tabs, PDF viewer tabs, terminal tabs all in one line)
- Better window switching (window swichers show all firefox tabs, because they are now separate windows)

To-do:
- Display tab icons as Firefox window icon (apparently dynamic window icons were possible on X, now difficult under Wayland, may need to write a new protocol for it)
- Remap the ctrl+click link to open in new window (for now, try to use Shift+Click instead, or just wait for the tabless addon to kick in)
