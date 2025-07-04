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

if [[ "$force_light" == "1" ]]; then
  index=0
else
  if [[ "$auto_light" == "1" ]]; then
    color=$(dconf read /org/gnome/desktop/interface/color-scheme || echo "'prefer-dark'")
    if [[ "$color" == "'prefer-light'" ]]; then
      index=0
    fi
  fi

  if [[ -z "${index:-}" ]]; then
    hour=$(date +%H)
    hour=$((10#$hour))
    minute=$(date +%M)
    minute=$((10#$minute))
    total=$((hour * 60 + minute))
    interval=$((24 * 60 / count))
    index=$((total / interval))
    if ((index >= count)); then
      index=$((count - 1))
    fi
  fi
fi

wall="${files[$index]}"

exec "$swww_bin" img "$wall" --transition-type fade --transition-fps 144
