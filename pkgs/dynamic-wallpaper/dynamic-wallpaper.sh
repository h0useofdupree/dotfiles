#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $0 [--dir DIR] [--light] [--auto-light]" >&2
  exit 1
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

    # Avoid light wallpaper before 05:00
    if ((index == 0 && total < 300)); then
      index=$((count - 1))
    fi
  fi
fi

wall="${files[$index]}"

exec "$swww_bin" img "$wall" --transition-type fade --transition-fps 144
