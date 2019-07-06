function read_confirm
  while true
    read -l confirm -p "$argv[1]"

    switch "$confirm"
      case ' ' Y y
        return 0
      case N n
        return 1
    end
  end
end

function get_unpushed_commits
    set --local has_upstream (command dotf rev-parse --abbrev-ref '@{upstream}' 2>/dev/null)
    if test -n "$has_upstream"  # check there is an upstream repo configured
        and test "$has_upstream" != '@{upstream}' # Fixed #179, dont check the empty repo
        command dotf rev-list --left-right --count 'HEAD...@{upstream}' \
        | read --local --array git_status
        set --local commit_to_push $git_status[1]
        echo $commit_to_push
    end
end

function get_unpulled_commits
    set --local has_upstream (command dotf rev-parse --abbrev-ref '@{upstream}' 2>/dev/null)
    if test -n "$has_upstream"  # check there is an upstream repo configured
        and test "$has_upstream" != '@{upstream}' # Fixed #179, dont check the empty repo
        command dotf rev-list --left-right --count 'HEAD...@{upstream}' \
        | read --local --array git_status
        set --local commit_to_pull $git_status[2]
        echo $commit_to_pull
    end
end

function commit_prompt
    echo -n (set_color green)'Would you like to commit them?'(set_color normal)' [Y/n] '
end

function push_prompt
    echo -n (set_color green)'Would you like to push them?'(set_color normal)' [Y/n] '
end

function pull_prompt
    echo -n (set_color green)'Would you like to pull them?'(set_color normal)' [Y/n] '
end

function check_dotf
    # strangely, this appears more robust
    # than `dotf diff-index --quiet HEAD`.
    # sometimes it would return an error code but
    # there were no changed files
    if dotf status | grep --quiet -v "nothing to commit"
        echo ""
        echo "You have unsaved changes to your dotfiles:"
        echo ""
        dotf -C $HOME status -s
        echo ""
        if read_confirm commit_prompt
            dotf commit -a
        end
        echo ""
    end

    if [ "$argv[1]" = "--fetch" ]
        dotf fetch
    end

    set unpulled_commits (get_unpulled_commits)
    set unpushed_commits (get_unpushed_commits)

    if test $unpulled_commits -gt 0  # upstream is behind local repo
        echo -n (set_color cyan)"There are new updates to the dotfiles."(set_color normal)
        if read_confirm pull_prompt
            dotf pull
        end
    end

    if test $unpushed_commits -gt 0
        echo -n (set_color cyan)"You have unpushed local commits."(set_color normal)
        if read_confirm push_prompt
            dotf push
        end
    end

end
