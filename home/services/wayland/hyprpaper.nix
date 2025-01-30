{
  lib,
  pkgs,
  inputs,
  ...
}: {
  services.hyprpaper = {
    enable = true;
    package = inputs.hyprpaper.packages.${pkgs.system}.default;

    settings = {
      preload = [];
      wallpaper = [];
    };
  };

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
        After = ["hyprpaper.service"];
        Wants = ["hyprpaper.service"];
      };
      Service = {
        Type = "oneshot";
        ExecStart = pkgs.writeShellScript "update-wallpaper" ''
          #!/usr/bin/env bash

          BASE_NAME="DesertSands"
          FILE_NAME="DesertSands"
          EXTENSION="png"
          WALLPAPER_DIR="$HOME/.local/share/dynamic-wallpapers/$BASE_NAME"
          WALLPAPER_CACHE="$HOME/.cache/current-wallpaper-path"
          INDEX_FILE="$HOME/.cache/dynamic-wallpaper-index"
          mkdir -p "$WALLPAPER_DIR"

          # Restore the last wallpaper if it exists (for first boot after reboot)
          if [[ -f "$WALLPAPER_CACHE" ]]; then
            echo "Restoring last used wallpaper..."
            hyprctl hyprpaper preload "$(cat "$WALLPAPER_CACHE")"
            hyprctl hyprpaper wallpaper ", $(cat "$WALLPAPER_CACHE")"
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
          ENCODED_FILE_NAME="$(echo "$FILE_NAME" | sed 's/ /%20/g')"
          WALLPAPER_URL="https://github.com/saint-13/Linux_Dynamic_Wallpapers/blob/main/Dynamic_Wallpapers/$BASE_NAME/$ENCODED_FILE_NAME-$INDEX.$EXTENSION?raw=true"

          # Check the last applied index
          if [[ -f "$INDEX_FILE" ]]; then
            LAST_INDEX=$(cat "$INDEX_FILE")
          else
            LAST_INDEX=""
          fi

          # If the index hasn't changed, but the wallpaper cache is missing, apply the wallpaper
          if [[ "$LAST_INDEX" == "$INDEX" && -f "$WALLPAPER_CACHE" ]]; then
            echo "No wallpaper change needed (still using index $INDEX)."
            exit 0
          fi

          # Fetch new wallpaper if it doesn't exist
          if [[ ! -f "$WALLPAPER_PATH" ]]; then
            echo "Fetching new wallpaper: $WALLPAPER_URL"
            curl -o "$WALLPAPER_PATH" -L "$WALLPAPER_URL"
          else
            echo "Wallpaper already exists: $WALLPAPER_PATH"
          fi

          # Apply the new wallpaper
          hyprctl hyprpaper preload "$WALLPAPER_PATH"
          hyprctl hyprpaper wallpaper ", $WALLPAPER_PATH"

          # Store new index and path
          echo "$INDEX" > "$INDEX_FILE"
          echo "$WALLPAPER_PATH" > "$WALLPAPER_CACHE"
        '';
      };
      Install.WantedBy = ["default.target" "graphical-session.target"];
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
