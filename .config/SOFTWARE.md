# Chosen software

Just in case anybody is interested, here is a little summary of some of the other open source projects I use in my setup.

I have one Linux machine and two macOS machines. While these dotfiles contain a
lot of stuff pertinent to Linux only (all the WM stuff), I try to ensure that
they work universally. Update: I haven't been testing on an macOS machine for ages, so things are likely to be broken.

Here's a list in no particular order of the apps I use.

**Window Manager**
 - sway, as my daily driver when I'm on Linux
        - `waybar` as the bar, with icons from `otf-font-awesome`.
        - `rofi` - as of sway 1.0 it works really nicely (except perhaps window switching)
        - `fzf` drives a lot of my config
 - On my old machine I had Gnome installed, just in case. There's nothing in my
   dotfiles really specific to Gnome though.
        - I have a selection of apps, `gnome_apps`, which can be optionally installed.
          I find them useful when I just need a no-frills utility e.g.: system monitor.

**Terminal**
 - [Alacritty](https://github.com/jwilm/alacritty/), a fast terminal emulator written in Rust.
   - Now has scrollback, and has become my daily driver
   - Unfortunately it's performance inside a virtual machine seems somewhat lacklustre so I've been using Gnome Terminal a bit
 - Gnome Terminal

**Shell**
 - [Fish shell](https://fishshell.com/)
 - [Fisherman](https://github.com/fisherman/fisherman)

**Editor**
 - Visual Studio Code
 - [Neovim](https://github.com/neovim/neovim), when I need to use the command line
     - [vim-plug](https://github.com/junegunn/vim-plug)
     - I'm now trying to learn vim as a primary text editor. Hopefully it works out.
- Emacs with [Doom Emacs](https://github.com/hlissner/doom-emacs) config
     - seems slightly more fancy than Vim, and I love SPC keybindings + Evil Mode

**Browser**
 - Firefox - As a Rust user, I really appreciate all the work that has gone into
   the 'Firefox Quantum' release, and I also am wary of Google achieving a
   monopoly over the web with Chrome/Blink
    - with a custom `userChrome.css` it looks quite spectacular
 - <strike>Qutebrowser</strike>
    - haven't used for ages
    - I liked the vim keybindings but my config isn't fully complete yet

**Music**
 - YouTube (including mps-youtube in terminal)
 - <strike>Mopidy as a backend and then ncmpcpp for a terminal UI</strike>
    - having issues with this setup at the moment (YouTube and Google Play Music backends aren't very mature)
    - Switched to `mpd` - can now use `ncmpcpp` visualizer, or `cava`

