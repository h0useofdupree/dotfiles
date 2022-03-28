function lsa --wraps='exa -la --color=auto' --wraps='exa -la --color=auto --group-directories-first --icons' --description 'Lists ALL directories'
  exa -la --color=always --group-directories-first --icons --color-scale $argv;
end
