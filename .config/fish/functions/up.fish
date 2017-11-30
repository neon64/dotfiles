# really simple cross-platform update script for
# all the tools I find important
function up
    SESSION_NAME='update_arch'
    tmux start-server
    switch (uname)
    	case Linux
            echo "Linux"
            # read Arch news before updating:
    		tmux new-session -d -n 'System Update' -s 'update_arch' 'newsboat -r; pac -Syu; fish'
            tmux split-window -h 'rustup update; fish'
            tmux split-window -v 'sudo npm update -g; fish'
        case Darwin
            echo "Darwin"
		    tmux new-session -d -n 'System Update' -s 'update_mac' 'brew update; and brew upgrade; fish'
            tmux split-window -h 'rustup update; fish'
            tmux split-window -v 'npm update -g; fish'
        case  '*'
		    echo "Unknown OS"
	end
    # tmux -2 attach-session
end