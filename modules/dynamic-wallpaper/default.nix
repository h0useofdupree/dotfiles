{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib; let
  cfg = config.dynamicWallpaper;
  defaultGroup = config.home.homeDirectory + "/.local/share/dynamic-wallpapers/BigSur";
in {
  options.dynamicWallpaper = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable dynamic wallpaper service";
    };

    group = mkOption {
      type = types.str;
      default = defaultGroup;
      description = "Directory containing wallpaper images.";
    };

    autoLight = mkOption {
      type = types.bool;
      default = false;
      description = "Use the lightest wallpaper when GNOME is set to light mode.";
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

    home.sessionVariables = {
      DYNAMIC_WALLPAPER_DIR = cfg.group;
      DYNAMIC_WALLPAPER_AUTO_LIGHT =
        if cfg.autoLight
        then "1"
        else "0";
      DYNAMIC_WALLPAPER_LINK = cfg.currentLink;
    };

    systemd.user.services.dynamic-wallpaper = {
      Unit.Description = "Update dynamic wallpaper";
      Service = {
        Type = "oneshot";
        ExecStart = lib.getExe inputs.self.packages.${pkgs.system}.dynamic-wallpaper;
        Environment = [
          "DYNAMIC_WALLPAPER_DIR=${cfg.group}"
          "DYNAMIC_WALLPAPER_AUTO_LIGHT=${
            if cfg.autoLight
            then "1"
            else "0"
          }"
          "DYNAMIC_WALLPAPER_LINK=${cfg.currentLink}"
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
