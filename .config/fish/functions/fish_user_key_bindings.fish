
function fish_user_key_bindings
    # remove the Ctrl-D shortcut, because it conflicts with our "disconnect" shortcut in tmux
    bind -e \cd

    # only init fzf key bindings if they are installed
    if type -q "fzf_key_bindings"
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
        bind \cr fzf-run-widget
        bind -M insert \cr fzf-run-widget
        bind \ct fzf-history-widget
        bind -M insert \ct fzf-history-widget

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

    else
        echo -e (set_color red)"\nWarning: `fzf` not installed, fuzzy searching shortcuts disabled."(set_color normal)
    end

    fish_hybrid_key_bindings
    # fish_vi_key_bindings

    # useful crossovers from emacs
    # bind \cA -M insert beginning-of-line
    # bind \cE -M insert end-of-line
    # mash Ctrl+H to go home
    bind \cH -M insert cd "echo -e \n\n" "commandline -f repaint"
end
