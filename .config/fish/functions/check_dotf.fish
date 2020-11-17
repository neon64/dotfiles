function read_confirm
  while true
    read -l -n1 confirm -p "$argv[1]"

    switch "$confirm"
      case '' Y y
        return 0
      case '*'
        return 1
    end
  end
end

function get_unpushed_commits
    set --local has_upstream (command dotf rev-parse --abbrev-ref '@{upstream}')
    if test -n "$has_upstream"  # check there is an upstream repo configured
        and test "$has_upstream" != '@{upstream}' # Fixed #179, dont check the empty repo
        command dotf rev-list --left-right --count 'HEAD...@{upstream}' \
        | read --local --array git_status
        set --local commit_to_push $git_status[1]
        echo $commit_to_push
    end
end

function get_unpulled_commits
    set --local has_upstream (command dotf rev-parse --abbrev-ref '@{upstream}')
    if test -n "$has_upstream"  # check there is an upstream repo configured
        and test "$has_upstream" != '@{upstream}' # Fixed #179, dont check the empty repo
        command dotf rev-list --left-right --count 'HEAD...@{upstream}' \
        | read --local --array git_status
        set --local commit_to_pull $git_status[2]
        echo $commit_to_pull
    end
end

function commit_prompt
    echo -n (set_color green)'Would you like to commit them?'(set_color normal)' (Y/n) '
end

function push_prompt
    echo -n (set_color green)'Would you like to push them?'(set_color normal)' (Y/n) '
end

function pull_prompt
    echo -n (set_color green)'Would you like to pull them?'(set_color normal)' (Y/n) '
end

function check_dotf
    # implemented a basic debouncer so that it only updates once every 60 seconds
    if [ "$argv[1]" = "--fast" ]
        set updated_file ~/.cache/dotf_last_updated
        if test -e $updated_file
            set last_updated (cat $updated_file 2>/dev/null)
        else
            set last_updated (date -u +'%s')
        end
        set now (date -u +'%s')

        if [ "$last_updated" != "" ]
            set difference (math $now - $last_updated)
            if test $difference -lt 86400
                return
            end
        end

        echo "$now" > $updated_file
    end

    set up_to_date 1
    if dotf status --porcelain --ignore-submodules | grep --quiet -v "nothing to commit"
        set up_to_date 0
        # for some reason there is 1 too many newlines outputted here.. grr very annoying
        echo "You have unsaved changes to your dotfiles:"
        dotf -C $HOME status -s
        if read_confirm commit_prompt
            tmux new-session 'dotf commit -a' \; split-window -h 'dotf diff HEAD; read -s -n 1 key'
        end
    end

    if [ "$argv[1]" != "--fast" ]
        dotf fetch
    end

    set unpulled_commits (get_unpulled_commits)
    set unpushed_commits (get_unpushed_commits)

    if test "$unpulled_commits" -gt 0  # upstream is behind local repo
        set up_to_date 0
        echo ""
        echo -n (set_color cyan)"There are new updates to the dotfiles."(set_color normal)
        if read_confirm pull_prompt
            dotf pull
        end
    end

    if test "$unpushed_commits" -gt 0
        set up_to_date 0
        echo ""
        echo -n (set_color cyan)"You have unpushed local commits."(set_color normal)
        if read_confirm push_prompt
            dotf push
        end
    end

    if [ "$argv[1]" != "--fast" ]; and test $up_to_date -eq 1
        echo (set_color green)"Dotfiles are all up to date!"(set_color normal)
    end
end
