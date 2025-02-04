{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  dynamicWallpaperScriptDrv = pkgs.stdenv.mkDerivation {
    name = "dynamic-wallpaper.sh";
    # Only the buildPhase is needed.
    phases = ["buildPhase"];
    builder = ./dynamic-wallpaper-builder.sh;
    nativeBuildInputs = [pkgs.coreutils pkgs.curl pkgs.wget pkgs.bash];
    PATH = lib.makeBinPath nativeBuildInputs;
    # Pass configuration as environment variables (only strings can be passed)
    cacheDir = config.dynamicWallpaper.cacheDir;
    currentWallpaper = config.dynamicWallpaper.currentWallpaper;
    themeSubdir = config.dynamicWallpaper.themeSubdir;
    baseName = config.dynamicWallpaper.baseName;
    namingPattern = config.dynamicWallpaper.namingPattern;
    extension = config.dynamicWallpaper.extension;
    totalVariants = builtins.toString config.dynamicWallpaper.totalVariants;
  };
in {
  options.dynamicWallpaper = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable the dynamic wallpaper updater.";
    };

    cacheDir = mkOption {
      type = types.str;
      default = "$HOME/.cache/hyprpaper";
      description = "Cache directory for wallpapers.";
    };

    currentWallpaper = mkOption {
      type = types.str;
      default = "$HOME/.cache/hyprpaper/current_wallpaper";
      description = "Symlink location that hyprpaper uses for the current wallpaper.";
    };

    themeSubdir = mkOption {
      type = types.str;
      default = "ChromeOSWind";
      description = "Subdirectory in the repository for this wallpaper theme.";
    };

    baseName = mkOption {
      type = types.str;
      default = "ChromeOSWind";
      description = "Base name for wallpaper files.";
    };

    namingPattern = mkOption {
      type = types.str;
      default = "ChromeOSWind-%d";
      description = "Filename pattern (must include a %d for the index).";
    };

    extension = mkOption {
      type = types.str;
      default = "png";
      description = "File extension for wallpaper files.";
    };

    totalVariants = mkOption {
      type = types.int;
      default = 3;
      description = "Total number of wallpaper variants.";
    };

    updateInterval = mkOption {
      type = types.str;
      default = "*:0/10";
      description = "Systemd timer OnCalendar value for update frequency.";
    };
  };

  config = mkIf config.dynamicWallpaper.enable {
    # Install the generated dynamic wallpaper script into ~/.local/bin.
    home.file."local/bin/dynamic-wallpaper.sh" = {
      source = dynamicWallpaperScriptDrv;
      mode = "0755";
    };

    # Define the systemd user service.
    systemd.user.services.dynamic-wallpaper = {
      description = "Dynamic Wallpaper Updater";
      # Ensure the service starts after your graphical session is up.
      wantedBy = ["graphical-session.target"];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash ${config.home.homeDirectory}/.local/bin/dynamic-wallpaper.sh";
      };
    };

    # Define the systemd timer.
    systemd.user.timers.dynamic-wallpaper = {
      description = "Timer for Dynamic Wallpaper Updater";
      timerConfig = {
        OnCalendar = config.dynamicWallpaper.updateInterval;
        Persistent = true;
      };
      wantedBy = ["timers.target"];
    };
  };
}
