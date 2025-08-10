#!/usr/bin/env bash
# Packages each wallpaper group under lib/wallpapers/<group>/ into lib/wallpapers/archives/<group>.zip
# - Skips "scripts" and "archives" dirs
# - Skips re-zipping if archive is newer than any source in the group
# - Emits per-zip "<name>.zip.sha256" and an aggregated "checksums.sha256" (relative paths)
# - Produces stable-ish zips (-9 -X)

set -Eeuo pipefail

command -v zip >/dev/null || {
  echo "zip is required" >&2
  exit 1
}
command -v sha256sum >/dev/null || {
  echo "sha256sum is required" >&2
  exit 1
}
command -v find >/dev/null || {
  echo "find is required" >&2
  exit 1
}
command -v stat >/dev/null || {
  echo "stat is required" >&2
  exit 1
}

script_dir="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
wallpaper_root="${script_dir%/scripts}"
output_dir="$wallpaper_root/archives"
mkdir -p "$output_dir"

has_files() {
  # any regular file inside the group?
  find "$1" -mindepth 1 -type f -print -quit | grep -q .
}

latest_src_mtime() {
  # epoch seconds (float) of newest file under group dir
  # shellcheck disable=SC2016
  find "$1" -type f -printf '%T@\n' 2>/dev/null | sort -n | tail -1
}

zip_group() {
  local group_dir="$1"
  local group name zip_path latest zip_mtime

  name="$(basename "$group_dir")"
  zip_path="$output_dir/${name}.zip"

  # freshness check
  latest="$(latest_src_mtime "$group_dir")"
  if [[ -n "${latest:-}" && -f "$zip_path" ]]; then
    zip_mtime="$(stat -c '%Y' "$zip_path")"
    if awk "BEGIN{exit !($zip_mtime >= $latest)}"; then
      echo "  ✅ $name unchanged (archive up-to-date)."
      return 0
    fi
  fi

  echo "  📦 Zipping $name -> $zip_path"
  (
    cd "$wallpaper_root"
    # -9 max compression, -X strip extra file attrs/timestamps for smaller diffs
    zip -r -q -9 -X "$zip_path" "$name" -i '*.jpg' '*.jpeg' '*.png'
  )

  # per-zip checksum with relative path (so sha256sum -c works anywhere)
  (
    cd "$output_dir"
    sha256sum "${name}.zip" >"${name}.zip.sha256"
  )
}

echo "📁 Packaging groups from: $wallpaper_root"
shopt -s nullglob

# Iterate immediate subdirs (exclude scripts/archives)
for group_dir in "$wallpaper_root"/*/; do
  base="$(basename "$group_dir")"
  case "$base" in
  scripts | archives) continue ;;
  esac
  has_files "$group_dir" || {
    echo "  ℹ️  $base is empty; skipping."
    continue
  }
  zip_group "$group_dir"
done

# aggregated checksums (relative)
echo "🔒 Writing aggregated checksums ..."
(
  cd "$output_dir"
  rm -f checksums.sha256
  # Only include existing zips
  shopt -s nullglob
  if ls *.zip >/dev/null 2>&1; then
    sha256sum *.zip >checksums.sha256
  fi
)

echo "✅ Done. Output: $output_dir"
