function cdi --wraps=cd
if test -n $argv[2]
cd ~/Documents/ITA/$argv[1]/$argv[2]
else
cd ~/Documents/ITA/$argv[]
end
clear
lsa
end
