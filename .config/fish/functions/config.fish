function config --wraps=git
    git --git-dir=$HOME/.config/ --work-tree=$HOME $argv
end
