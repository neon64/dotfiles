
# dotfile handling
function dotf
    git --git-dir=$HOME/Code/Dotfiles --work-tree=$HOME $argv
end