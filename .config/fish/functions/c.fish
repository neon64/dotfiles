
function c
    cargo $argv --color=always 2>&1 | less -R
end