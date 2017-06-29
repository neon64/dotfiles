### ========================================
###					PATH
### ========================================

set -x PATH $HOME/.cargo/bin $PATH

if test -d /usr/bin/core_perl
    set -x PATH /usr/bin/core_perl $PATH
end

if test -d /usr/lib/emsdk
	set -x PATH /usr/lib/emsdk $PATH
	set -x PATH /usr/lib/emsdk/clang/e1.37.14_64bit $PATH
	set -x PATH /usr/lib/emsdk/node/4.1.1_64bit/bin $PATH
	set -x PATH /usr/lib/emsdk/emscripten/1.37.14 $PATH
end

set -x PATH $HOME/.config/composer/vendor/bin $PATH

# used for the Rust Language Server
set -x RUST_SRC_PATH $HOME/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src

# OPAM configuration
# Under the status quo $MANPATH was unset, so `man` would use default paths.
# OCaml upset this by setting $MANPATH.. Thus I manually commented out the line.
# This will probably be broken by package updates
source /home/chris/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true


### ========================================
###				   ALIASES
### ========================================

# connects to an existing tmux session before creating a new one
alias t "tmux a; or tmux"
# starts Alacritty fullscreen without a wm
alias al "env NO_WM=1 startx"
alias dotf "git --git-dir=$HOME/Code/Dotfiles --work-tree=$HOME"
# starts sway with the required
alias swm "bash ~/.config/sway/start_sway"
# its shorter
alias pac "pacaur"
# read the Arch RSS feed before updating
alias up "newsbeuter -r; and pac -Syu"
# because I keep forgetting sudo
alias docker "sudo docker"
alias docker-compose "sudo docker-compose"
# use neovim
alias vim "nvim"

### ========================================
###				   AUTOSTART
### ========================================

# start sway upon login to tty1
if status --is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" -eq "1"
        swm
    end
end
