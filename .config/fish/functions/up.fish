# really simple cross-platform update script for
# all the tools I find important
function up
    switch (echo $argv)
        case "--system"
            update_system
        case "--pieces"
            update_pieces
        case ""
            tmux start-server
            tmux new-session -d -n 'System Update' -s 'update_arch' 'fish -c "up --system"; fish'
            tmux split-window -h 'fish -c "up --pieces"; fish'
            tmux -2 attach-session
    end
end

function update_system
    switch (uname)
        case Linux
            echo (set_color yellow) "Updating using pacaur..." (set_color normal)
            # read Arch news before updating with pacaur:
            newsboat -r
            pac -Syu
        case Darwin
            echo (set_color yellow) "Updating using Homebrew..." (set_color normal)
            brew update; and brew upgrade;
        case '*'
            echo "Unknown OS"
    end
end

function update_pieces
    echo (set_color yellow) "Updating Rust..." (set_color normal)
    rustup update

    echo (set_color yellow) "Updating global npm packages..." (set_color normal)
    switch (uname)
        case Linux
            sudo npm update -g
        case Darwin
            # through homebrew, so npm shouldn't need root perms
            npm update -g
        case *
            echo "Unknown OS"
    end

    # though this is technically an 'install' script, it won't hurt if we run it again to 
    # update various things eg: fish/vim plugins.
    install_dotfiles
end