function nhxdg --description 'XDG-Open with detached Session'
  nohup xdg-open $argv > /dev/null 2>&1 &
end
