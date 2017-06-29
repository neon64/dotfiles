# remove the Ctrl-D shortcut, because it conflicts with our "disconnect" shortcut in tmux
function fish_user_key_bindings
    bind -e \cd
end
