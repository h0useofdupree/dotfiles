{
  pkgs,
  inputs,
  config,
  ...
}: {
  services.hyprpaper = {
    enable = false;
    package = inputs.hyprpaper.packages.${pkgs.system}.default;

    settings = {
      preload = ["${config.theme.wallpaper}"];
      wallpaper = [", ${config.theme.wallpaper}"];
    };
  };
}
