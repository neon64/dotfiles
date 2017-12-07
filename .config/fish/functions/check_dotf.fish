# function read_confirm
#   while true
#     read -l -p read_confirm_prompt confirm

#     switch $confirm
#       case Y y
#         return 0
#       case '' N n
#         return 1
#     end
#   end
# end

# function read_confirm_prompt
#   echo 'Are you sure you want to exit? [y/N] '
# end

function check_dotf 
    if dotf diff-index --quiet HEAD
        return 0
    else
        echo ""
        echo (set_color red)"You have unsaved changes to your dotfiles:"(set_color normal)
        echo ""
        dotf ls-files -m
        echo ""
        echo "You should probably commit them sometime soon."
        # if read_confirm
        #     return 0
        # else
    end
end
