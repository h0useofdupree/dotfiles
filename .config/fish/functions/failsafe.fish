function failsafe --description 'Restarts a given program if it is dead.'
  while true
    set stat (pgrep -l $argv[1])
    set name (echo $stat | awk {'print $2'})
    set pid (echo $stat | awk {'print $1'})

    if [ "$stat" = " " ]
      if [ "$name" = "kdeconnectd" ]
        kdeconnect-cli -l 2&>/dev/null
      else
        eval $name
      end
      if [ "-v" = "argv[2]" ]
        echo "Restarting $name"
      end
    end
    if [ "-v" = "$argv[2]" ] && test -n $stat
      echo "$name is running with PID $pid"
    end
    sleep 3s
  end
  # echo $stat $name $pid
end
