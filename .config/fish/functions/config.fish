function config --wraps=git
    if [ (pwd) != "/home/juuls/.config" ]
        cd ~/.config
        echo Changed dir
    end
    git --git-dir=$HOME/.config/ --work-tree=$HOME $argv
end
