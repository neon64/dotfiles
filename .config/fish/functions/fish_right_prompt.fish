function fish_right_prompt
    # Do nothing if not in vi mode
    if test "$fish_key_bindings" = "fish_vi_key_bindings"
        or test "$fish_key_bindings" = "fish_hybrid_key_bindings"
        switch $fish_bind_mode
            case default
                set_color --bold --background yellow black
                echo ' N '
            case insert
                set_color --bold --background green black 
                echo ' I '
            case replace_one
                set_color --bold --background green white
                echo ' R '
            case visual
                set_color --bold --background blue black
                echo ' V '
        end
        set_color normal
        echo -n ''
    end
end
