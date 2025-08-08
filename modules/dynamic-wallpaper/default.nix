{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib; let
  cfg = config.dynamicWallpaper;
  repoWallpapers = "${inputs.self}/lib/wallpapers";
  allowedGroups =
    attrNames (filterAttrs (_: v: v == "directory") (builtins.readDir repoWallpapers));
in {
  options.dynamicWallpaper = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable dynamic wallpaper service";
    };

    group = mkOption {
      type = types.enum allowedGroups;
      default = "Mojave";
      description = "Wallpaper set included in the repository";
    };

    directory = mkOption {
      type = types.nullOr types.path;
      default = null;
      description = "Override directory containing wallpaper images.";
    };

    autoLight = mkOption {
      type = types.bool;
      default = false;
      description = "Use the lightest wallpaper when GNOME is set to light mode.";
    };

    startTime = mkOption {
      type = types.str;
      default = "06:00";
      description = "Start time of the wallpaper cycle (HH:MM).";
    };

    endTime = mkOption {
      type = types.str;
      default = "22:00";
      description = "End time of the wallpaper cycle (HH:MM).";
    };

    refreshInterval = mkOption {
      type = types.str;
      default = "30m";
      description = "How often to refresh the wallpaper.";
    };

    currentLink = mkOption {
      type = types.path;
      default = config.home.homeDirectory + "/.cache/dynamic-wallpaper/current";
      description = "Symlink updated to point at the current wallpaper.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      inputs.self.packages.${pkgs.system}.dynamic-wallpaper
    ];

    home.sessionVariables =
      {
        DYNAMIC_WALLPAPER_AUTO_LIGHT =
          if cfg.autoLight
          then "1"
          else "0";
        DYNAMIC_WALLPAPER_LINK = cfg.currentLink;
        DYNAMIC_WALLPAPER_START = cfg.startTime;
        DYNAMIC_WALLPAPER_END = cfg.endTime;
      }
      // (
        if cfg.directory != null
        then {DYNAMIC_WALLPAPER_DIR = cfg.directory;}
        else {DYNAMIC_WALLPAPER_GROUP = cfg.group;}
      );

    systemd.user.services.dynamic-wallpaper = {
      Unit.Description = "Update dynamic wallpaper";
      Service = {
        Type = "oneshot";
        ExecStart = lib.getExe inputs.self.packages.${pkgs.system}.dynamic-wallpaper;
        Environment = [
          (
            if cfg.directory != null
            then "DYNAMIC_WALLPAPER_DIR=${cfg.directory}"
            else "DYNAMIC_WALLPAPER_GROUP=${cfg.group}"
          )
          "DYNAMIC_WALLPAPER_AUTO_LIGHT=${
            if cfg.autoLight
            then "1"
            else "0"
          }"
          "DYNAMIC_WALLPAPER_LINK=${cfg.currentLink}"
          "DYNAMIC_WALLPAPER_START=${cfg.startTime}"
          "DYNAMIC_WALLPAPER_END=${cfg.endTime}"
        ];
      };
    };

    systemd.user.timers.dynamic-wallpaper = {
      Unit.Description = "Schedule dynamic wallpaper refresh";
      Timer = {
        OnBootSec = "1m";
        OnUnitActiveSec = cfg.refreshInterval;
      };
      Timer.Unit = "dynamic-wallpaper.service";
      Install.WantedBy = ["graphical-session.target"];
    };
  };
}
