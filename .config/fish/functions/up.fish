# really simple cross-platform update script for
# all the tools I find important
function up
    switch "$argv"
        case "--inner"
            up_inner
        case ""
            if tmux has-session -t 'update_arch' 2>/dev/null
                tmux -2 attach-session -t 'update_arch'
            else
                tmux start-server
                tmux new-session -d -s 'update_arch' -n 'System Update' 'fish -c "up --inner"'
                tmux -2 attach-session
            end
    end
end


function up_inner
    # run our install script but with the `--update` parameter, which saves
    # time by not reinstalling things that (we hope) are already installed
    install_dotf --autoUpdate

    echo ""
    echo "Press any key to exit..."
    read -n1 -P "" foo
end
