#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 2 ]]; then
  echo "Usage: add-wallpaper-group <GroupName> <SourceDir>" >&2
  exit 1
fi

group="$1"
src="$2"

root="$(git rev-parse --show-toplevel)"
dest="$root/lib/wallpapers/$group"

mkdir -p "$dest"
cp -r "$src"/* "$dest/"

"$root/pkgs/dynamic-wallpaper/update-wallpapers.sh"
