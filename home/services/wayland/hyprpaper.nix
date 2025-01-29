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
      };
      Service = {
        Type = "oneshot";
        ExecStart = pkgs.writeShellScript "update-wallpaper" ''
          #!/usr/bin/env bash

          BASE_NAME="DesertSands"
          FILE_NAME="DesertSands"
          EXTENSION="png"
          WALLPAPER_DIR="$HOME/.local/share/dynamic-wallpapers/$BASE_NAME"
          INDEX_FILE="$HOME/.cache/dynamic-wallpaper-index"
          mkdir -p "$WALLPAPER_DIR"

          HOUR=$(date +%H)
          # HOUR=10 # Testing
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

          # If the index hasn't changed, exit to prevent redundant refreshes
          if [[ "$LAST_INDEX" == "$INDEX" ]]; then
            echo "No wallpaper change needed (still using index $INDEX)."
            exit 0
          fi

          # Update wallpaper if a change is detected
          if [[ ! -f "$WALLPAPER_PATH" ]]; then
            echo "Fetching new wallpaper: $WALLPAPER_URL"
            curl -o "$WALLPAPER_PATH" -L "$WALLPAPER_URL"
          else
            echo "Wallpaper already exists: $WALLPAPER_PATH"
          fi

          # Apply wallpaper and store new index
          hyprctl hyprpaper preload "$WALLPAPER_PATH"
          hyprctl hyprpaper wallpaper ", $WALLPAPER_PATH"
          echo "$INDEX" > "$INDEX_FILE"
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
