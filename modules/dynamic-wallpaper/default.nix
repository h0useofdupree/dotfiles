{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib; let
  cfg = config.dynamicWallpaper;
  # repoWallpapers = "${inputs.self}/lib/wallpapers";
  # allowedGroups =
  #   attrNames (filterAttrs (_: v: v == "directory") (builtins.readDir repoWallpapers));
in {
  options.dynamicWallpaper = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable dynamic wallpaper service";
    };

    group = mkOption {
      type = types.str;
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

    shuffleMode = mkOption {
      type = types.enum ["random" "fixed"];
      default = "random";
      description = "Behavior for groups prefixed with shuffle_.";
    };

    image = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "Image to use when shuffleMode is fixed (filename, stem, or path).";
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
        DYNAMIC_WALLPAPER_SHUFFLE_MODE = cfg.shuffleMode;
        DYNAMIC_WALLPAPERS_ROOT = "${config.home.homeDirectory}/.dotfiles/lib/wallpapers";
      }
      // optionalAttrs (cfg.image != null) {
        DYNAMIC_WALLPAPER_IMAGE = cfg.image;
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
          "DYNAMIC_WALLPAPERS_ROOT=${config.home.homeDirectory}/.dotfiles/lib/wallpapers"
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
          "DYNAMIC_WALLPAPER_SHUFFLE_MODE=${cfg.shuffleMode}"
        ] ++ lib.optionals (cfg.image != null) [
          "DYNAMIC_WALLPAPER_IMAGE=${cfg.image}"
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
