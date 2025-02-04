{
  flake.nixosModules = {
    theme = import ./theme;
    dynamic-wallpaper = import ./dynamic-wallpaper;
  };
}
