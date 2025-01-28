{
  lib,
  pkgs,
  config,
  ...
}: {
  systemd = {
    user = {
      services.dynamic-wallpaper = {
        Unit = {
          Description = "Fetch and set the dynamic wallpaper based on time";
          After = "graphical-session.target";
        };
        Service = {
          Type = "simple";
          ExecStart = "${config.systemd.user.scripts.dynamicWallpaperScript}";
          TimeoutStopSec = "10s";
        };
        Install.WantedBy = ["default.target"];
      };

      timers.dynamic-wallpaper = {
        Unit.Description = "Run dynamic wallpaper service every 5 minutes";
        Timer = {
          OnCalendar = "*:0/5"; # Every 5 minutes
          Persistent = true;
        };
        Install.WantedBy = ["timers.target"];
      };

      scripts.dynamicWallpaperScript = pkgs.write "dynamic-wallpaper" ''
        #!/usr/bin/env bash

        # Define variables
        BASE_NAME="BigSur"
        FILE_NAME="Big macOS Sur"
        EXTENSION="jpg"
        WALLPAPER_DIR="$HOME/.local/share/dynamic-wallpapers/${BASE_NAME}" # Local folder to store wallpapers
        mkdir -p "$WALLPAPER_DIR" # Ensure the directory exists

        # Time-based logic for choosing the wallpaper
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

        # Set the wallpaper path and URL
        WALLPAPER_PATH="${WALLPAPER_DIR}/${BASE_NAME}-${INDEX}.png"
        WALLPAPER_URL="https://github.com/saint-13/Linux_Dynamic_Wallpapers/blob/main/Dynamic_Wallpapers/${BASE_NAME}/${FILE_NAME}-${INDEX}.${EXTENSION}?raw=true"

        # Check if the wallpaper is already downloaded
        if [[ ! -f "$WALLPAPER_PATH" ]]; then
          echo "Fetching new wallpaper: $WALLPAPER_URL"
          curl -o "$WALLPAPER_PATH" -L "$WALLPAPER_URL"
        else
          echo "Wallpaper already exists: $WALLPAPER_PATH"
        fi

        # Update the wallpaper using hyprctl
        hyprctl hyprpaper unloadall
        hyprctl hyprpaper preload "$WALLPAPER_PATH"
        hyprctl hyprpaper wallpaper ", $WALLPAPER_PATH"
      '';
    };
  };
}
