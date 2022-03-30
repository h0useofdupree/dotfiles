function log --description 'Write argument-text with date/time in a specified log file. If no logfile is specified, default will be create in . '

  set -l DATE (date)
  
  if test -z $argv[1]
    set -l descr "$DATE - Default description"
  else
    set -l descr "$DATE - $argv[1]"
  end
  
  if test -z $argv[2]
    set -l path "/home/$USER"
  else
    set -l path $argv[2]
  end
  
  if test ! -f "$path/log.log"
    sudo touch "$path/log.log"
  end

  sudo echo "$descr" >> "$path/log.log"
end
