### ========================================
###				PATH & ENV VARS
### ========================================

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
set -x BROWSER firefox

set -g man_standout -b yellow -o black

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
    function cat --wraps='bat -pp --theme=base16' --description 'alias cat=bat -pp --theme=base16'
        if test -d $argv
            cd $argv
        else
            bat -pp --theme=base16 $argv;
        end
    end
end

if type -q prettyping
    alias ping "prettyping --nolegend"
end

if type -q nvim
    alias vim "nvim"
end

alias up topgrade

alias w "browse_web"
alias blue "manage_bluetooth"
alias clock "tty-clock -sSc"
alias b "browse_files"

alias pac "yay"

### ========================================
###				   COLOURS
### ========================================

# Base16 Shell
if status --is-interactive
    # manually set
    if [ ! -z "$GNOME_TERMINAL_SCREEN" ]; or [ "$TERM" = 'xterm-kitty' ]; or [ ! -z "$SSH_TTY" ]
        bash ~/.config/colors/theme.sh
    end

    if test -e ~/.config/colors/current-theme
        set theme (cat ~/.config/colors/current-theme)
        source ~/.config/colors/base16-fzf/fish/$theme.fish
    end

    if test -x /usr/bin/reboot_chooser
        alias reboot "reboot_chooser"
    end

    starship init fish | source

end
