# Dotfiles


This repository contains the most important dotfiles that I want replicated
between different systems.


## How is everything tracked?

I just use plain old git and a couple of shell scripts. Kudos to the extremely simple way of keeping track
of dotfiles detailed here:
https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/.

Over time I've found that more and more tools need manual 'installation', so I've written a few extra scripts to install required dependencies / configure the system automatically.

## Installation

### Automatic

If you're on Arch Linux, then I've been working on an installation wizard, `arch_0`, which takes a basic Arch Linux installation and downloads these dotfiles and installs everything needed to make them work.

In short, you just need to run:

    $ curl "https://raw.githubusercontent.com/neon64/dotfiles/master/.config/bin/install/arch_0" | bash

See the [installation guide](https://github.com/neon64/dotfiles/tree/master/.config/bin/install) for more information and caveats.

### Manual

To install these dotfiles onto a new machine:

    $ alias dotf='/usr/bin/git --git-dir=$HOME/path/to/dotfiles/ --work-tree=$HOME'
    $ echo "path/to/dotfiles/" >> .gitignore
    $ git clone --bare https://github.com/neon64/dotfiles $HOME/path/to/dotfiles

Then attempt to checkout the configuration files:

    $ dotf checkout

You will most likely have to decide what to do with the existing dotfiles on your system.

If `fish` isn't already installed, you'll need to install it now using an
appropriate package manager and also eventually set it as the default shell.

If you're on Arch Linux, you can run the following install script to install a whole heap of packages which power my dotfiles (things like `sway`, `firefox` and loads of little things like `ttf-font-waesome` etc...), as well as plugins for `nvim`, `fish` and `emacs`:

    $ ~/.config/bin/install/arch

If you're not on Arch Linux, I'm afraid I don't have an all-in-one solution yet. However, try taking a look inside of `~/.config/bin/install/common` for some bits you will be able to run.

Also update the git repo location used by the script `~/.config/dotf` to point
to wherever you stored the bare dotfiles repository (default is
`~/Code/Dotfiles`)

Also run the following to ensure untracked files (i.e.: the rest of your home directory) don't show up when running `dotf` commands.

    $ dotf config --local status.showUntrackedFiles no

## Chosen tools

I have one Linux machine and two OS X machines. While these dotfiles contain a
lot of stuff pertinent to Linux only (all the WM stuff), I try to ensure that
they work universally.

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

## Keeping track of local changes

To stage changes to a file, just run:

    $ dotf add path/to/file

If you want to be fancier and stage everything you've changed:

    $ dotf add -u

Don't ever try `dotf add -A` - It tries to stage everything in your home directory :D

To commit changes:

    $ dotf commit -m "Describing the change"

In conclusion: it's exactly like normal Git, just with `git` replaced with the
alias `dotf` (defined in `.config/fish/config.fish`)

## Updating your system

To update the system, run:

    $ up

On Arch Linux, this will use `pikaur`, on macOS, it will use `brew`. It will also
update various components (namely language-specific package managers). At the
moment this includes:

- Rust (via Rustup)
- `npm` globally-installed packages
- Fisherman & its plugins
- `vim-plug` & its plugins
