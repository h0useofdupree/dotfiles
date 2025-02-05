#!/usr/bin/env bash
set -euo pipefail

# This builder script writes the dynamic wallpaper updater to $out.
# The following environment variables are passed in as strings from Nix:
#   cacheDir, currentWallpaper, themeSubdir, baseName, namingPattern,
#   extension, totalVariants

cat >"$out" <<EOF
#!/usr/bin/env bash
set -euo pipefail

# Use environment variables that were substituted at build time.
CACHE_DIR="${cacheDir}"
CURRENT_WALLPAPER="${currentWallpaper}"
INDEX_FILE="${CACHE_DIR}/current_index.txt"

BASE_URL="https://raw.githubusercontent.com/saint-13/Linux_Dynamic_Wallpapers/main/Dynamic_Wallpapers"
THEME_SUBDIR="${themeSubdir}"
BASE_NAME="${baseName}"
NAMING_PATTERN="${namingPattern}"
EXTENSION="${extension}"
TOTAL_VARIANTS=${totalVariants}

# DEBUGGING
echo $TOTAL_VARIANTS > $HOME/.local/bin/log.txt

current_index() {
  local midnight now elapsed slot_duration index
  midnight=$(date -d "today 00:00:00" +%s)
  now=$(date +%s)
  elapsed=$((now - midnight))
  slot_duration=$((86400 / TOTAL_VARIANTS))
  index=$((elapsed / slot_duration + 1))
  if [ "$index" -gt "$TOTAL_VARIANTS" ]; then
    index="$TOTAL_VARIANTS"
  fi
  echo "$index"
}

mkdir -p "$CACHE_DIR"

INDEX=$(current_index)
echo "Computed wallpaper index: $INDEX" >&2

# Force update if the symlink or index file is missing.
if [ ! -e "$CURRENT_WALLPAPER" ] || [ ! -f "$INDEX_FILE" ]; then
  NEED_UPDATE=true
else
  CURRENT_INDEX=$(cat "$INDEX_FILE")
  if [ "$CURRENT_INDEX" -eq "$INDEX" ]; then
    NEED_UPDATE=false
  else
    NEED_UPDATE=true
  fi
fi

if [ "$NEED_UPDATE" != "true" ]; then
  echo "Wallpaper already up-to-date (index $INDEX). Exiting." >&2
  exit 0
fi

WALLPAPER_FILENAME=$(printf "$NAMING_PATTERN" "$INDEX")
WALLPAPER_FILENAME="${WALLPAPER_FILENAME}.${EXTENSION}"
WALLPAPER_PATH="${CACHE_DIR}/${WALLPAPER_FILENAME}"

if [ ! -f "$WALLPAPER_PATH" ]; then
  WALLPAPER_URL="${BASE_URL}/${THEME_SUBDIR}/${WALLPAPER_FILENAME}?raw=true"
  echo "Downloading wallpaper from: $WALLPAPER_URL" >&2
  if command -v curl >/dev/null; then
    curl -L -o "$WALLPAPER_PATH" "$WALLPAPER_URL"
  elif command -v wget >/dev/null; then
    wget -O "$WALLPAPER_PATH" "$WALLPAPER_URL"
  else
    echo "Error: Neither curl nor wget is available." >&2
    exit 1
  fi
fi

if [ -L "$CURRENT_WALLPAPER" ] || [ -f "$CURRENT_WALLPAPER" ]; then
  rm -f "$CURRENT_WALLPAPER"
fi
ln -s "$WALLPAPER_PATH" "$CURRENT_WALLPAPER"
echo "$INDEX" > "$INDEX_FILE"
echo "Updated wallpaper to index $INDEX: $WALLPAPER_PATH" >&2
EOF
