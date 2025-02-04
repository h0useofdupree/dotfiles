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

  dynamicWallpaper = {
    enable = true;
    cacheDir = "$HOME/.cache/hyprpaper";
    currentWallpaper = "$HOME/.cache/hyprpaper/current_wallpaper";
    themeSubdir = "DesertSands";
    baseName = "DesertSands";
    namingPattern = "DesertSands-%d";
    extension = "png";
    totalVariants = 5;
    updateInterval = "*:0/10";
  };
}
