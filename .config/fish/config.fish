set -x PATH $HOME/.cargo/bin $PATH

if test -d /usr/bin/core_perl
    set -x PATH /usr/bin/core_perl $PATH
end

set -x PATH $HOME/.config/composer/vendor/bin $PATH
set -x BROWSER google-chrome-stable

# used for the Rust Language Server
set -x RUST_SRC_PATH $HOME/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src

alias dotf "git --git-dir=$HOME/Code/Dotfiles --work-tree=$HOME"
alias swm "bash ~/.config/dm/start_sway"
alias pac "pacaur"
alias up "newsbeuter -r; and pac -Syu"
alias docker "sudo docker"
alias docker-compose "sudo docker-compose"

function fish_greeting
end

# starts the music player daemon and client
function mus
	systemctl --user start mopidy
	ncmpcpp
end

function work
	cd laradock
	sudo docker-compose exec --user=laradock  workspace bash
	cd ..
end

# start sway at login
if status --is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" -eq "1"
        swm
	#startx
    end
end

# OPAM configuration
source /home/chris/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
