{
  lib,
  pkgs,
  inputs,
  ...
}: {
  # services.hyprpaper = {
  #   enable = true;
  #   package = inputs.hyprpaper.packages.${pkgs.system}.default;

  #   settings = {
  #     preload = [];
  #     wallpaper = [];
  #   };
  # };

  systemd.user = {
    services.hyprpaper = {
      Unit = {
        After = lib.mkForce "graphical-session.target";
      };
      Service = {
        Type = "simple";
        ExecStart = "${inputs.hyprpaper.packages.${pkgs.system}.default}/bin/hyprpaper";
        ExecReload = "${inputs.hyprpaper.packages.${pkgs.system}.default}/bin/hyprctl reload";
        TimeoutStopSec = "5s";
      };
      Install.WantedBy = ["default.target"];
    };

    services.wallpaper-update = {
      Unit = {
        Description = "Fetch and apply dynamic wallpaper";
        # After = ["graphical-session.target"];
      };
      Service = {
        Type = "oneshot";
        ExecStart = pkgs.writeShellScriptBin "update-wallpaper" ''
          #!/usr/bin/env bash
          set -e  # Exit on error

          BASE_NAME="DesertSands"
          FILE_NAME="DesertSands"
          EXTENSION="png"
          WALLPAPER_DIR="$HOME/.local/share/dynamic-wallpapers/$BASE_NAME"
          WALLPAPER_CACHE="$HOME/.cache/current-wallpaper-path"
          INDEX_FILE="$HOME/.cache/dynamic-wallpaper-index"

          # Get command paths
          SED="${pkgs.coreutils}/bin/sed"
          CAT="${pkgs.coreutils}/bin/cat"
          CURL="${pkgs.curl}/bin/curl"
          HYPRCTL="${inputs.hyprland.packages.${pkgs.system}.default}/bin/hyprctl"

          mkdir -p "$WALLPAPER_DIR"

          # Restore last wallpaper if available
          if [[ -f "$WALLPAPER_CACHE" ]]; then
            echo "Restoring last wallpaper..."
            $HYPRCTL hyprpaper preload "$($CAT "$WALLPAPER_CACHE")"
            $HYPRCTL hyprpaper wallpaper ", $($CAT "$WALLPAPER_CACHE")"
          fi

          HOUR=$(date +%H)
          if (( HOUR >= 6 && HOUR < 10 )); then
            INDEX=1
          elif (( HOUR >= 10 && HOUR < 14 )); then
            INDEX=2
          elif (( HOUR >= 14 && HOUR < 18 )); then
            INDEX=3
          elif (( HOUR >= 18 && HOUR < 22 )); then
            INDEX=4
          else
            INDEX=5
          fi

          WALLPAPER_PATH="$WALLPAPER_DIR/$BASE_NAME-$INDEX.$EXTENSION"
          ENCODED_FILE_NAME="$(echo "$FILE_NAME" | $SED 's/ /%20/g')"
          WALLPAPER_URL="https://github.com/saint-13/Linux_Dynamic_Wallpapers/blob/main/Dynamic_Wallpapers/$BASE_NAME/$ENCODED_FILE_NAME-$INDEX.$EXTENSION?raw=true"

          # Read last index
          if [[ -f "$INDEX_FILE" ]]; then
            LAST_INDEX=$($CAT "$INDEX_FILE")
          else
            LAST_INDEX=""
          fi

          # Skip updating if the index hasn't changed
          if [[ "$LAST_INDEX" == "$INDEX" && -f "$WALLPAPER_CACHE" ]]; then
            echo "No wallpaper change needed (still using index $INDEX)."
            exit 0
          fi

          # Fetch new wallpaper if needed
          if [[ ! -f "$WALLPAPER_PATH" ]]; then
            echo "Fetching new wallpaper: $WALLPAPER_URL"
            $CURL -o "$WALLPAPER_PATH" -L "$WALLPAPER_URL"
          else
            echo "Wallpaper already exists: $WALLPAPER_PATH"
          fi

          # Apply wallpaper
          $HYPRCTL hyprpaper preload "$WALLPAPER_PATH"
          $HYPRCTL hyprpaper wallpaper ", $WALLPAPER_PATH"

          # Save new index and wallpaper path
          echo "$INDEX" > "$INDEX_FILE"
          echo "$WALLPAPER_PATH" > "$WALLPAPER_CACHE"
        '';
      };
      Install.WantedBy = ["default.target"];
    };

    timers.wallpaper-update = {
      Unit = {
        Description = "Run wallpaper update script every 5 minutes";
      };
      Timer = {
        OnCalendar = "*:0/5"; # Every 5 minutes
        Persistent = true;
      };
      Install.WantedBy = ["timers.target"];
    };
  };
}
