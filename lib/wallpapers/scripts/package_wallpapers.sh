#!/usr/bin/env bash
set -euo pipefail

# Packages each wallpaper group into its own zip archive and generates
# corresponding SHA-256 checksum files.
#
# Archives are written to lib/wallpapers/archives and can be uploaded as
# release assets.

command -v zip >/dev/null || {
  echo "zip is required" >&2
  exit 1
}
command -v sha256sum >/dev/null || {
  echo "sha256sum is required" >&2
  exit 1
}

script_dir="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
wallpaper_root="${script_dir%/scripts}"
output_dir="$wallpaper_root/archives"
mkdir -p "$output_dir"

shopt -s nullglob
for group_dir in "$wallpaper_root"/*/; do
  group="$(basename "$group_dir")"
  case "$group" in
  scripts | archives) continue ;;
  esac
  # Skip empty directories
  if ! compgen -G "$group_dir"* >/dev/null; then
    continue
  fi
  zip_path="$output_dir/${group}.zip"
  (
    cd "$wallpaper_root"
    zip -r "$zip_path" "$group" >/dev/null
  )
  sha256sum "$zip_path" >"$zip_path.sha256"
  echo "Packaged $group"
done
