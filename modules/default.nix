{
  flake.nixosModules = {
    theme = import ./theme;
  };
  flake.homeModules = {
    dynamicWallpaper = import ./dynamic-wallpaper;
    speakerctl = import ./speakerctl;
  };
}
