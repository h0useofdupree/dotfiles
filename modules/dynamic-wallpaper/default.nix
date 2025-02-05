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
    buildPhase = ''
      export PATH = lib.makeBinPath nativeBuildInputs;
      echo "Building dynamic wallpaper script..."
    '';
    # Pass configuration as environment variables (only strings can be passed)
    inherit (config.dynamicWallpaper) cacheDir;
    inherit (config.dynamicWallpaper) currentWallpaper;
    inherit (config.dynamicWallpaper) themeSubdir;
    inherit (config.dynamicWallpaper) baseName;
    inherit (config.dynamicWallpaper) namingPattern;
    inherit (config.dynamicWallpaper) extension;
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
    home.file.".local/bin/dynamic-wallpaper.sh" = {
      source = dynamicWallpaperScriptDrv;
      executable = true;
    };

    systemd.user.services.dynamic-wallpaper = {
      Unit = {
        Description = "Dynamic Wallpaper Updater";
        After = ["graphical-session.target"];
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash ${config.home.homeDirectory}/.local/bin/dynamic-wallpaper.sh";
      };
      Install.WantedBy = ["default.target"];
    };

    systemd.user.timers.dynamic-wallpaper = {
      Unit = {
        Description = "Timer for Dynamic Wallpaper Updater";
      };
      Timer = {
        OnCalendar = config.dynamicWallpaper.updateInterval;
        Persistent = true;
      };
      Install.WantedBy = ["timers.target"];
    };
  };
}
