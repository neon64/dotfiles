
function fish_user_key_bindings
    # remove the Ctrl-D shortcut, because it conflicts with our "disconnect" shortcut in tmux
    bind -e \cd

    # only init fzf key bindings if they are installed
    if type -q "fzf_key_bindings"
        fzf_key_bindings
    else
        echo -e (set_color red)"\nWarning: `fzf` not installed, fuzzy searching shortcuts disabled."(set_color normal)
    end

    set -g fish_escape_delay_ms 50
    fish_vi_key_bindings 

    # useful crossovers from emacs
    bind \cA -M insert beginning-of-line
    bind \cE -M insert end-of-line
    # mash Ctrl+H to go home
    bind \cH -M insert cd "echo -e \n\n" "commandline -f repaint" 
end
