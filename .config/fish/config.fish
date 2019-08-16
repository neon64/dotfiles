### ========================================
###				PATH & ENV VARS
### ========================================

# this is *prepended* because we want it to override
# the system rust compiler with our more up to date versions
set -x PATH $HOME/.cargo/bin $PATH
set -x PATH $HOME/.config/bin $PATH

if test -d $HOME/.local/bin
    set -x PATH $PATH $HOME/.local/bin
end

set PATH $PATH $HOME/.config/composer/vendor/bin

# used for the Rust Language Server
# set -x RUST_SRC_PATH $HOME/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src

# OPAM configuration
# Under the status quo $MANPATH was unset, so `man` would use default paths.
# OCaml upset this by setting $MANPATH.. Thus I manually commented out the line.
# This will probably be broken by package updates
# if test -d $HOME/.opam
#     source $HOME/.opam/opam-init/init.fish #> /dev/null 2> /dev/null; or true
# end

set -x EDITOR (which nvim)

set -x SPACEMACSDIR "~/.config/spacemacs"
set -e FZF_DEFAULT_OPTS
set -x FZF_DEFAULT_COMMAND "fd --hidden --exclude '**/.git/'"
set -x FZF_CTRL_T_COMMAND "fd --hidden --exclude '**/.git/'"
set -x FZF_ALT_C_COMMAND "fd --type d --hidden --exclude '**/.git/'"
# Using highlight (http://www.andre-simon.de/doku/highlight/en/highlight.html)
set -x FZF_CTRL_T_OPTS "--preview 'highlight --force --out-format=ansi {} | head -n 100'"

### ========================================
###				   AUTOSTART
### ========================================


# start sway upon login to tty1
# we check `status --is-interactive` because
# commands like dbus-run-session (for starting Gnome
# Terminal) start a non-interactive login shell
if status --is-login && status --is-interactive
    if set -q XDG_VTNR && test "$XDG_VTNR" -gt "0" -a "$XDG_VTNR" -lt "6"
        set LINE_UP "\033[1A"
        set CLEAR_LINE "\033[K"
        echo -e "$LINE_UP$CLEAR_LINE$LINE_UP$CLEAR_LINE$LINE_UP$CLEAR_LINE$LINE_UP"
        exec ~/Code/fdm/fdm
    end
end

### ========================================
###				   ALIASES
### ========================================

# connects to an existing tmux session before creating a new one
alias t "tmux a; or tmux"
alias yt "mpsyt"
alias s "googler --url-handler ~/.config/bin/browse_web --colors bjdxxy"
alias ls "exa --classify --git --header"
alias v "view"
alias g "git"
alias ds "check_dotf"
alias w "browse_web"
alias blue "manage_bluetooth"
alias sr "switch_res"
alias reboot "reboot_chooser"

# in case I forget
alias pac "pikaur"

# use neovim
alias vim "nvim"

### ========================================
###				   COLOURS
### ========================================

# Base16 Shell
if status --is-interactive
    set -g fish_cursor_default block
    set -g fish_cursor_insert line

    # manually set
    if [ "$TERM" = 'linux' ]; or [ ! -z "$GNOME_TERMINAL_SCREEN" ]; or [ "$TERM" = 'xterm-kitty' ]; or [ ! -z "$SSH_TTY" ]
        bash ~/.config/colors/theme.sh
    end

    set theme (cat ~/.config/colors/current-theme)
    source ~/.config/colors/base16-fzf/fish/$theme.fish

    # unset all universal variables
    # for v in (set --show | string replace -rf '^\$([^:[]+).*: set in universal.*' '$1')
    #     set -e $v
    # end

    # i'm not sure where these are from, but i'll put them here instead of
    # in the machine-specific u-vars file, so that they sync nicely.
    set -g fish_color_autosuggestion 555\x1eyellow
    set -g fish_color_command green
    set -g fish_color_comment red
    set -g fish_color_cwd blue
    set -g fish_color_cwd_root red
    set -g fish_color_end brmagenta
    set -g fish_color_error red\x1e\x2d\x2dbold
    set -g fish_color_escape cyan
    set -g fish_color_history_current cyan
    set -g fish_color_host normal
    set -g fish_color_match cyan
    set -g fish_color_normal cyan
    set -g fish_color_operator cyan
    set -g fish_color_param blue
    set -g fish_color_quote brown
    set -g fish_color_redirection normal
    set -g fish_color_search_match \x2d\x2dbackground\x3dpurple
    set -g fish_color_selection \x2d\x2dbackground\x3dpurple
    set -g fish_color_user brgreen
    set -g fish_color_valid_path \x2d\x2dunderline
end

