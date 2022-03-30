function kdeconnectd_failsafe --description 'Restarts kdeconnectd as soon as it is killed. For reference  see ~/.config/qtile/autostart.sh'
  while true
    set -l stat (pgrep -l kdeconnectd)
    if test -z $stat
      kdeconnect-cli -l
    end
    if [ "-v" = "$argv" ] && test -n $stat
      echo "kde is running"
    end
    sleep 30s
  end
end
