_dynamic_wallpaper() {
  local cur prev opts times
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD - 1]}"
  opts="-d --dir --light --auto-light --start --end --time -l --log -h --help"

  case "$prev" in
  -d | --dir)
    mapfile -t COMPREPLY < <(compgen -o dirnames -- "$cur")
    return 0
    ;;
  -l | --log)
    mapfile -t COMPREPLY < <(compgen -f -- "$cur")
    return 0
    ;;
  --start | --end | --time)
    times=$(for h in {00..23}; do for m in 00 15 30 45; do printf '%02d:%02d ' "$h" "$m"; done; done)
    mapfile -t COMPREPLY < <(compgen -W "$times" -- "$cur")
    return 0
    ;;
  esac

  if [[ "$cur" == -* ]]; then
    mapfile -t COMPREPLY < <(compgen -W "$opts" -- "$cur")
    return 0
  fi
}

complete -F _dynamic_wallpaper dynamic-wallpaper
