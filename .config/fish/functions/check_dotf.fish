function read_confirm
  while true
    read -l -p read_confirm_prompt confirm

    switch $confirm
      case ' ' Y y
        return 0
      case N n
        return 1
    end
  end
end

function read_confirm_prompt
  echo 'Would you like to push your local commits? [Y/n] '
end

function is_pending_push
    set --local git_unpushed_commits
    set --local git_unpulled_commits
    set --local unpulled_commits ⇣
    set --local unpushed_commits ⇡

    set --local has_upstream (command dotf rev-parse --abbrev-ref '@{upstream}' 2>/dev/null)
    if test -n "$has_upstream"  # check there is an upstream repo configured
        and test "$has_upstream" != '@{upstream}' # Fixed #179, dont check the empty repo
        command dotf rev-list --left-right --count 'HEAD...@{upstream}' \
        | read --local --array git_status
        set --local commit_to_push $git_status[1]
        set --local commit_to_pull $git_status[2]

        if test $commit_to_push -gt 0  # upstream is behind local repo
            set git_unpushed_commits "$unpushed_commits"
        end

        if test $commit_to_pull -gt 0  # upstream is ahead of local repo
            set git_unpulled_commits "$unpulled_commits"
        end
    end

    echo "$git_unpushed_commits$git_unpulled_commits"
end

function check_dotf
    # strangely, this appears more robust
    # than `dotf diff-index --quiet HEAD`.
    # sometimes it would return an error code but
    # there were no changed files
    if dotf status | grep --quiet "nothing to commit"
        echo ""
    else
        echo ""
        echo (set_color red)"You have unsaved changes to your dotfiles:"(set_color normal)
        echo ""
        dotf -C $HOME status -s
        echo ""
        echo "You should probably commit them sometime soon."
    end

    echo "pending push"
    is_pending_push

    if dotf status | grep --color=never "Your branch is ahead of 'origin/master'"
        if read_confirm
            dotf push
        end
    end
end
