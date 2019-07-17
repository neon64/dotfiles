# Dotfiles

This repository contains the dotfiles which I want replicated
between different systems.

Take a look at the [software](https://github.com/neon64/dotfiles/tree/master/.config/SOFTWARE.md) that I use for a preview of what's included.

These dotfiles are complemented by my machine-specific configuration, [arch_machine](https://github.com/neon64/arch_machine). That said, the dotfiles should theoretically work on any UNIX-like system, including macOS, which I use from time to time. I just don't have the time to write i.e.: an installer script for other platforms, so your mileage may vary.

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

There is also a helper fish function called `check_dotf` which you can run that automates the process of keeping dotfiles in sync.

## Updating your system

To update the system, run:

    $ up

On Arch Linux, this will use `pikaur`, on macOS, it will use `brew`.

Various other components are also updated:

- Rust (via Rustup)
- `npm` globally-installed packages
- Fisherman & its plugins
- `vim-plug` & its plugins
