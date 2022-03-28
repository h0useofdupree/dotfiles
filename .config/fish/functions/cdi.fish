function cdi --wraps=cd --wraps='cd ~/Documents/ITA/'
    set -l dir (echo $argv | tr \[:lower:\] \[:upper:\])
    cd ~/Documents/ITA/$dir
    clear
    lsa
end
