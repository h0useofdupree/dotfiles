#!/usr/bin/env bash
# Fetches wallpaper archives from a GitHub release, verifies checksums,
# validates zip entries (no zip-slip), then extracts each into lib/wallpapers/<group>/
# Safe defaults: no deletions; overwrites only same-named files within a group.
# Flags:
#   -k/--keep   Keep downloaded archives in temp dir
#   -f/--force  Overwrite existing files (otherwise keep existing)
#   -h/--help   Show usage
#   [tag]       Optional release tag (e.g., v1.5.0); otherwise uses --latest

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
if [[ -n "$tag" ]]; then
  gh release download "$tag" -p '*.zip' -p 'checksums.sha256' -p '*.zip.sha256' --dir "$tmpdir" >/dev/null
else
  gh release download --latest -p '*.zip' -p 'checksums.sha256' -p '*.zip.sha256' --dir "$tmpdir" >/dev/null
fi

# Verify checksums: prefer aggregated checksums.sha256 if present; else per-zip *.zip.sha256
(
  cd "$tmpdir"
  shopt -s nullglob
  if [[ -f checksums.sha256 ]]; then
    echo "🔒 Verifying aggregated checksums ..."
    sha256sum -c checksums.sha256
  else
    for sha in *.zip.sha256; do
      echo "🔒 Verifying $sha ..."
      sha256sum -c "$sha"
    done
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
    # Reject absolute paths
    [[ "$entry" = /* ]] && {
      echo "❌ $group: zip contains absolute path '$entry' — skipping."
      rm -rf "$workdir"
      continue 2
    }
    # Reject parent traversal anywhere in path segments
    IFS='/' read -r -a parts <<<"$entry"
    for seg in "${parts[@]}"; do
      [[ "$seg" == ".." ]] && {
        echo "❌ $group: zip contains parent traversal in '$entry' — skipping."
        rm -rf "$workdir"
        continue 3
      }
    done
  done < <(unzip -Z1 "$zip")

  # Extract to temp
  unzip -q "$zip" -d "$workdir"

  target="$wallpaper_root/$group"
  mkdir -p "$target"

  # Copy files in; avoid overwriting unless --force
  if $force; then
    rsync -a "$workdir"/ "$target"/
  else
    rsync -a --ignore-existing "$workdir"/ "$target"/
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
