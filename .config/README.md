# Dotfiles


This repository contains the most important dotfiles that I want replicated between different systems...
Kudos to the extremely simple way of keeping track of dotfiles detailed here: https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/.
I was fed up with having to download yet another fancy bash script, just to do something that Git can do out of the box.

## Prerequisites

**Shell**
 - [Fish shell](https://fishshell.com/)
 - [Fisherman](https://github.com/fisherman/fisherman)

** Editor **
 - [Neovim](https://github.com/neovim/neovim)
 - [vim-plug](https://github.com/junegunn/vim-plug)

## Installation

To install these dotfiles onto a new machine:

    $ alias dotf='/usr/bin/git --git-dir=$HOME/path/to/dotfiles/ --work-tree=$HOME'
    $ echo "path/to/dotfiles/" >> .gitignore
    $ git clone --bare https://github.com/neon64/dotfiles $HOME/path/to/dotfiles

Then attempt to checkout the configuration files:

    $ dotf checkout

You will most likely have to decide what to do with the existing dotfiles on your system.

It's also advised to run the following so that the entire home directory doesn't show up as 'untracked':

    $ dotf config --local status.showUntrackedFiles no

## Keeping track of local changes

To stage changes to a file, just run:

    $ dotf add path/to/file

If you want to be fancier and stage everything you've changed:

    $ dotf add -u

Don't ever try `dotf add -A` - It tries to stage everything in your home directory :D

To commit changes:

    $ dotf commit -m "Describing the change

In conclusion: it's exactly like normal Git, just with `git` replaced with the alias `dotf` (defined in `.config/fish/config.fish`)
