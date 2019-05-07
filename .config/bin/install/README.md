# Dotfiles Install Scripts

These came about as I was switching to another Linux machine and realised there was so much manual setting up that needs to be done to install all the apps and change settings etc... Not all of that can be covered by static textual configuration files (except maybe if I ran NixOS), so I decided to write some install scripts to do it.

## `arch_0`

`arch_0` is like 'step 0' for installing the dotfiles on Arch Linux.

    $ curl "https://raw.githubusercontent.com/neon64/dotfiles/master/.config/bin/install/arch_0" | bash

- for new systems, its designed to be run as root, and will prompt to create a new user account for you and then switch to that account for the rest of the installation.
    - I'm not a fan of completely automated Arch Linux installs, so the idea is that you follow the official [Installation Guide](https://wiki.archlinux.org/index.php/installation_guide) to the end manually. This means you're in charge of all the tricky platform-specific stuff (like partitioning, installing the bootloader, configuring Wi-Fi and graphics drivers). Once that's done, and you're booted into a basic command line with an Internet connection, `arch_0` is ready to do its magic
- for existing systems, you can run as the user you want to install dotfiles for
    - the script is designed to be able to be run multiple times, and any packages you have already installed will just be skipped
- I don't want to start a flame war about the danger of piping curl to bash - you don't have to use this script if you don't want to

So what does `arch_0` actually do?

1. check if you're root and if so either create a new account or ask to switch to an existing standard user account.
    - new accounts are added to the `wheel` group so that they can use `sudo`
2. asks where to install the dotfiles Git repository (default `~/Code/Dotfiles`)
3. switch to the aformentioned user
4. run a `git clone` of the repository and attempts to `git checkout` the dotfiles (*Note:* this will fail if you have existing dotfiles on your system)
5. it does some other miscellaneous stuff like setting up the `dotf` alias, as outlined in the [manual installation guide](https://github.com/neon64/dotfiles/blob/master/.config/README.md#manual-installation)
6. it tries to run `~/.config/bin/install/arch`, which does the rest of the work and is much better structured
7. at the end, you should be able to log back in as that user and have everything working (fish shell, sway, terminal utils etc...)

## Notes from latest install using `arch_0`

This is a collection of remarks and things which didn't quite work the last time I tried to use the install script. So your mileage may vary. On the bright side though, my system never broke completely and I usually just had to manually fix something and then try running `arch_0` again.

- needed to manually install `git` and `base-devel` in order to build packages like `pikaur` (or even just clone the dotfiles in the first place)
- pikaur depends on go which is like 500mb on disk - yuck - I should pick another AUR helper
- there are 10 providers available for ttf-font, which one to choose (I chose `ttf-liberation`)
- graphics drivers - needed to make a selection
- two providers for cargo (rust or rustup)? - need to install rust packages before wm_pkgs since swaylock-blur-git needs Rust - **Fixed**
- vim, missing - had to use `vi` and `nano` for way too long
- `ttf-nanum` failed to install - weird - it worked after clearing cache and reinstalling
- gconftool didn't work to setup a Gnome Terminal theme
- all the icons install with Doom? ** Advice ** (make sure it goes to "~/.local/share/fonts" )
- needed to map some key to `Mod4` so that sway keyboard shortcuts actually worked (I got stuck and had to force-restart)
- needed to install `xorg-server-xwayland` otherwise all xwayland apps were freezing/didn't start in `sway` - **Fixed**
- Firefox is still missing some basic font since websites look a little weird
- needed to set a desktop background

## `arch`

Run

    $ ~/.config/bin/install/arch

to install everything as if from scratch (doing this from time to time is completely safe, it will just skip whatever has already been installed)

You can also update the system with

    $ ~/.config/bin/install/arch --update

This script is split into two general parts. Within each part, basically each
step will ask for your confirmation.

### System

- sets network time syncing
- enables en_US and en_AU locales
- enables colored output in `pacman`

- installs a whole bunch of packages (you can read the
  [source](https://github.com/neon64/dotfiles/blob/master/.config/bin/install/arch)
  for an up to date list)

### User

- Adds theme to Gnome Terminal
- Installs vim and fish plugins
- Links platform specific dotfiles
- Installs Doom for Emacs
- Sets up `dotf` properly
- Sets `fish` as the default shell

## Miscellaneous notes from installing Arch

These don't really have anything to do with my Dotfiles but I'll put them here anyway:

- needed to blacklist nouveau by adding it to /etc/modprobe.d/blacklist -- fixed
  freezes with lspci, reboot etc...
- needed to set a label for partition using `e2label` - then really easy to make
  a config file for `systemd-boot`
- needed to have the EFI system partition mounted inside /mnt/boot so that
  vmlinuz-linux would install properly
- needed to install the intel-ucode package

- needed to run

$ reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\TimeZoneInformation" /v RealTimeIsUniversal /d 1 /t REG_DWORD /f

 on an administrator Command Prompt inside Windows (see the [Arch Wiki
 page](https://wiki.archlinux.org/index.php/System_time)). Otherwise every time
 I rebooted back into Windows the time was messed up.

- switched to using hybrid-sleep on lid close - just in case there seems to be a
 bug with resuming on my laptop - doesn't always work
- install `tlp` and `intel-undervolt` yay

 ### In a virtual machine

Needed to follow the instructions on the [Arch Wiki](https://wiki.archlinux.org/index.php/VirtualBox#Set_optimal_framebuffer_resolution) in order to get a full HD screen working nicely. (still don't know what's going on?)

- tried using [raw disk access](https://www.virtualbox.org/manual/ch09.html#rawdisk) to use a dual-booted Arch installation from Windows. Works well except there's no read access to the EFI system partition (presumably because Windows is using it).
    - this caused me much grief once because I updated the Linux kernel while in the VirtualBox host, which tried to write to `/boot`, which silently failed. Then my kernel version was out of sync with everyting else in the system (e.g.: kernel modules) and everything broke down (couldn't boot because mounting `/boot` failed, unknown filesystem type `vfat`, no Intel graphics drivers??). Booting from the `archiso` and reinstalling `linux` fixed everything though.


