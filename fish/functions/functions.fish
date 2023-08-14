### FUNCTIONS ###

function pony --description "Pony say ...!"
    set -l say Hello "Love you" Kisses
    set -l names Ema Andy tati Ema mama
    set -l x (seq (count $say) | sort -R)[1]
    set -l y (seq (count $names) | sort -R)[1]
    ponysay "$say[$x] $names[$y]!"
end


function grephistory --description "grep history ...!"
    history | nl | grep "$argv"
end


function cdls --description "cd into dir and list it"
    cd $argv[1]
    exa -lag --color=always
end


function ..ls --description "cd into dir and list it"
    cd ..
    exa -lag --color=always
end
