### ========================================
###					PATH
### ========================================

# this is *prepended* because we want it to override
# the system rust compiler with our more up to date versions
set PATH $HOME/.cargo/bin $PATH   

if test -d $HOME/Code/emsdk
	set PATH $PATH $HOME/Code/emsdk $HOME/Code/emsdk/clang/e1.37.18_64bit \
        $HOME/Code/emsdk/node/4.1.1_64bit/bin $HOME/Code/emsdk/emscripten/1.37.18
end

set PATH $PATH $HOME/.config/composer/vendor/bin 


# used for the Rust Language Server
set -x RUST_SRC_PATH $HOME/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src

# OPAM configuration
# Under the status quo $MANPATH was unset, so `man` would use default paths.
# OCaml upset this by setting $MANPATH.. Thus I manually commented out the line.
# This will probably be broken by package updates
if test -d $HOME/.opam
    source $HOME/.opam/opam-init/init.fish #> /dev/null 2> /dev/null; or true
end

switch (uname)
    case Darwin
        set -x EDITOR /usr/local/bin/nvim
    case '*'
        set -x EDITOR /usr/bin/nvim
end

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

# because I keep forgetting sudo
alias docker "sudo docker"
alias docker-compose "sudo docker-compose"
# use neovim
alias vim "nvim"

### ========================================
###				   COLOURS
### ========================================

# I'm not sure where these are from, but I'll put them here instead of
# in the machine-specific u-vars file, so that they sync nicely.

set fish_color_autosuggestion 555\x1eyellow
set fish_color_command green
set fish_color_comment red
set fish_color_cwd blue
set fish_color_cwd_root red
set fish_color_end brmagenta
set fish_color_error red\x1e\x2d\x2dbold
set fish_color_escape cyan
set fish_color_history_current cyan
set fish_color_host normal
set fish_color_match cyan
set fish_color_normal white
set fish_color_operator cyan
set fish_color_param 00afff\x1ecyan
set fish_color_quote brown
set fish_color_redirection normal
set fish_color_search_match \x2d\x2dbackground\x3dpurple
set fish_color_selection \x2d\x2dbackground\x3dpurple
set fish_color_user brgreen
set fish_color_valid_path \x2d\x2dunderline
set fisher_active_prompt clearance

### ========================================
###				   AUTOSTART
### ========================================

# start sway upon login to tty1
if status --is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" -eq "1"
        swm
    end
end
