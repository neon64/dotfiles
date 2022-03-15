# Dotfiles

The dotfiles themselves can be found in the [master branch](https://github.com/neon64/dotfiles/tree/master).

![](screenshots/screenshot_terminal.png)
![](screenshots/screenshot_whole_desktop.png)

These dotfiles should theoretically work on any UNIX-like system, including macOS and msys2, both of which I use from time to time. However the greatest compatibility will be with [Arch Linux](https://www.archlinux.org/), which is what I use daily.

## Installation

### Automatic installation

    $ curl "https://raw.githubusercontent.com/neon64/dotfiles/master/.local/bin/dotf_install" | bash

#### What does the install script do?

1. run a `git clone` of the repository and attempts to `git checkout` the dotfiles (*note:* this will fail if you have existing dotfiles on your system)
2. it does some other miscellaneous stuff like setting up the `dotf` alias, as outlined in the [manual installation guide](https://github.com/neon64/dotfiles/blob/master/.config/README.md#manual-installation)
3. it tries to run `~/.local/bin/dotf_setup`, which performs some further setup.
    - On arch & macOS it will try and install some packages for you.
    - Updates are now handled through `topgrade`.
    - Installs fisher & fish plugins
    - Links "platform specific" dotfiles
    - Sets up `dotf` to ignore untracked files
    - Sets `fish` as the default shell
4. at the end, you should be able to log back in as that user and have everything working (fish shell, sway, terminal utils etc...)

### Manual installation

To install these dotfiles manually, only a couple of commands are needed:

    $ alias dotf='/usr/bin/git --git-dir=$HOME/.local/share/dotfiles/ --work-tree=$HOME'
    $ echo ".local/share/dotfiles/" >> .gitignore
    $ git clone --bare --branch master https://github.com/neon64/dotfiles $HOME/.local/share/dotfiles

Then attempt to checkout the configuration files into your home directory:

    $ dotf checkout

You will most likely have to decide what to do with the existing dotfiles on your system.

If `fish` isn't already installed, you'll need to install it now using an
appropriate package manager and also eventually set it as the default shell.

Also update the git repo location used by the script `~/.local/bin/dotf` to point
to wherever you stored the bare dotfiles repository (by default we use `~/.local/share/dotfiles`)

Also run the following to ensure untracked files (i.e.: the rest of your home directory) don't show up when running `dotf` commands.

    $ dotf config --local status.showUntrackedFiles no

### Aside: the problem with installer scripts

Inevitably, things change as people fine-tune their system. Thus, the contents of these install scripts may not reflect what I actually run on my system on a day-to-day basis. Perhaps the only way of permanently fixing this would be to switch to a distribution like NixOS which is entirely configured by configuration files in a stateless manner.

Alas, Arch is more convenient in the short-term, so I think these install scripts will always remain, albeit somewhat half-baked.
### How to edit these dotfiles?

The brilliant benefit of just using plain `git` to manage dotfiles (as detailed [here](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/)), is that making changes is easy.

To stage changes to a file, just run:

    $ dotf add path/to/file

If you want to be fancier and stage everything you've changed:

    $ dotf add -u

Don't ever try `dotf add -A` - It tries to stage everything in your home directory :D

To commit changes:

    $ dotf commit -m "Describing the change"

In conclusion: it's exactly like normal Git, just with `git` replaced with the script `dotf` (which is just a wrapper for git internally)

## About these dotfiles

### Included software

**Window Manager**
 - [sway](https://github.com/swaywm/sway/), as my daily driver when I'm on Linux
    - [waybar](https://github.com/Alexays/Waybar) as the bar, with icons from `ttf-line-awesome`.
    - [wofi](https://hg.sr.ht/~scoopta/wofi) (similar to rofi)
    - [fzf](https://github.com/junegunn/fzf) drives a lot of my config
    - **[my notes](https://github.com/neon64/dotfiles/tree/master/.config/sway)**

**Terminal Emulator & Shell**
 - [alacritty](https://github.com/jwilm/alacritty/), a fast terminal emulator written in Rust.
 - [fish shell](https://fishshell.com/)
   - **[my notes](https://github.com/neon64/dotfiles/tree/master/.config/fish)**
   - [fisherman](https://github.com/fisherman/fisherman) to manage plugins
 - [topgrade](https://github.com/r-darwish/topgrade) to keep everything up-to-date

 - [iTerm 2](https://github.com/gnachman/iTerm2) (on a Mac)
    - **[my notes](https://github.com/neon64/dotfiles/tree/master/.config/iterm2)**

**Editor**
 - Visual Studio Code
 - CLion / Intellij IDEA IDEs
 - [Neovim](https://github.com/neovim/neovim), when I need to use the command line
     - [vim-plug](https://github.com/junegunn/vim-plug) to manage plugins
 - [Doom Emacs](https://github.com/hlissner/doom-emacs)

**Music**
 - Spotify

### Useful scripts

I've found that over time it is easier to write my own shell scripts to do things like enable/disable bluetooth or change wallpapers, as I can tailor those scripts to my particular needs rather than trying to make use of a one-size-fits-all GUI application. That said, this definitely isn't for the faint of heart because these scripts are likely brittle and I am constantly updating them.

 - [browse_files](https://github.com/neon64/dotfiles/blob/master/.config/bin/browse_files): open a graphical file browser, aliased to `b`
 - [browse_web](https://github.com/neon64/dotfiles/blob/master/.config/bin/browse_web): open a URL or search Google
 - [dotf](https://github.com/neon64/dotfiles/blob/master/.config/bin/dotf): manage these dotfiles with git
 - [kbd](https://github.com/neon64/dotfiles/blob/master/.config/bin/kbd): activate us-intl keyboard in sway
 - [launch_util](https://github.com/neon64/dotfiles/blob/master/.config/bin/launch_util): command-line app launcher with fzf (currently unused)
 - [package_sizes](https://github.com/neon64/dotfiles/blob/master/.config/bin/package_sizes): list packages sorted by size
 - [package_orphans](https://github.com/neon64/dotfiles/blob/master/.config/bin/package_orphans): list orphaned packages
 - [switch_res](https://github.com/neon64/dotfiles/blob/master/.config/bin/switch_res): switches resolutions on Sway, aliased to `sr`
 - [theme](https://github.com/neon64/dotfiles/blob/master/.config/bin/theme): changes themes
 - [wpaper](https://github.com/neon64/dotfiles/blob/master/.config/bin/wpaper): change wallpapers for sway and generates a new lockscreen image

### Machine-specific configuration

These dotfiles are complemented by my machine-specific configuration, [arch_machine](https://github.com/neon64/arch_machine), which takes the form of a collection of packages for [Arch Linux](https://www.archlinux.org/). These packages configure the whole system, rather than being specific to one user-account.
