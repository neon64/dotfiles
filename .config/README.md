# Dotfiles


This repository contains the most important dotfiles that I want replicated between different systems...
Kudos to the extremely simple way of keeping track of dotfiles detailed here: https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/.
I was fed up with having to download yet another fancy bash script, just to do something that Git can do out of the box.

## Stuff I use

I have one Linux machine and two OS X machines. While these dotfiles contain a lot of stuff pertinent to Linux only (all the WM stuff), I try to ensure that they work universally.

Here's a list in no particular order of the apps I use.

**Window Manager**
 - i3-gaps, for when I want to look cool and transparent
        - [polybar](https://github.com/jaagr/polybar)
        - [rofi](https://github.com/DaveDavenport/rofi)
 - sway, as my daily driver
        - `polybar` doesn't seem to support Wayland at the moment, so I'm using `swaybar` and `i3blocks`
        - `rofi` (sometimes it misses keyboard events)
        - However, on my machine it feels laggier than X+i3. Hopefully the [wlroots](https://github.com/swaywm/wlroots) project will fix it.
 - Gnome is installed, but there just in case and I never really use it

**Terminal**
 - [Alacritty](https://github.com/jwilm/alacritty/), a fast terminal emulator written in Rust, is unfortunately not yet my daily driver because it lacks scrollback
 - Gnome Terminal

**Shell**
 - [Fish shell](https://fishshell.com/)
 - [Fisherman](https://github.com/fisherman/fisherman)

**Editor**
 - Visual Studio Code
 - [Neovim](https://github.com/neovim/neovim), when I need to use the command line
     - [vim-plug](https://github.com/junegunn/vim-plug)

**Browser**
 - Firefox - As a Rust user, I really appreciate all the work that has gone into the 'Quantum' release.
 - Qutebrowser - I like the vim keybindings but my config isn't fully complete yet

**Music**
 - YouTube
 - Mopidy as a backend and then ncmpcpp for a terminal UI

## Installation

To install these dotfiles onto a new machine:

    $ alias dotf='/usr/bin/git --git-dir=$HOME/path/to/dotfiles/ --work-tree=$HOME'
    $ echo "path/to/dotfiles/" >> .gitignore
    $ git clone --bare https://github.com/neon64/dotfiles $HOME/path/to/dotfiles

Then attempt to checkout the configuration files:

    $ dotf checkout

You will most likely have to decide what to do with the existing dotfiles on your system.

Finally, run the install script:

    $ install_dotfiles

## Keeping track of local changes

To stage changes to a file, just run:

    $ dotf add path/to/file

If you want to be fancier and stage everything you've changed:

    $ dotf add -u

Don't ever try `dotf add -A` - It tries to stage everything in your home directory :D

To commit changes:

    $ dotf commit -m "Describing the change

In conclusion: it's exactly like normal Git, just with `git` replaced with the alias `dotf` (defined in `.config/fish/config.fish`)

## Updating your system

To update the system, run:

    $ up

On ArchLinux, this will use `pacaur`, on macOS, it will use `brew`.
It will also update various components (namely language-specific package managers). At the moment this includes:

- Rust (via Rustup)
- `npm` globally-installed packages
- Fisherman & its plugins
- `vim-plug` & its plugins
