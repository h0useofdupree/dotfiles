{config, ...}: {
  services.swww.enable = true;
  dynamicWallpaper = {
    enable = true;
    autoLight = true;
    refreshInterval = "5m";
    group = config.home.homeDirectory + "/.local/share/dynamic-wallpapers/Mojave";
    # Favorites
    # - DesertSands - 5 images - Ultrawide
    # - Mojave - 16 images - 4K
    # - WaterHill - 2 images - 4K
    # - Ocean - 2 images - 4K
  };
}
