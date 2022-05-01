function ipmon-test
    
    argparse 'h/help' 't/time=?' -- $argv
    or return
    
    if set -q _flag_h
        printf "usage: ipmon-test [-h / --help] [-t[test-length] / --time=[test-length]]"
        printf "\n\n\n"
        printf "options:\n\t-h / --help \t show this help message\n\t-t / --time \t Set length of test in s (Default is 1800 (30min))"
    end
    
    if set -q _flag_t
        set -f test_length $_flag_t
    else
        set -f test_length 1800
    end
    
    if test -e $HOME/.scripts/ipmon-test.txt
        rm $HOME/.scripts/ipmon-test.txt
    end
        
    ip monitor 2&>>$HOME/.scripts/ipmon-test.txt &
    
    for i in 1 2 3
        sleep (echo $test_length/3 | bc)
        if grep veth $HOME/.scripts/ipmon-test.txt 2&>/dev/null
            notify-send -u critical -t 0 "ATTENTION" "FOUND veth usage in <ip monitor>"
        else
            printf "\n\nCHECKPOINT $i/3 CLEARED\n\n" >> $HOME/.scripts/ipmon-test.txt
        end
    end
        
    killall ip
end
