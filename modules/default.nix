{
  flake.nixosModules = {
    theme = import ./theme;
    dynamicWallpaper = import ./dynamic-wallpaper;
  };
}
