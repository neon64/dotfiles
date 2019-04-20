### ========================================
###					PATH
### ========================================

# this is *prepended* because we want it to override
# the system rust compiler with our more up to date versions
set -x PATH $HOME/.cargo/bin $PATH
set -x PATH $HOME/.config/bin $PATH

# esmcripten on Arch Linux
if test -d  /usr/lib/emscripten
    set -x EMSCRIPTEN "/usr/lib/emscripten"
    set -x EMSCRIPTEN_FASTCOMP "/usr/lib/emscripten-fastcomp"

    # add to path
    set -x PATH $PATH $EMSCRIPTEN
end

if test -d $HOME/.local/bin
    set -x PATH $PATH $HOME/.local/bin
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
        set -x EDITOR emacsclient --quiet --alternate-editor=''
end

set -x SPACEMACSDIR "~/.config/spacemacs"

### ========================================
###				   ALIASES
### ========================================

# connects to an existing tmux session before creating a new one
alias t "tmux a; or tmux"
# starts Alacritty fullscreen without a wm
alias al "env NO_WM=1 COLUMNS=$COLUMNS LINES=$LINES startx"
alias yt "mpsyt"
alias g "googler --url-handler ~/.config/bin/browse --colors bjdxxy"
alias ls "exa --classify --git --header" 

# in case I forget
alias pac "yay"

# use neovim
alias vim "nvim"

# set -x FZF_DEFAULT_COMMAND "rg --files --hidden -g '!**/.git/' --ignore-parent"
set -x FZF_DEFAULT_COMMAND "fd --hidden --exclude '**/.git/'"
set -x FZF_CTRL_T_COMMAND "fd --hidden --exclude '**/.git/'"
set -x FZF_ALT_C_COMMAND "fd --type d --hidden --exclude '**/.git/'"
# Using highlight (http://www.andre-simon.de/doku/highlight/en/highlight.html)
set -x FZF_CTRL_T_OPTS "--preview 'highlight --force --out-format=ansi {} | head -n 100'"

set fish_cursor_insert line

### ========================================
###				   COLOURS
### ========================================

# I'm not sure where these are from, but I'll put them here instead of
# in the machine-specific u-vars file, so that they sync nicely.

set -U fish_color_autosuggestion 555\x1eyellow
set -U fish_color_command green
set -U fish_color_comment red
set -U fish_color_cwd blue
set -U fish_color_cwd_root red
set -U fish_color_end brmagenta
set -U fish_color_error red\x1e\x2d\x2dbold
set -U fish_color_escape cyan
set -U fish_color_history_current cyan
set -U fish_color_host normal
set -U fish_color_match cyan
set -U fish_color_normal white
set -U fish_color_operator cyan
set -U fish_color_param 00afff\x1ecyan
set -U fish_color_quote brown
set -U fish_color_redirection normal
set -U fish_color_search_match \x2d\x2dbackground\x3dpurple
set -U fish_color_selection \x2d\x2dbackground\x3dpurple
set -U fish_color_user brgreen
set -U fish_color_valid_path \x2d\x2dunderline

### ========================================
###				   AUTOSTART
### ========================================

# start sway upon login to tty1
if status --is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" -eq "1"
        sway
    end
end
