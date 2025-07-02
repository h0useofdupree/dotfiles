{config, ...}: {
  services.swww.enable = true;
  dynamicWallpaper = {
    enable = true;
    autoLight = true;
    refreshInterval = "30m";
    group = config.home.homeDirectory + "/.local/share/dynamic-wallpapers/WaterHill";
  };
}
