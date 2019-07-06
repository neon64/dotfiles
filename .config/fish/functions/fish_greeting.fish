# we don't want any greeting
function fish_greeting
    if set -q fish_custom_greeting
        echo -ns $fish_custom_greeting
        return
    end
    set hour (date +%H)
    switch $hour
        case "00" "01" "02" "03" "04" "05" "06"
            set tod "Go to sleep"
        case "07" "08" "09" "10" "11"
            set tod "Good morning"
        case "12" "13" "14" "15" "16" "17" "18"
            set tod "Good afternoon"
        case "19" "20" "21" "22" "23"
            set tod "Good evening"
    end
    echo ""
    echo -s (set_color cyan) "$tod, " (whoami) "!" (set_color normal)
    echo ""
    check_dotf --fast
end
