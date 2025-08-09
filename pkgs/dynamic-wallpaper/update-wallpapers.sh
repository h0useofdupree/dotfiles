#!/usr/bin/env bash
set -euo pipefail

root="$(git rev-parse --show-toplevel)"
base="$root/lib/wallpapers"
readme="$base/README.md"
completion="$root/pkgs/dynamic-wallpaper/completions/dynamic-wallpaper.fish"

mapfile -t groups < <(find "$base" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | sort)

# Generate README
{
  echo "# Wallpapers for \`dynamic-wallpaper\`"
  echo
  echo "> Wallpapers are not stored here in this repo due to size limitations and performance hits with push/pull actions."
  echo
  echo "## Available groups"
  echo
  for g in "${groups[@]}"; do
    mapfile -t files < <(find "$base/$g" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) | sort)
    count=${#files[@]}
    first="${files[0]}"
    if command -v identify >/dev/null 2>&1; then
      res=$(identify -format '%wx%h' "$first")
    else
      res=$(file "$first" | grep -o '[0-9]\+ x [0-9]\+' | tr -d ' ')
    fi
    printf -- "- '%s' - %d images - %s\n" "$g" "$count" "$res"
  done
  echo
  echo "> Images in groups need to be named \`<group_name>-n.<file_extenstion>\` in order"
  echo "> to work in a time-based manner. The appropriate wallpaper for the current time"
  echo "> will be selected by its n-index."
  echo
  echo "## Packaging"
  echo "Use $(scripts/package_wallpapers.sh) to create zip archives and accompanying"
  echo "SHA-256 checksum files for each wallpaper group. The archives are written to $(lib/wallpapers/archives) and can be uploaded as release assets."
} >"$readme"

# Generate fish completions
{
  echo "function __dynamic_wallpaper_times"
  echo "    for h in (seq 0 23)"
  echo "        for m in 0 15 30 45"
  echo "            printf '%02d:%02d\\n' \$h \$m"
  echo "        end"
  echo "    end"
  echo "end"
  echo
  echo "function __dynamic_wallpaper_groups"
  for g in "${groups[@]}"; do
    mapfile -t files < <(find "$base/$g" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) | sort)
    count=${#files[@]}
    first="${files[0]}"
    if command -v identify >/dev/null 2>&1; then
      res=$(identify -format '%wx%h' "$first")
    else
      res=$(file "$first" | grep -o '[0-9]\+ x [0-9]\+' | tr -d ' ')
    fi
    desc="$count images $res"
    printf "    echo -e %q\n" "$g\t$desc"
  done
  echo "end"
  echo
  echo "complete -c dynamic-wallpaper -s g -l group -r -d 'Wallpaper group' -a '(__dynamic_wallpaper_groups)' -f"
  echo "complete -c dynamic-wallpaper -s d -l dir -r -d 'Directory containing wallpapers' -a '(__fish_complete_directories)'"
  echo "complete -c dynamic-wallpaper -l light -d 'Always use the lightest wallpaper'"
  echo "complete -c dynamic-wallpaper -l auto-light -d 'Use the lightest wallpaper when GNOME is in light mode'"
  echo "complete -c dynamic-wallpaper -l start -r -d 'Start time for the cycle (HH:MM)' -a '(__dynamic_wallpaper_times)' -f"
  echo "complete -c dynamic-wallpaper -l end -r -d 'End time for the cycle (HH:MM)' -a '(__dynamic_wallpaper_times)' -f"
  echo "complete -c dynamic-wallpaper -l time -r -d 'Use fake current time (HH:MM)' -a '(__dynamic_wallpaper_times)' -f"
  echo "complete -c dynamic-wallpaper -s l -l log -r -d 'Write log output to FILE' -a '(__fish_complete_files)'"
  echo "complete -c dynamic-wallpaper -s h -l help -d 'Show help text'"
} >"$completion"

echo "Rebuild system to source fish-completions."
