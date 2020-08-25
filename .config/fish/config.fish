### ========================================
###				PATH & ENV VARS
### ========================================

# this is *prepended* because we want it to override
# the system rust compiler with our more up to date versions
set -x PATH $HOME/.local/share/cargo/bin $PATH
set -x PATH $HOME/.config/bin $PATH

if test -d $HOME/.local/bin
    set -x PATH $PATH $HOME/.local/bin
end

if test -d /usr/local/bin
    set -x PATH /usr/local/bin $PATH
end

if test -d /usr/local/sbin
    set -x PATH /usr/local/sbin $PATH
end

set PATH $PATH $HOME/.config/composer/vendor/bin

# used for the Rust Language Server
# set -x RUST_SRC_PATH $HOME/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src

# OPAM configuration
# Under the status quo $MANPATH was unset, so `man` would use default paths.
# OCaml upset this by setting $MANPATH.. Thus I manually commented out the line.
# This will probably be broken by package updates
# if test -d $HOME/.opam
#     source /home/chris/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
# #     source $HOME/.opam/opam-init/init.fish #> /dev/null 2> /dev/null; or true
# end

set -x XDG_CONFIG_HOME "$HOME/.config"
set -x XDG_DATA_HOME "$HOME/.local/share"
set -x XDG_CACHE_HOME "$HOME/.cache"

set -x EDITOR (which nvim)
set -x NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
set -x CARGO_HOME "$XDG_DATA_HOME"/cargo
set -x RUSTUP_HOME "$XDG_DATA_HOME"/rustup
set -x UNISON "$XDG_DATA_HOME"/unison
set -x STACK_ROOT "$XDG_DATA_HOME"/stack
set -x HISTFILE "$XDG_DATA_HOME"/bash/history
set -x LESSKEY "$XDG_CONFIG_HOME"/less/lesskey
set -x LESSHISTFILE "$XDG_CACHE_HOME"/less/history
set -x NOTMUCH_CONFIG "$XDG_CONFIG_HOME"/notmuch/notmuchrc
set -x NMBGIT "$XDG_DATA_HOME"/notmuch/nmbug
set -x BUNDLE_USER_CONFIG "$XDG_CONFIG_HOME"/bundle
set -x BUNDLE_USER_CACHE "$XDG_CACHE_HOME"/bundle
set -x BUNDLE_USER_PLUGIN "$XDG_DATA_HOME"/bundle

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
    if set -q XDG_VTNR && test "$XDG_VTNR" -eq "1" && test ! -e /tmp/sway-autoopen.tag
        touch /tmp/sway-autoopen.tag

        ~/.config/bin/fdm --auto
    end
    if set -q XDG_VTNR && test "$XDG_VTNR" -gt "0" -a "$XDG_VTNR" -lt "6"
        # set LINE_UP "\033[1A"
        set CLEAR_LINE "\033[K"
        echo -e "$LINE_UP$CLEAR_LINE$LINE_UP$CLEAR_LINE$LINE_UP$CLEAR_LINE$LINE_UP"
        exec ~/.config/bin/fdm
    end
end

### ========================================
###				   ALIASES
### ========================================

# connects to an existing tmux session before creating a new one
alias t "tmux a; or tmux"

if type -q exa
    alias ls "exa --classify --git --header --color auto -s type"
    alias ll "exa -l --color always --icons -a -s type"
end

if type -q bat
    alias cat='bat -pp --theme=base16'
end

if type -q prettyping
    alias ping "prettyping --nolegend"
end

if type -q nvim
    alias vim "nvim"
end

alias w "browse_web"
alias blue "manage_bluetooth"
alias clock "tty-clock -sSc"
alias b "browse_files"

if test -x /usr/bin/reboot_chooser
    alias reboot "reboot_chooser"
end

alias pac "yay"

### ========================================
###				   COLOURS
### ========================================

# Base16 Shell
if status --is-interactive
    set -g fish_cursor_default block
    set -g fish_cursor_insert line

    # manually set
    if [ ! -z "$GNOME_TERMINAL_SCREEN" ]; or [ "$TERM" = 'xterm-kitty' ]; or [ ! -z "$SSH_TTY" ]
        bash ~/.config/colors/theme.sh
    end

    if test -e ~/.config/colors/current-theme
        set theme (cat ~/.config/colors/current-theme)
        source ~/.config/colors/base16-fzf/fish/$theme.fish
    end

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

    thefuck --alias | source
end
