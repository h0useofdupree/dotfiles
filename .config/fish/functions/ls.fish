function ls --wraps='exa -l --color=always --group-directories-first --icons' --wraps='exa -l --color=auto'
exa -l --color=auto $argv
end
