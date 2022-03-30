function gn --description 'Turns off speakers, updates system and executes command in arguments. If no argument is given, poweroff is executed'
    speakers off 2&>/dev/null &
    up
    echo "Shutting down in"
    for i in (seq 3 1)
        sleep 1
        echo $i
    end
    poweroff
end
