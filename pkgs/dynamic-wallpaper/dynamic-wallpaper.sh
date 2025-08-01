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
  --start TIME        Start time for the cycle (default: 06:00).
                       Format: HH:MM, e.g., 06:00.
  --end TIME          End time for the cycle (default: 22:00).
                       Format: HH:MM, e.g., 22:00.
  -l, --log FILE      Write log output to FILE.
  -h, --help          Show this help text.

The number of images in DIR determines how many times the wallpaper changes
throughout the day. The cycle starts at 06:00. Images are sorted
lexicographically; the first is assumed to be the lightest.
Environment variables can also be used instead of command line options:
  DYNAMIC_WALLPAPER_DIR, DYNAMIC_WALLPAPER_FORCE_LIGHT,
  DYNAMIC_WALLPAPER_AUTO_LIGHT, DYNAMIC_WALLPAPER_LOG,
  DYNAMIC_WALLPAPER_START, DYNAMIC_WALLPAPER_END.
EOF
}

swww_bin="${SWWW_BIN:-swww}"
dir="${DYNAMIC_WALLPAPER_DIR:-}"
force_light="${DYNAMIC_WALLPAPER_FORCE_LIGHT:-0}"
auto_light="${DYNAMIC_WALLPAPER_AUTO_LIGHT:-0}"
log_file="${DYNAMIC_WALLPAPER_LOG:-$HOME/.cache/dynamic-wallpaper/dynamic-wallpaper.log}"
start_time="${DYNAMIC_WALLPAPER_START:-06:00}"
end_time="${DYNAMIC_WALLPAPER_END:-22:00}"
MAX_LOG_LINES=500

# Clean up log file
if [[ -f "$log_file" ]]; then
  tail -n "$MAX_LOG_LINES" "$log_file" >"${log_file}.tmp" && mv "${log_file}.tmp" "$log_file"
fi

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
  --start)
    start_time="$2"
    shift 2
    ;;
  --end)
    end_time="$2"
    shift 2
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

parse_minutes() {
  IFS=: read -r h m <<<"$1"
  echo $((10#$h * 60 + 10#$m))
}

start_minutes=$(parse_minutes "$start_time")
end_minutes=$(parse_minutes "$end_time")
cycle_start=$start_minutes
cycle_end=$end_minutes
if ((cycle_end <= cycle_start)); then
  cycle_end=$((cycle_end + 1440))
fi
cycle_length=$((cycle_end - cycle_start))
if ((count > 1)); then
  interval=$((cycle_length / (count - 1)))
else
  interval=$cycle_length
fi

times=()
for ((i = 0; i < count; i++)); do
  t=$((cycle_start + i * interval))
  t=$((t % 1440))
  times+=("$(printf '%02d:%02d' $((t / 60)) $((t % 60)))")
done

log "directory: $dir"
log "found $count images"
log "interval: $interval minutes"
# log "switch times: ${times[*]}"
log "switch times:"$'\n'"$(printf '  %s\n' "${times[@]}")"

minute_of_day=$((10#$(date +%H) * 60 + 10#$(date +%M)))
current=$minute_of_day
start=$start_minutes
end=$end_minutes
if ((end <= start)); then
  if ((current < start)); then
    current=$((current + 1440))
  fi
  end=$((end + 1440))
fi

if ((current < start)); then
  index=0
elif ((current >= end)); then
  index=$((count - 1))
else
  offset=$((current - start))
  if ((count > 1)); then
    index=$((offset / interval))
  else
    index=0
  fi
  if ((index >= count)); then
    index=$((count - 1))
  fi
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
