function restart_firefox
  if pgrep -l firefox 2&>/dev/null
    killall firefox
    firefox 2&>/dev/null
  end
end
