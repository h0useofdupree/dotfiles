{lib, ...}: {
  options.theme = {
    name = lib.mkOption {
      description = ''
        Name of the theme to use throughout the system.

        This option can be used as a simple "light/dark" switch that does nothing by itself,
        or it can be used by a more elaborate module/theme manager that can switch entire
        programs' themes based on this option.
      '';
      type = lib.types.str;
      example = lib.literalExample "catppuccin-latte";
      default = "dark";
    };

    wallpaper = lib.mkOption {
      description = ''
        Location of the wallpaper to use throughout the system.
      '';
      type = lib.types.path;
      example = lib.literalExample "./wallpaper.png";
    };

    auto = {
      enable = lib.mkEnableOption "automatic light/dark theme switching";

      lightTime = lib.mkOption {
        description = ''
          Time at which automatic theme switching should start using light mode.
        '';
        type = lib.types.str;
        default = "07:00";
        example = lib.literalExample "08:30";
      };

      darkTime = lib.mkOption {
        description = ''
          Time at which automatic theme switching should start using dark mode.
        '';
        type = lib.types.str;
        default = "17:00";
        example = lib.literalExample "18:45";
      };
    };
  };
}
