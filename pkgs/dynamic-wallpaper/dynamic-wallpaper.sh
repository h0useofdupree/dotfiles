#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<EOF
dynamic-wallpaper - change wallpaper depending on the time of day

Usage: dynamic-wallpaper [options]

Options:
  -d, --dir DIR       Directory containing wallpapers.
  --light             Always use the lightest wallpaper.
  --auto-light        Use the lightest wallpaper when GNOME is in light mode
                       (only after 06:00).
  -l, --log FILE      Write log output to FILE.
  -h, --help          Show this help text.

The number of images in DIR determines how many times the wallpaper changes
throughout the day. The cycle starts at 06:00. Images are sorted
lexicographically; the first is assumed to be the lightest.
Environment variables can also be used instead of command line options:
  DYNAMIC_WALLPAPER_DIR, DYNAMIC_WALLPAPER_FORCE_LIGHT,
  DYNAMIC_WALLPAPER_AUTO_LIGHT, DYNAMIC_WALLPAPER_LOG.
EOF
}

swww_bin="${SWWW_BIN:-swww}"
dir="${DYNAMIC_WALLPAPER_DIR:-}"
force_light="${DYNAMIC_WALLPAPER_FORCE_LIGHT:-0}"
auto_light="${DYNAMIC_WALLPAPER_AUTO_LIGHT:-0}"
log_file="${DYNAMIC_WALLPAPER_LOG:-$HOME/.cache/dynamic-wallpaper/dynamic-wallpaper.log}"

log() {
  mkdir -p "$(dirname "$log_file")"
  printf '%s\n' "$(date '+%F %T') - $*" | tee -a "$log_file"
}

while [[ $# -gt 0 ]]; do
  case "$1" in
  -d | --dir)
    dir="$2"
    shift 2
    ;;
  --light)
    force_light=1
    shift
    ;;
  --auto-light)
    auto_light=1
    shift
    ;;
  -l | --log)
    log_file="$2"
    shift 2
    ;;
  -h | --help)
    usage
    ;;
  *)
    echo "Unknown argument: $1" >&2
    usage
    ;;
  esac
done

if [[ -z "$dir" ]]; then
  echo "dynamic-wallpaper: directory not specified" >&2
  exit 1
fi

if [[ ! -d "$dir" ]]; then
  echo "dynamic-wallpaper: directory not found: $dir" >&2
  exit 1
fi

shopt -s nullglob
files=("$dir"/*.{jpg,jpeg,png})
IFS=$'\n' files=($(printf '%s\n' "${files[@]}" | sort -V))
count=${#files[@]}
if [[ $count -eq 0 ]]; then
  echo "dynamic-wallpaper: no images found in $dir" >&2
  exit 1
fi

interval=$((24 * 60 / count))
start_minutes=360 # 06:00
times=()
for ((i = 0; i < count; i++)); do
  t=$(((start_minutes + i * interval) % (24 * 60)))
  times+=("$(printf '%02d:%02d' $((t / 60)) $((t % 60)))")
done

log "directory: $dir"
log "found $count images"
log "interval: $interval minutes"
log "switch times: ${times[*]}"

minute_of_day=$((10#$(date +%H) * 60 + 10#$(date +%M)))
offset=$(((minute_of_day - start_minutes + 1440) % 1440))
index=$((offset / interval))
if ((index >= count)); then
  index=$((count - 1))
fi

color=""
if [[ "$force_light" == "1" ]]; then
  index=0
else
  if [[ "$auto_light" == "1" ]]; then
    color=$(dconf read /org/gnome/desktop/interface/color-scheme 2>/dev/null || echo "'prefer-dark'")
    day_end_minutes=$(((start_minutes + (count / 2) * interval) % 1440))
    if [[ "$color" == "'prefer-light'" ]] && ((minute_of_day < start_minutes || minute_of_day >= day_end_minutes)); then
      index=0
    fi
  fi
fi

log "force_light=$force_light auto_light=$auto_light color=$color index=$index"

wall="${files[$index]}"

log "using file: $wall"
current_link="${DYNAMIC_WALLPAPER_LINK:-}"
if [[ -n "$current_link" ]]; then
  mkdir -p "$(dirname "$current_link")"
  ln -sf "$wall" "$current_link"
fi
exec "$swww_bin" img "$wall" --transition-type fade --transition-fps 144
