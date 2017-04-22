# Dotfiles


This repository contains the most important dotfiles that I want replicated between different systems...
Kudos to the extremely simple way of keeping track of dotfiles detailed here: https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/.
I was fed up with having to download yet another fancy bash script, just to do something that Git can do out of the box.

## Getting Started

To add a file to keep track of, just run:

    dotf add path/to/file
    
To commit changes:

    dotf commit -m "Describing the change
    
It's also advised to run the following so that the entire home directory doesn't show up as 'untracked':

    dotf config --local status.showUntrackedFiles no
    
It's exactly like normal Git, just with `git` replaced with the alias `dotf` (defined in `.config/fish/config.fish`)
