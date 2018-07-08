function g
    set query $argv
    xdg-open "https://www.google.com/search?q=$query"&
    disown
    # try one or the other
    i3-msg workspace 1 2>/dev/null 1>/dev/null
    swaymsg workspace "1: " > /dev/null
end