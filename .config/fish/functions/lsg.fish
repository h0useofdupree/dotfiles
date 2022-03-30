function lsg --wraps='exa -la --color=always --group-directories-first --icons' --description 'ls but with instant grep'
    exa -la --color=always --group-directories-first --icons . | grep -i "$argv*"   
end
