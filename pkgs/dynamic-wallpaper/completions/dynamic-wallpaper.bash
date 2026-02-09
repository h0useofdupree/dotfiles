shopt -q progcomp 2>/dev/null || return

_dynamic_wallpaper() {
  local cur prev opts times
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD - 1]}"
  opts="-d --dir -g --group --light --auto-light --start --end --time --shuffle-mode --image -l --log -h --help"

  case "$prev" in
  -d | --dir)
    mapfile -t COMPREPLY < <(compgen -o dirnames -- "$cur")
    return 0
    ;;
  -g | --group)
    mapfile -t COMPREPLY < <(compgen -W "$(find "${DYNAMIC_WALLPAPERS_ROOT:-$HOME/.dotfiles/lib/wallpapers}" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' 2>/dev/null)" -- "$cur")
    return 0
    ;;
  --shuffle-mode)
    mapfile -t COMPREPLY < <(compgen -W "random fixed" -- "$cur")
    return 0
    ;;
  --image)
    mapfile -t COMPREPLY < <(compgen -f -- "$cur")
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
