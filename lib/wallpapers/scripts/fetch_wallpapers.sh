#!/usr/bin/env bash
# Fetches wallpaper archives from a GitHub release, verifies checksums,
# validates zip entries (no zip-slip), then extracts each into lib/wallpapers/<group>/
# Safe defaults: no deletions; overwrites only same-named files within a group.
# Default release is the 'wallpapers' tag; falls back to --latest if missing.
# Flags:
#   -k/--keep   Keep downloaded archives in temp dir
#   -f/--force  Overwrite existing files (otherwise keep existing)
#   -h/--help   Show usage
#   [tag]       Optional release tag (e.g., v1.5.0)

set -Eeuo pipefail

command -v gh >/dev/null || {
  echo "gh is required" >&2
  exit 1
}
command -v sha256sum >/dev/null || {
  echo "sha256sum is required" >&2
  exit 1
}
command -v unzip >/dev/null || {
  echo "unzip is required" >&2
  exit 1
}
command -v rsync >/dev/null || {
  echo "rsync is required" >&2
  exit 1
}

usage() {
  echo "Usage: $0 [-k|--keep] [-f|--force] [tag]" >&2
  exit 1
}

keep=false
force=false
tag=""
default_tag="wallpapers"

while [[ $# -gt 0 ]]; do
  case "$1" in
  -k | --keep)
    keep=true
    shift
    ;;
  -f | --force)
    force=true
    shift
    ;;
  -h | --help) usage ;;
  *)
    if [[ -n "$tag" ]]; then usage; fi
    tag="$1"
    shift
    ;;
  esac
done

script_dir="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
wallpaper_root="${script_dir%/scripts}"

tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

echo "⬇️  Downloading release assets to: $tmpdir"

download_ok=false
if [[ -n "$tag" ]]; then
  if gh release download "$tag" -p '*.zip' -p 'checksums.sha256' -p '*.zip.sha256' --dir "$tmpdir" >/dev/null 2>&1; then
    echo "Using tag: $tag"
    download_ok=true
  else
    echo "⚠️  Tag '$tag' not found or has no matching assets; trying '$default_tag'..."
  fi
fi

if [[ "$download_ok" = false ]]; then
  if gh release download "$default_tag" -p '*.zip' -p 'checksums.sha256' -p '*.zip.sha256' --dir "$tmpdir" >/dev/null 2>&1; then
    echo "Using tag: $default_tag"
    download_ok=true
  else
    echo "⚠️  Tag '$default_tag' not found; trying latest release..."
  fi
fi

if [[ "$download_ok" = false ]]; then
  gh release download --latest -p '*.zip' -p 'checksums.sha256' -p '*.zip.sha256' --dir "$tmpdir" >/dev/null
  echo "Using: latest release"
fi

# Verify checksums: prefer aggregated checksums.sha256 if present; else per-zip *.zip.sha256
(
  cd "$tmpdir"
  shopt -s nullglob
  if [[ -f checksums.sha256 ]]; then
    echo "🔒 Verifying aggregated checksums ..."
    sha256sum -c checksums.sha256
  else
    found=false
    for sha in *.zip.sha256; do
      found=true
      echo "🔒 Verifying $sha ..."
      sha256sum -c "$sha"
    done
    if [[ "$found" = false ]]; then
      echo "⚠️  No checksums present; proceeding without verification." >&2
    fi
  fi
)

# Extract each zip safely:
# - validate entries (no absolute paths, no '..' components)
# - extract into a temp dir
# - rsync to target group dir (ignore-existing unless --force)
shopt -s nullglob
for zip in "$tmpdir"/*.zip; do
  group="$(basename "$zip" .zip)"
  workdir="$(mktemp -d)"

  # Validate entries
  while IFS= read -r entry; do
    [[ "$entry" = /* ]] && {
      echo "❌ $group: zip has absolute path '$entry' — skipping."
      rm -rf "$workdir"
      continue 2
    }
    IFS='/' read -r -a parts <<<"$entry"
    for seg in "${parts[@]}"; do
      [[ "$seg" == ".." ]] && {
        echo "❌ $group: zip has traversal in '$entry' — skipping."
        rm -rf "$workdir"
        continue 3
      }
    done
  done < <(unzip -Z1 "$zip")

  unzip -q "$zip" -d "$workdir"

  src="$workdir"
  if [[ -d "$workdir/$group" ]]; then
    src="$workdir/$group"
  fi

  target="$wallpaper_root/$group"
  mkdir -p "$target"

  if $force; then
    rsync -a "$src"/ "$target"/
  else
    rsync -a --ignore-existing "$src"/ "$target"/
  fi

  rm -rf "$workdir"
  echo "📥 Fetched $group -> $target"
done

if $keep; then
  trap - EXIT
  echo "📦 Archives kept in: $tmpdir"
else
  rm -rf "$tmpdir"
fi

echo "✅ Done."
