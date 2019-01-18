# we don't want any greeting
function fish_greeting
    set hour (date +%H)
    switch $hour
        case "00" "01" "02" "03" "04" "05" "06"
            set tod "early morning"
        case "07" "08" "09" "10" "11"
            set tod "morning"
        case "12" "13" "14" "15" "16" "17" "18"
            set tod "afternoon"
        case "19" "20" "21" "22" "23"
            set tod "evening"
    end
    echo ""
    echo -ns (set_color cyan) "Good $tod, " (whoami) "!" (set_color normal)
    echo ""
    check_dotf
end
