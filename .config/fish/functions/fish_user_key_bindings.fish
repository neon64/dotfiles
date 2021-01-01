
function fish_user_key_bindings
    # remove the Ctrl-D shortcut, because it conflicts with our "disconnect" shortcut in tmux
    bind -e \cd

    fish_hybrid_key_bindings

    # mash Ctrl+H to go home
    # - got rid of this because it conflicts with Ctrl+T to open a new tab
    # bind \cH -M insert cd "echo -e \n\n" "commandline -f repaint

    # only init fzf key bindings if they are installed
    if not type -q "fzf_key_bindings"
        echo -e (set_color red)"\nWarning: `fzf` not installed, fuzzy searching shortcuts disabled."(set_color normal)
        return
    end

    fzf_key_bindings
    # change Ctrl+T to Ctrl+F, so it's like 'Find' - works well on Alacritty anyway
    bind --erase \ct
    bind --erase -M insert \ct
    bind --erase \ec
    bind --erase -M insert \ec
    bind --erase \cr
    bind --erase -M insert \cr
    bind \cf fzf-file-widget
    bind -M insert \cf fzf-file-widget
    # change Alt+C to Ctrl+G, so it's like 'Go-to' directory
    bind \cg fzf-cd-widget
    bind -M insert \cg fzf-cd-widget
    bind \ch fzf-run-widget
    bind -M insert \ch fzf-run-widget

    # Ctrl+R is the bash keybinding
    bind \cr fzf-history-widget
    bind -M insert \cr fzf-history-widget

    function fzf-run-widget -d "Run executables in PATH"
        set -l commandline (__fzf_parse_commandline)
        set -l dir $commandline[1]
        set -l fzf_query $commandline[2]

        # "-path \$dir'*/\\.*'" matches hidden files/folders inside $dir but not
        # $dir itself, even if hidden.
        set -q FZF_RUN_COMMAND; or set -l FZF_RUN_COMMAND "bash -c 'compgen -c | sort -u'"

        begin
            set -lx FZF_DEFAULT_OPTS "--reverse $FZF_DEFAULT_OPTS --history=$HOME/.local/share/fzf_run_history"
            eval "$FZF_RUN_COMMAND | "(__fzfcmd)' -m --query "'$fzf_query'"' | while read -l r; set result $result $r; end
        end
        if [ -z "$result" ]
            commandline -f repaint
            return
        else
            # Remove last token from commandline.
            commandline -t ""
        end
        for i in $result
            commandline -it -- (string escape $i)
            commandline -it -- ' '
        end
        # commandline -f repaint
    end

end
