# really simple cross-platform update script for
# all the tools I find important
function up
    switch (echo $argv)
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
    switch (uname)
        case "Darwin"
            # note: this is a major regression
            echo "No update script yet..."
        case "Linux"
            switch (uname -r)
                case "*ARCH*"
                    # run our install script but with the `--update` parameter, which saves
                    # time by not reinstalling things that (we hope) are already installed
                    # note, there's no technical reason why this stuff shouldn't work on 
                    bash ~/.config/bin/install/arch --update
                case *
                    echo "Unsupported Linux distro"
                    echo "Note: there's no technical reason why this update script doesn't work across all Linuxes, I just can't be bothered supporting more than Arch. So feel free to run it yourself." 
            end
    end

    echo ""
    echo ""
    echo "Press any key to exit..."
    read -n1 -P "" foo
    echo "Done..."
end
