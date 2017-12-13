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

function check_dotf 
    # strangely, this appears more robust
    # than `dotf diff-index --quiet HEAD`.
    # sometimes it would return an error code but
    # there were no changed files 
    if dotf status | grep --quiet "nothing to commit"
        if dotf status | grep --quiet "Your branch is ahead of 'origin/master'"
            if read_confirm
                dotf push
            end
        end
        return 0
    else
        echo ""
        echo (set_color red)"You have unsaved changes to your dotfiles:"(set_color normal)
        echo ""
        dotf -C $HOME ls-files -m
        echo ""
        echo "You should probably commit them sometime soon."
        # if read_confirm
        #     return 0
        # else
    end
end
